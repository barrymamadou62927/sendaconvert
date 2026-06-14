import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SendaConvert',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF0F0F10),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SendaConvert 💱',
                style: TextStyle(
                  color: Color(0xFFF5A623),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Version 1.0',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 
