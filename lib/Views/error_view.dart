import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ERROR'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Lottie.asset(
                "assets/images/error.json",
                width: 250,
                fit: BoxFit.contain,
              ),
            ),
            const Text(
              'There is some thing wrong, try again',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 300),
          ],
        ),
      ),
      // Container(child: Lottie.asset('assets/images/error.json')),
    );
  }
}
