import 'package:flutter/material.dart';
import 'package:lodgify/ui/styles/app_colors.dart';
import 'package:lodgify/ui/styles/app_fonts.dart';

class ThemeBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ThemeData theme) builder;
  const ThemeBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData getTheme() {
      const colorScheme = ColorScheme.light(
        primary: AppColors.successSemidark,
        onPrimary: AppColors.successLight,
        secondary: AppColors.black,
        onSecondary: AppColors.greyAccentD,
        surface: AppColors.greyScale500,
        onSurface: AppColors.greyAccentC,
        secondaryVariant: AppColors.greyScale900,
        background: AppColors.achromaticWhite,
        onBackground: AppColors.greyAccentE
      );

      return ThemeData(
          colorScheme: colorScheme,
          primaryColor: colorScheme.primary,
          backgroundColor: colorScheme.background,
          canvasColor: colorScheme.background,
          scaffoldBackgroundColor: colorScheme.background,
          textTheme: TextTheme(
            headline1: TextStyle(
              color: colorScheme.secondaryVariant,
              fontFamily: AppFonts.sourceSansProBold,
              fontSize: 22,
            ),
            headline2: TextStyle(
              color: colorScheme.secondaryVariant,
              fontFamily: AppFonts.sourceSansProRegular,
              fontSize: 18,
            ),
            bodyText1: TextStyle(
              color: colorScheme.secondary,
              fontFamily: AppFonts.sourceSansProRegular,
              fontSize: 16,
            ),
            bodyText2: TextStyle(
              color: colorScheme.surface,
              fontFamily: AppFonts.sourceSansProRegular,
              fontSize: 16,
            ),
          ));
    }

    return Builder(
        builder: (context) => builder(
              context,
              getTheme(),
            ));
  }
}
