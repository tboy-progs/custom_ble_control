import 'dart:async';

import 'package:custom_ble_control/component/scan_result_tile.dart';
import 'package:flutter/material.dart';
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
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;

  @override
  void initState() {
    super.initState();

    _scanResultsSubscription = FlutterBluePlus.scanResults.listen(
      (results) {
        _scanResults = results;
        if (mounted) {
          setState(() {});
        }
      },
      onError: (e) {
        print("scan error:$e ");
      },
    );
  }

  @override
  void dispose() {
    _scanResultsSubscription.cancel();
    super.dispose();
  }

  // onScanResultは以前の結果を再送信しない
  Future onScanPressed() async {
    print("scan pressed.");

    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Start scan error")));
    }
    if (mounted) {
      setState(() {});
    }
  }

  List<Widget> _buildScanResultTiles(BuildContext context) {
    return _scanResults
        .map(
          (r) => ScanResultTile(scanResult: r),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ListView(
        children: [
          Container(
            height: 150,
            padding: const EdgeInsets.all(8),
            child: ListView(
              children: [
                ..._buildScanResultTiles(context),
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
