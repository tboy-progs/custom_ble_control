import 'package:custom_ble_control/page/create_control_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 150,
            padding: EdgeInsets.all(8),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text('ESP32-AAA'),
                        Text(
                          '00002AC6-0000-1000-8000-00805F9B34FB',
                          style: TextStyle(fontSize: 8),
                        )
                      ],
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateControlPage()));
                      },
                      child: Text('Info'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Scan BLE Device',
        child: const Icon(Icons.loop),
      ),
    );
  }
}
