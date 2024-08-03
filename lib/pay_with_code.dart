import 'package:flutter/material.dart';

class PayWithCode extends StatelessWidget {
  const PayWithCode({super.key, required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Simple Example')),
      body: Center(child: Text('Pay with code $code')),
    );
  }
}
