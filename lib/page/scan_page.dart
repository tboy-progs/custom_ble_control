import 'dart:async';

import 'package:flutter/material.dart';
import 'package:custom_ble_control/page/create_control_page.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({
    super.key,
  });

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  List<ScanResult> _scanResults = [];
  bool _isScanning = false;
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> _isScanningSubscription;

  @override
  void initState() {
    super.initState();

    _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      _scanResults = results;
      if (mounted) {
        setState(() {});
      }
    }, onError: (e) {});

    _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      _isScanning = state;
      if (mounted) {
        setState(() {});
      }
    });
  }

  Future onScanPressed() async {
    try {
      var subscription = FlutterBluePlus.onScanResults.listen(
        (results) {
          if (results.isNotEmpty) {
            ScanResult r = results.last; // the most recently found device
            if (r.device.advName.isNotEmpty) {
              print(
                  '${r.device.remoteId}: "${r.advertisementData.advName}" found!');
            }
          }
        },
        onError: (e) => print(e),
      );

      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Start scan error")));
    }
    if (mounted) {
      setState(() {});
    }
  }

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
        onPressed: () {
          onScanPressed();
        },
        tooltip: 'Scan BLE Device',
        child: const Icon(Icons.loop),
      ),
    );
  }
}
