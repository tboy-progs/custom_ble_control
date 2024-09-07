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
        onPressed: () {},
        child: Icon(Icons.add),
        tooltip: 'Add Control',
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
