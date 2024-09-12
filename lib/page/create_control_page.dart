import 'package:flutter/material.dart';

class CreateControlPage extends StatelessWidget {
  CreateControlPage({super.key});

  List<String> textList = ['service1', 'service2', 'service3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  Text('DEVICE NAME'),
                  Text('ESP32-AAA'),
                ],
              ),
              Container(
                height: 300,
                child: ListView(
                  children: [
                    Text(textList[0]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
