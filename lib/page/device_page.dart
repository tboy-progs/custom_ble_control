import 'dart:async';

import 'package:custom_ble_control/component/service_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({
    super.key,
    required this.device,
  });

  final BluetoothDevice device;

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  late BluetoothDevice device;
  BluetoothConnectionState _connectionState =
      BluetoothConnectionState.disconnected;

  late StreamSubscription<BluetoothConnectionState>
      _connectionStateSubscription;

  List<BluetoothService> _services = [];

  @override
  void initState() {
    super.initState();

    device = widget.device;

    _connectionStateSubscription = device.connectionState.listen((state) async {
      _connectionState = state;

      if (state == BluetoothConnectionState.connected) {}

      if (state == BluetoothConnectionState.disconnected) {}

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _connectionStateSubscription.cancel();
    super.dispose();
  }

  bool get isConnected {
    return _connectionState == BluetoothConnectionState.connected;
  }

  Widget buildRemoteId() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'BD Address',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            device.remoteId.toString(),
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Future _buildServiceTiles() async {
    try {
      _services = await device.discoverServices();
    } catch (e) {
      print(e);
    }

    for (var element in _services) {
      print(element.serviceUuid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(device.platformName),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(isConnected ? 'DISCONNECT' : 'CONNECT')),
        ],
      ),
      body: Column(
        children: [
          buildRemoteId(),
          OutlinedButton(
            onPressed: () {
              _buildServiceTiles();
            },
            child: Text("get services"),
          ),
        ],
      ),
    );
  }
}
