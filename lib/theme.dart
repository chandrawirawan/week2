import "package:flutter/material.dart";
import 'package:movpedia/utilities/hex_color.dart';

class AppTheme {
  static const pixelMultiplier = 1.0;
  static const appMargin = 12.0 * pixelMultiplier;
  static const avatarSize = 36.0 * pixelMultiplier;
  static const appBarSize = 64.0;

  static const fontFamilyPoppinsExtraBold = "Poppins-ExtraBold";
  static const fontFamilyPoppinsRegular = "Poppins-Regular";
  static const fontFamilyEdmondsansRegular = "Edmondsans-Regular";
  static const fontFamilyEdmondsansMedium = "Edmondsans-Medium";
  static const fontFamilyEdmondsansBold = "Edmondsans-Bold";

  static const colorDarkBlue = Color.fromRGBO(23, 38, 157, 1.0);
  static const colorDarkBlueFont = Color.fromRGBO(4, 24, 138, 1.0);
  static final colorDarkBlueImageSelection = HexColor("#04188A");
  static final colorPrimary = HexColor("#65EF44");
  static const colorDarkGreen = Color.fromRGBO(33, 127, 125, 1.0);
  static const colorLightGreen = Color.fromRGBO(207, 244, 234, 1.0);
  static const colorMintGreen = Color.fromRGBO(54, 207, 166, 1.0);
  static const colorRed = Color.fromRGBO(255, 72, 103, 1.0);
  static const colorShadow = Color.fromRGBO(204, 204, 204, 1.0);
  static const colorTextDisabled = Color.fromRGBO(153, 153, 153, 1.0);
  static const colorTextEnabled = Color.fromRGBO(20, 20, 20, 1.0);
  static const colorTextLink = Color.fromRGBO(74, 144, 226, 1.0);
  static const colorGrey128 = Color.fromRGBO(128, 128, 128, 1.0);
  static const colorGrey128_25 = Color.fromRGBO(128, 128, 128, 0.25);
  static const colorGrey128_50 = Color.fromRGBO(128, 128, 128, 0.5);
  static const colorGrey155 = Color.fromRGBO(155, 155, 155, 1.0);
  static const colorGrey225 = Color.fromRGBO(225, 225, 225, 1.0);
  static const colorGrey241 = Color.fromRGBO(241, 241, 241, 1.0);
  static final colorWhite_50 = Colors.white.withOpacity(0.5);

  static ThemeData get theme {
    return ThemeData.light().copyWith(
      primaryColor: colorPrimary,
      accentColor: Colors.black,
    );
  }

  // TEXT STYLE

  static TextStyle get decorativeHeadingBold {
    return theme.textTheme.headline.copyWith(
      color: colorTextEnabled,
      fontSize: 40,
      fontFamily: fontFamilyPoppinsExtraBold,
      fontStyle: FontStyle.italic
    );
  }

  static TextStyle get decorativeHeading {
    return theme.textTheme.headline.copyWith(
      color: colorTextEnabled,
      fontSize: 40,
      fontFamily: fontFamilyPoppinsRegular,
      fontStyle: FontStyle.italic
    );
  }

  static TextStyle get decorativeHeadingBoldBright {
    return theme.textTheme.headline.copyWith(
      color: Colors.white,
      fontSize: 40,
      fontFamily: fontFamilyPoppinsExtraBold,
      fontStyle: FontStyle.italic
    );
  }

  static TextStyle get headingBoldBright {
    return theme.textTheme.headline.copyWith(
      color: Colors.white,
      fontSize: 25,
      fontFamily: fontFamilyPoppinsExtraBold
    );
  }

  static TextStyle get headingBold {
    return theme.textTheme.headline.copyWith(
      color: colorTextEnabled,
      fontSize: 25,
      fontFamily: fontFamilyPoppinsExtraBold
    );
  }

  static TextStyle get regularBoldBright {
    return theme.textTheme.headline.copyWith(
      color: Colors.white,
      fontSize: 14,
      fontFamily: fontFamilyPoppinsExtraBold
    );
  }

  static TextStyle get regularBold {
    return theme.textTheme.headline.copyWith(
      color: colorTextEnabled,
      fontSize: 14,
      fontFamily: fontFamilyPoppinsExtraBold
    );
  }

  static TextStyle get smallRegularBoldBright {
    return theme.textTheme.headline.copyWith(
      color: Colors.white,
      fontSize: 12,
      fontFamily: fontFamilyPoppinsExtraBold
    );
  }

  static TextStyle get smallRegularBold {
    return theme.textTheme.headline.copyWith(
      color: colorTextEnabled,
      fontSize: 12,
      fontFamily: fontFamilyPoppinsExtraBold
    );
  }

  static TextStyle get regularText {
    return theme.textTheme.headline.copyWith(
      color: colorTextEnabled,
      fontSize: 14,
      fontFamily: fontFamilyPoppinsRegular,
    );
  }

  static TextStyle get regularTextBright {
    return theme.textTheme.headline.copyWith(
      color: Colors.white,
      fontSize: 14,
      fontFamily: fontFamilyPoppinsRegular,
    );
  }

  static TextStyle get menuBarText {
    return theme.textTheme.headline.copyWith(
      color: colorTextEnabled,
      fontSize: 10,
      fontFamily: fontFamilyPoppinsExtraBold,
    );
  }

  static TextStyle get cardHomeTitle {
    return theme.textTheme.headline.copyWith(
      color: colorTextEnabled,
      fontSize: 15,
      fontWeight: FontWeight.bold,
      fontFamily: fontFamilyPoppinsExtraBold,
    );
  }

  static TextStyle get cardSmallHomeTitle {
    return theme.textTheme.headline.copyWith(
      color: colorTextEnabled,
      fontSize: 9,
      fontWeight: FontWeight.bold,
      fontFamily: fontFamilyPoppinsExtraBold,
    );
  }

  static TextStyle get cardHomeDescription {
    return theme.textTheme.headline.copyWith(
      color: colorTextEnabled,
      fontSize: 10,
      fontFamily: fontFamilyPoppinsRegular,
    );
  }

  // INPUT STYLE

  static InputDecorationTheme get inputDecorationEmptyTheme {
    return _inputDecorationTheme(
      baseColor: colorGrey128,
    );
  }

  static InputDecorationTheme get inputDecorationFilledTheme {
    return _inputDecorationTheme(
      baseColor: colorDarkBlueFont,
    );
  }

  static InputDecorationTheme get inputDecorationErrorTheme {
    return _inputDecorationTheme(
      baseColor: colorRed,
    );
  }

  static InputDecorationTheme _inputDecorationTheme({
    baseColor: Color,
    textColor: Color,
  }) {
    return InputDecorationTheme(
      border: OutlineInputBorder(borderSide: BorderSide(color: baseColor)),
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: baseColor)),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: baseColor)),
      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: colorRed)),
      errorStyle: TextStyle(
        fontSize: 12,
        fontFamily: fontFamilyEdmondsansRegular,
        color: colorRed,
      ),
      focusedErrorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: colorRed)),
      labelStyle: TextStyle(
        fontSize: 16,
        fontFamily: fontFamilyEdmondsansMedium,
        color: baseColor,
      ),
      helperStyle: TextStyle(
        fontSize: 12,
        fontFamily: fontFamilyEdmondsansRegular,
        color: colorGrey128,
      ),
    );
  }
}
