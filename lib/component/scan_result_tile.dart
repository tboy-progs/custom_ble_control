import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class ScanResultTile extends StatefulWidget {
  const ScanResultTile({
    super.key,
    required this.scanResult,
    this.onTap,
  });

  final ScanResult scanResult;
  final VoidCallback? onTap;

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

  Text getDeviceName(ScanResult scanResult) {
    return Text(
      scanResult.advertisementData.advName.isEmpty
          ? "No Name"
          : scanResult.advertisementData.advName,
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    );
  }

  Text getBDAddress(ScanResult scanResult) {
    return Text(
      scanResult.device.remoteId.toString(),
      style: TextStyle(fontSize: 8),
    );
  }

  Widget buildConnectButton(BuildContext context) {
    return TextButton(
      child: const Text(
        "CONNECT",
        style: TextStyle(fontSize: 12),
      ),
      onPressed: () {
        (scanResult.advertisementData.connectable) ? widget.onTap : null;
      },
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                getDeviceName(scanResult),
                getBDAddress(scanResult),
              ],
            ),
            buildConnectButton(context),
          ],
        ),
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
