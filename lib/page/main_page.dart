import 'package:custom_ble_control/page/create_control_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _listViewItem("send button 01", "send"),
          _listViewItem("send button 01", "send"),
          _listViewItem("send button 01", "send"),
          _listViewItem("send button 01", "send"),
          _listViewItem("send button 01", "send"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateControlPage()));
        },
        tooltip: 'Add Control',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _listViewItem(String title, String buttonText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(title),
        OutlinedButton(
          onPressed: () {},
          child: Text(buttonText),
        ),
      ],
    );
  }
}
