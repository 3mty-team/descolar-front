import 'package:flutter/material.dart';

class DeviceInfo {
  double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
