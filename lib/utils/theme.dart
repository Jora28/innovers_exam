import 'package:flutter/material.dart';
import 'package:innovers_exam/utils/styles.dart';
import 'package:innovers_exam/utils/text_styles.dart';

import 'colors.dart';

const _smallTextScaleFactor = 0.80;

/// Namespace for the Innovers Exam [ThemeData].
class DefaultTheme {
  /// Standard `ThemeData` for Innovers Exam UI.
  static ThemeData get standard {
    return ThemeData(
    
      // highlightColor: AppColors.orange,
      // colorScheme: ColorScheme.fromSwatch(accentColor: AppColors.blueDeep),
      // appBarTheme: _appBarTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      // outlinedButtonTheme: _outlinedButtonTheme,
      textTheme: _textTheme,
      dialogBackgroundColor: AppColors.white,
      dialogTheme: _dialogTheme,
      // tooltipTheme: _tooltipTheme,
      bottomSheetTheme: _bottomSheetTheme,
      // tabBarTheme: _tabBarTheme,
      dividerTheme: _dividerTheme,
    );
  }



  static TextTheme get _textTheme {
    return TextTheme(
      headline1: AppTextStyle.headline1,
      headline2: AppTextStyle.headline2,
      headline3: AppTextStyle.headline3,
      headline4: AppTextStyle.headline4,
      headline5: AppTextStyle.headline5,
      headline6: AppTextStyle.headline6,
      subtitle1: AppTextStyle.subtitle1,
      subtitle2: AppTextStyle.subtitle2,
      bodyText1: AppTextStyle.bodyText1,
      bodyText2: AppTextStyle.bodyText2,
      caption: AppTextStyle.caption,
      overline: AppTextStyle.overline,
      button: AppTextStyle.button,
    );
  }



  // static AppBarTheme get _appBarTheme {
  //   return const AppBarTheme(color: AppColors.blueDeep);
  // }

  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: Corners.smBorder,
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        primary: AppColors.blue,
       // minimumSize: const Size(208, 54),
      ),
    );
  }

  // static OutlinedButtonThemeData get _outlinedButtonTheme {
  //   return OutlinedButtonThemeData(
  //     style: OutlinedButton.styleFrom(
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(30)),
  //       ),
  //       side: const BorderSide(color: AppColors.white, width: 2),
  //       padding: const EdgeInsets.symmetric(vertical: 16),
  //       primary: AppColors.white,
  //       minimumSize: const Size(208, 54),
  //     ),
  //   );
  // }

  // static TooltipThemeData get _tooltipTheme {
  //   return const TooltipThemeData(
  //     decoration: BoxDecoration(
  //       color: AppColors.greyDeep,
  //       borderRadius: BorderRadius.all(Radius.circular(5)),
  //     ),
  //     padding: EdgeInsets.all(10),
  //     textStyle: TextStyle(color: AppColors.white),
  //   );
  // }

  static DialogTheme get _dialogTheme {
    return DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  static BottomSheetThemeData get _bottomSheetTheme {
    return const BottomSheetThemeData(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
    );
  }

  static DividerThemeData get _dividerTheme {
    return const DividerThemeData(
      space: 0,
      thickness: 1,
      color: AppColors.grey,
    );
  }
}
