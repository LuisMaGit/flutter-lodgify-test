import 'package:flutter/material.dart';

enum StyleType {
  h1,
  h2,
  b1,
  b2,
}

class AppText extends StatelessWidget {
  final String text;
  final StyleType styleType;
  final Color? color;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double? fontSize;
  final TextAlign? align;
  final int? maxLines;

  const AppText.h1(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.fontWeight,
    this.fontSize,
    this.fontFamily,
    this.align,
  })  : styleType = StyleType.h1,
        super(key: key);
  const AppText.h2(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.fontWeight,
    this.fontSize,
    this.fontFamily,
    this.align,
  })  : styleType = StyleType.h2,
        super(key: key);
  const AppText.b1(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.fontWeight,
    this.fontSize,
    this.fontFamily,
    this.align,
  })  : styleType = StyleType.b1,
        super(key: key);
  const AppText.b2(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.fontWeight,
    this.fontSize,
    this.fontFamily,
    this.align,
  })  : styleType = StyleType.b2,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle? getStyle() {
      switch (styleType) {
        case StyleType.h1:
          return Theme.of(context).textTheme.headline1;
        case StyleType.h2:
          return Theme.of(context).textTheme.headline2;
        case StyleType.b1:
          return Theme.of(context).textTheme.bodyText1;
        case StyleType.b2:
          return Theme.of(context).textTheme.bodyText2;
        default:
      }
    }

    return Text(
      text,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      maxLines: maxLines,
      textAlign: align ?? TextAlign.left,
      style: getStyle()!.copyWith(
        color: color ?? getStyle()!.color,
        fontWeight: fontWeight ?? getStyle()!.fontWeight,
        fontSize: fontSize ?? getStyle()!.fontSize,
        fontFamily: fontFamily ?? getStyle()!.fontFamily,
      ),
    );
  }
}
