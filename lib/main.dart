import 'package:dio/dio.dart';
import 'package:fatortak/model/payment_method_model.dart';
import 'package:fatortak/model/visa_response_model.dart';
import 'package:fatortak/pay_with_code.dart';
import 'package:fatortak/web_view.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'model/payment_data_msary.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  PaymentMethod? paymentMethod;
  VisaResponseModel? visaResponseModel;
  MsaaryModel? msaaryModel;
  String accessToken = 'd83a5d07aaeb8442dcbe259e6dae80a3f2e21a3a581e1a5acd';

  Future<void> getPaymentMethod() async {
    setState(() {
      isLoading = true;
    });
    const apiUrl = 'https://staging.fawaterk.com/api/v2/getPaymentmethods';
    Dio dio = Dio(
      BaseOptions(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    dio.interceptors.add(PrettyDioLogger());

    try {
      var respone = await dio.get(apiUrl);
      paymentMethod = PaymentMethod.fromJson(respone.data);
    } catch (e) {
      throw Exception(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> processPaymentMethod(int paymentMethodID) async {
    Dio dio = Dio(
      BaseOptions(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    dio.interceptors.add(PrettyDioLogger());
    final apiUrl = 'https://staging.fawaterk.com/api/v2/invoiceInitPay';

    try {
      final requestData = {
        'payment_method_id': paymentMethodID,
        'cartTotal': '100',
        'currency': 'EGP',
        'customer': {
          'first_name': 'test',
          'last_name': 'test',
          'email': 'test@test.test',
          'phone': '01000000000',
          'address': 'test address',
        },
        'redirectionUrls': {
          'successUrl':
              'https://c8da-154-178-61-85.ngrok-free.app/api/v1/transactions/success',
          'failUrl':
              'https://c8da-154-178-61-85.ngrok-free.app/api/v1/transactions/fail',
          'pendingUrl':
              'https://c8da-154-178-61-85.ngrok-free.app/api/v1/transactions/pending',
        },
        'cartItems': [
          {
            'name': 'test',
            'price': '100',
            'quantity': '1',
          },
        ],
      };
      var response = await dio.post(apiUrl, data: requestData);
      if (paymentMethodID == 2) {
        visaResponseModel = VisaResponseModel.fromJson(response.data);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                WebView(url: visaResponseModel!.data!.paymentData!.redirectTo!),
          ),
        );
      } else if (paymentMethodID == 14) {
        msaaryModel = MsaaryModel.fromJson(response.data);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PayWithCode(
              code: msaaryModel!.data.paymentData.masaryCode.toString(),
            ),
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void initState() {
    getPaymentMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: paymentMethod!.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      processPaymentMethod(
                          paymentMethod!.data![index].paymentId!);
                    },
                    title: Text(paymentMethod!.data![index].nameEn!),
                    subtitle: Text(paymentMethod!.data![index].nameAr!),
                    leading: Image.network(paymentMethod!.data![index].logo!),
                  );
                },
              ));
  }
}
