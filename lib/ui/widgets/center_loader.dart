import 'package:flutter/material.dart';

class CenterLoader extends StatelessWidget {
  const CenterLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        Theme.of(context).colorScheme.primary,
      ),
    ));
  }
}
