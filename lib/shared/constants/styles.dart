import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';


class BorderStyles {
  static Border borderGrey =
      Border.all(color: Colors.grey.withOpacity(0.4), width: 1.5);

  static OutlineInputBorder enableTextField = OutlineInputBorder(
    borderSide:
        BorderSide(color: AppColor.neutral.shade300, width: Strokes.xthin),
    borderRadius: Corners.xxlBorder,
  );

  static OutlineInputBorder focusTextField = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColor.primary, width: Strokes.thin),
    borderRadius: Corners.xxlBorder,
  );

  static OutlineInputBorder disableTextField = OutlineInputBorder(
    borderSide:
        BorderSide(color: AppColor.neutral.shade300, width: Strokes.xthin),
    borderRadius: Corners.xxlBorder,
  );

  static OutlineInputBorder errorTextField = OutlineInputBorder(
    borderSide:
        const BorderSide(color: AppColor.errorColor, width: Strokes.thin),
    borderRadius: Corners.xxlBorder,
  );
}

InputDecoration inputDecoration(
    {required String hintText, Widget? prefixIcon, Widget? suffixIcon}) {
  return InputDecoration(
      isDense: true,
      filled: true,
      fillColor: AppColor.neutral.shade100,
      contentPadding:
          EdgeInsets.symmetric(horizontal: Insets.med, vertical: Insets.med),
      hintText: hintText,
      border: BorderStyles.enableTextField,
      focusedBorder: BorderStyles.focusTextField,
      enabledBorder: BorderStyles.enableTextField,
      errorBorder: BorderStyles.errorTextField,
      disabledBorder: BorderStyles.disableTextField,
      errorMaxLines: 5,
      prefixIcon: prefixIcon,
      prefixIconConstraints:
          BoxConstraints(minHeight: Sizes.lg, minWidth: Sizes.xl),
      suffixIconConstraints:
          BoxConstraints(minHeight: Sizes.lg, minWidth: Sizes.xl),
      suffixIcon: suffixIcon,
      hintStyle:
          TextStyles.textBase.copyWith(color: AppColor.neutral.shade500));
}

Widget verticalSpace(double v) {
  return SizedBox(height: v);
}

Widget horizontalSpace(double v) {
  return SizedBox(width: v);
}

/// Used for all animations in the app
class Times {
  static const Duration fastest = Duration(milliseconds: 150);
  static const fast = Duration(milliseconds: 250);
  static const medium = Duration(milliseconds: 350);
  static const slow = Duration(milliseconds: 700);
  static const slower = Duration(milliseconds: 1000);
}

class Sizes {
  static double get xs => 8.w;
  static double get sm => 12.w;
  static double get med => 20.w;
  static double get lg => 32.w;
  static double get xl => 48.w;
  static double get xxl => 80.w;
}

class IconSizes {
  static double get sm => 16.w;
  static double get med => 24.w;
  static double get lg => 32.w;
  static double get xl => 48.w;
  static double get xxl => 60.w;
}

class Insets {
  static double offsetScale = 1;
  static double get xs => 4.w;
  static double get sm => 8.w;
  static double get med => 12.w;
  static double get lg => 16.w;
  static double get xl => 20.w;
  static double get xxl => 32.w;
  // Offset, used for the edge of the window, or to separate large sections in the app
  static double get offset => 40 * offsetScale;
}

class Corners {
  static double sm = 3.w;
  static BorderRadius smBorder = BorderRadius.all(smRadius);
  static Radius smRadius = Radius.circular(sm);

  static double med = 5.w;
  static BorderRadius medBorder = BorderRadius.all(medRadius);
  static Radius medRadius = Radius.circular(med);

  static double lg = 8.w;
  static BorderRadius lgBorder = BorderRadius.all(lgRadius);
  static Radius lgRadius = Radius.circular(lg);

  static double xl = 16.w;
  static BorderRadius xlBorder = BorderRadius.all(xlRadius);
  static Radius xlRadius = Radius.circular(xl);

  static double xxl = 40.w;
  static BorderRadius xxlBorder = BorderRadius.all(xxlRadius);
  static Radius xxlRadius = Radius.circular(xxl);
}

class Strokes {
  static const double xthin = 0.7;
  static const double thin = 1;
  static const double med = 2;
  static const double thick = 4;
}

class Shadows {
  static List<BoxShadow> get universal => [
        BoxShadow(
            color: const Color(0xff333333).withOpacity(.13),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 5)),
      ];
  static List<BoxShadow> get small => [
        BoxShadow(
            color: const Color(0xff333333).withOpacity(.15),
            spreadRadius: 0,
            blurRadius: 3,
            offset: const Offset(0, 1)),
      ];
  static List<BoxShadow> get none => [
        BoxShadow(
            color: AppColor.neutral.shade50,
            spreadRadius: 0,
            blurRadius: 0,
            offset: const Offset(0, 0)),
      ];

  static List<BoxShadow> get shadowsUp => [
        BoxShadow(
            color: const Color(0xff333333).withOpacity(.15),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(-1, 0)),
      ];
}

/// Font Sizes
/// You can use these directly if you need, but usually there should be a predefined style in TextStyles.
class FontSizes {
  /// Provides the ability to nudge the app-wide font scale in either direction
  static double get s9 => 9.w;
  static double get s10 => 10.w;
  static double get s11 => 11.w;
  static double get s12 => 12.w;
  static double get s14 => 14.w;
  static double get s16 => 16.w;
  static double get s18 => 18.w;
  static double get s20 => 20.w;
  static double get s24 => 24.w;
  static double get s26 => 26.w;
  static double get s32 => 32.w;
  static double get s36 => 36.w;
  static double get s40 => 40.w;
  static double get s48 => 48.w;
  static double get s56 => 56.w;
}

/// Fonts - A list of Font Families, this is uses by the TextStyles class to create concrete styles.

/// TextStyles - All the core text styles for the app should be declared here.
/// Don't try and create every variant in existence here, just the high level ones.
/// More specific variants can be created on the fly using `style.copyWith()`
/// `newStyle = TextStyles.body1.copyWith(lineHeight: 2, color: Colors.red)`
class TextStyles {
  /// Declare a base style for each Family
  static const TextStyle inter =
      TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Roboto');

  static TextStyle get h1 => inter.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: FontSizes.s56,
      letterSpacing: -1,
      height: 1.17);
  static TextStyle get h2 =>
      h1.copyWith(fontSize: FontSizes.s40, letterSpacing: -.5, height: 1.16);
  static TextStyle get h3 => h1.copyWith(
        fontSize: FontSizes.s32,
        letterSpacing: -.05,
        height: 1.29,
      );
  static TextStyle get h4 => h1.copyWith(fontSize: FontSizes.s26);
  static TextStyle get h5 => h1.copyWith(fontSize: FontSizes.s20);
  static TextStyle get h6 => h3.copyWith(fontSize: FontSizes.s18);
  static TextStyle get subtitle1 => inter.copyWith(
      fontWeight: FontWeight.bold, fontSize: FontSizes.s16, height: 1.31);
  static TextStyle get subtitle2 => subtitle1.copyWith(
      fontWeight: FontWeight.w700, fontSize: FontSizes.s14, height: 1.36);
  static TextStyle get subtitle3 => inter.copyWith(
      fontWeight: FontWeight.normal, fontSize: FontSizes.s14, height: 1.31);
  static TextStyle get body1 => inter.copyWith(
      fontWeight: FontWeight.normal, fontSize: FontSizes.s16, height: 1.71);
  static TextStyle get body2 =>
      body1.copyWith(fontSize: FontSizes.s14, height: 1.5, letterSpacing: .2);
  static TextStyle get small1 => inter.copyWith(
        fontSize: FontSizes.s12,
        fontWeight: FontWeight.normal,
        height: 1.15,
      );
  static TextStyle get small2 => inter.copyWith(
      fontSize: FontSizes.s10, fontWeight: FontWeight.normal, height: 1.2);
  static TextStyle get callout1 => inter.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: FontSizes.s12,
      height: 1.17,
      letterSpacing: .5);
  static TextStyle get callout2 =>
      callout1.copyWith(fontSize: FontSizes.s10, height: 1, letterSpacing: .25);
  static TextStyle get callout3 =>
      callout1.copyWith(fontSize: FontSizes.s9, height: 1, letterSpacing: .25);
  static TextStyle get caption => inter.copyWith(
      fontWeight: FontWeight.w500, fontSize: FontSizes.s11, height: 1.36);
  static TextStyle get button => inter.copyWith(
      fontWeight: FontWeight.bold, fontSize: FontSizes.s14, height: 1.71);

  static TextStyle get saldo48 =>
      inter.copyWith(fontWeight: FontWeight.w700, fontSize: FontSizes.s48);
  static TextStyle get saldo36 => saldo48.copyWith(fontSize: FontSizes.s36);
  static TextStyle get saldo24 => saldo48.copyWith(fontSize: FontSizes.s24);
  static TextStyle get saldo18 => saldo48.copyWith(fontSize: FontSizes.s18);
  static TextStyle get saldo14 => saldo48.copyWith(fontSize: FontSizes.s14);
  static TextStyle get saldo12 => saldo48.copyWith(fontSize: FontSizes.s12);

  static TextStyle get text3xl => inter.copyWith(fontSize: FontSizes.s40);
  static TextStyle get text3xlBold =>
      text3xl.copyWith(fontWeight: FontWeight.w700);
  static TextStyle get text2xs => inter.copyWith(fontSize: FontSizes.s10);
  static TextStyle get textXs => inter.copyWith(fontSize: FontSizes.s12);
  static TextStyle get textXsBold =>
      textXs.copyWith(fontWeight: FontWeight.w700);
  static TextStyle get textSm => inter.copyWith(fontSize: FontSizes.s14);
  static TextStyle get textBase => inter.copyWith(fontSize: FontSizes.s16);
  static TextStyle get textBaseBold =>
      textBase.copyWith(fontWeight: FontWeight.w700);
  static TextStyle get textLg => inter.copyWith(fontSize: FontSizes.s20);
  static TextStyle get textLgBold =>
      textLg.copyWith(fontWeight: FontWeight.w700, height: 1.4);
  static TextStyle get textXl => inter.copyWith(fontSize: FontSizes.s24);
  static TextStyle get textXlBold =>
      textXl.copyWith(fontWeight: FontWeight.w700, height: 1.25);
  static TextStyle get text2xl => inter.copyWith(fontSize: FontSizes.s32);
  static TextStyle get text2xlBold =>
      text2xl.copyWith(fontWeight: FontWeight.w700);
}

class Borders {
  static const BorderSide universalBorder = BorderSide(
    color: AppColor.neutral,
    width: 1,
  );

  static const BorderSide smallBorder = BorderSide(
    color: AppColor.neutral,
    width: 0.5,
  );

  static BoxDecoration borderPin({
    Color? borderColor,
    double? strokeWidth,
  }) {
    return BoxDecoration(
        color: AppColor.neutral.shade100,
        borderRadius: Corners.lgBorder,
        border: Border.all(
          width: strokeWidth ?? Strokes.xthin,
          color: borderColor ?? AppColor.neutral.shade300,
        ));
  }
}
