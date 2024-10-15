import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class ScanResultTile extends StatefulWidget {
  const ScanResultTile({
    super.key,
    required this.result,
  });

  final ScanResult result;

  @override
  State<ScanResultTile> createState() => _ScanResultTileState();
}

class _ScanResultTileState extends State<ScanResultTile> {
  late ScanResult result;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this.result = widget.result;
  }

  Widget _buildTitle(BuildContext context) {
    if (result.advertisementData.advName.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(result.advertisementData.advName),
        ],
      );
    } else {
      return Text(widget.result.device.remoteId.str);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: _buildTitle(context),
    );
  }
}
