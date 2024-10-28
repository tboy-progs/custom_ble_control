import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class ScanResultTile extends StatefulWidget {
  const ScanResultTile({
    super.key,
    required this.scanResult,
  });

  final ScanResult scanResult;

  @override
  State<ScanResultTile> createState() => _ScanResultTileState();
}

class _ScanResultTileState extends State<ScanResultTile> {
  late ScanResult scanResult;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scanResult = widget.scanResult;
  }

  String getDeviceName(ScanResult scanResult) {
    return scanResult.advertisementData.advName.isEmpty
        ? "No Name"
        : scanResult.advertisementData.advName;
  }

  String getBDAddress(ScanResult scanResult) {
    return scanResult.device.remoteId.toString();
  }

  Widget buildConnectButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: const Text("CONNECT"),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Device Name: ${getDeviceName(scanResult)}",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "BD Address: ${getBDAddress(scanResult)}",
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 25),
          ],
        ),
        buildConnectButton(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitle(context),
      ],
    );
  }
}

// 