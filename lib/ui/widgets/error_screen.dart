import 'package:flutter/material.dart';
import 'package:lodgify/ui/resources/app_strings.dart';
import 'package:lodgify/ui/widgets/app_spacer.dart';
import 'package:lodgify/ui/widgets/app_texts.dart';
import 'package:lodgify/ui/widgets/ripple_button.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback tryAgain;
  const ErrorScreen({
    Key? key,
    required this.tryAgain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.secondary,
          ),
          AppSpacers.v10,
          const AppText.h2(AppStrings.errorScreenTitle),
          AppSpacers.v20,
          RippleButton(
            child: AppText.b1(
              AppStrings.errorScreenTryAgain,
              color: Theme.of(context).colorScheme.primary,
            ),
            onTap: tryAgain,
          )
        ],
      ),
    );
  }
}
