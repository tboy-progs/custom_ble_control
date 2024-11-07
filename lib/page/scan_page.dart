import 'dart:async';
import 'dart:developer';

import 'package:custom_ble_control/component/scan_result_tile.dart';
import 'package:custom_ble_control/utils/extra.dart';
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
        log("scan error:$e ");
      },
    );
  }

  @override
  void dispose() {
    _scanResultsSubscription.cancel();
    super.dispose();
  }

  Future onScanPressed() async {
    log("scan pressed.");

    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    } catch (e) {
      log("start scan error.");
    }
    if (mounted) {
      setState(() {});
    }
  }

  List<Widget> _buildScanResultTiles(BuildContext context) {
    return _scanResults
        .map(
          (r) => ScanResultTile(
            scanResult: r,
            onTap: () => onConnectPressed(r.device),
          ),
        )
        .toList();
  }

  void onConnectPressed(BluetoothDevice device) {
    try {
      device.connectAndUpdateStream().catchError((e) {
        log("connect failed...");
        if (e is FlutterBluePlusException) {
          log("${e.description}");
        }
      });
      device.connect();
      log('connect success.');
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        children: [
          ..._buildScanResultTiles(context),
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
