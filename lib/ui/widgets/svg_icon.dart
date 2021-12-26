import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lodgify/ui/styles/app_constants.dart';

class SvgIcon extends StatelessWidget {
  final double size;
  final String asset;
  const SvgIcon(
    this.asset, {
    Key? key,
    this.size = kIconsSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: SvgPicture.asset(asset),
    );
  }
}
