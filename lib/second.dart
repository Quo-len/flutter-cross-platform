import 'package:flutter/material.dart';

class MySecondApp extends StatelessWidget {
  const MySecondApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
          // Add your onPressed logic here
          Navigator.pop(context);
        },
        child: const Text('Back'),
      ),
    );
  }
}
