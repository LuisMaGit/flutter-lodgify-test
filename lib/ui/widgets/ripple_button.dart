import 'package:flutter/material.dart';

class RippleButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final void Function() onTap;

  const RippleButton({
    Key? key,
    required this.child,
    required this.onTap,
    this.color = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }
}
