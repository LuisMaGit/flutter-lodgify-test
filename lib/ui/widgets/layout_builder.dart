import 'package:flutter/material.dart';

enum DeviceType {
  mobile,
  desktop,
}

class ResponsiveBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget? desktop;
  const ResponsiveBuilder({
    Key? key,
    required this.mobile,
    this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ScreenSizeBuilder(
      builder: (context, deviceType) {
        if (deviceType == DeviceType.desktop) {
          if (desktop != null) return desktop!;
        }

        return mobile;
      },
    );
  }
}

class _ScreenSizeBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceType device) builder;

  const _ScreenSizeBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeviceType getDeviceType() {
      final w = MediaQuery.of(context).size.width;

      if (w >= 720) {
        return DeviceType.desktop;
      }

      return DeviceType.mobile;
    }

    return builder(context, getDeviceType());
  }
}
