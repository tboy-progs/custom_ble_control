import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('custom ble control'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}
