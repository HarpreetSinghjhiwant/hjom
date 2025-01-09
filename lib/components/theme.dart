import 'package:flutter/material.dart';

String _appTheme = "lightCode";
LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

// Extension for font styles
extension TextStyleExt on TextStyle {
  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }

  TextStyle get roboto {
    return copyWith(
      fontFamily: 'Roboto',
    );
  }
}

// Extension for sizing
extension SizeExtension on num {
  double get fSize => toDouble();
}

// Extension for Color alpha values
extension ColorExtension on Color {
  Color withValues({int? alpha}) {
    return withOpacity(alpha != null ? alpha / 255 : 1);
  }
}

/// A collection of pre-defined text styles for customizing text appearance
class CustomTextStyles {
  static TextStyle get bodyLarge18 => theme.textTheme.bodyLarge?.copyWith(
    fontSize: 18.fSize,
  ) ?? TextStyle(fontSize: 18.fSize);

  static TextStyle get bodyLargeGray50003 => theme.textTheme.bodyLarge?.copyWith(
    color: appTheme.gray50003,
  ) ?? TextStyle(color: appTheme.gray50003);
  static TextStyle get bodyLargeGray60001 => theme.textTheme.bodyLarge!.copyWith(
    color: appTheme.gray60001,
  );
  static TextStyle get bodyLargeGray700 => theme.textTheme.bodyLarge!.copyWith(
    color: appTheme.gray700,
  );
  static TextStyle get bodyLargeLight => theme.textTheme.bodyLarge!.copyWith(
    fontWeight: FontWeight.w300,
  );
  static TextStyle get bodyLargePoppinsGray50001 =>
      theme.textTheme.bodyLarge!.poppins.copyWith(
        color: appTheme.gray50001,
      );
  static TextStyle get bodyLargePoppinsOnPrimary =>
      theme.textTheme.bodyLarge!.poppins.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 17.fSize,
      );
  static TextStyle get bodyLargePrimary => theme.textTheme.bodyLarge!.copyWith(
    color: theme.colorScheme.primary,
    fontSize: 18.fSize,
  );
  static TextStyle get bodyMediumGray50004 => theme.textTheme.bodyMedium!.copyWith(
    color: appTheme.gray50004,
  );
  static TextStyle get bodyMediumGray600 => theme.textTheme.bodyMedium!.copyWith(
    color: appTheme.gray600.withValues(
      alpha: 0x72,
    ),
    fontSize: 15.fSize,
  );
  static TextStyle get bodyMediumOnPrimary => theme.textTheme.bodyMedium!.copyWith(
    color: theme.colorScheme.onPrimary,
    fontSize: 15.fSize,
  );
  static TextStyle get bodyMediumPrimary => theme.textTheme.bodyMedium!.copyWith(
    color: theme.colorScheme.primary,
  );
  static TextStyle get bodyMediumRobotoBluegray400 =>
      theme.textTheme.bodyMedium!.roboto.copyWith(
        color: appTheme.blueGray400,
        fontSize: 15.fSize,
      );
  static TextStyle get bodyMediumRobotoPrimary =>
      theme.textTheme.bodyMedium!.roboto.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 15.fSize,
      );
  static TextStyle get bodySmallGray50001 => theme.textTheme.bodySmall!.copyWith(
    color: appTheme.gray50001,
    fontSize: 11.fSize,
  );
  static TextStyle get bodySmallGray50001_1 => theme.textTheme.bodySmall!.copyWith(
    color: appTheme.gray50001,
  );
  static TextStyle get bodySmallGray50002 => theme.textTheme.bodySmall!.copyWith(
    color: appTheme.gray50002,
  );
  // Title text style
  static TextStyle get titleLargePrimary => theme.textTheme.titleLarge!.copyWith(
    color: theme.colorScheme.primary,
    fontSize: 22.fSize,
  );
}

/// Helper class for managing themes and colors
class ThemeHelper {
  // A map of custom color themes supported by the app
  final Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

  // A map of color schemes supported by the app
  final Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Changes the app theme to [newTheme]
  void changeTheme(String newTheme) {
    _appTheme = newTheme;
  }

  /// Returns the theme colors for the current theme
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          side: BorderSide(
            color: appTheme.blueGray10003,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: appTheme.gray400,
      ),
    );
  }

  /// Returns the theme colors for the current theme
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
    bodyLarge: TextStyle(
      color: appTheme.blueGray400,
      fontSize: 16.fSize,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
    ).copyWith(),  // Remove force unwrap
    bodyMedium: TextStyle(
      color: appTheme.gray50001,
      fontSize: 14.fSize,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
    ).copyWith(),  // Remove force unwrap
    titleLarge: TextStyle(
      color: appTheme.gray600,
      fontSize: 20.fSize,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
    ).copyWith(),  // Remove force unwrap
  );
}

/// Class containing the supported color schemes
class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light(
    primary: const Color(0XFF6D50CE),
    onPrimary: const Color(0XFFFFFFFF),
    onPrimaryContainer: const Color(0X19FF0000),
  );
}

/// Class containing custom colors for a lightCode theme
class LightCodeColors {
  // Black
  Color get black9001c => const Color(0X1C000000);
  // BlueGray
  Color get blueGray100 => const Color(0XFFD3D3D3);
  Color get blueGray10001 => const Color(0XFFD1D1D1);
  Color get blueGray10002 => const Color(0XFFD6D6D6);
  Color get blueGray10003 => const Color(0XFFD5D5D5);
  Color get blueGray10004 => const Color(0XFFD2D2D2);
  Color get blueGray400 => const Color(0XFF868686);
  // Gray
  Color get gray100 => const Color(0XFFF5F5F5);
  Color get gray200 => const Color(0XFFE7E7E7);
  Color get gray400 => const Color(0XFFCACACA);
  Color get gray40001 => const Color(0XFFB3B3B3);
  Color get gray50 => const Color(0XFFF9F9F9);
  Color get gray500 => const Color(0XFF979797);
  Color get gray50001 => const Color(0XFF999999);
  Color get gray50002 => const Color(0XFFA8A8A8);
  Color get gray50003 => const Color(0XFF939393);
  Color get gray50004 => const Color(0XFF929292);
  Color get gray50005 => const Color(0XFF969696);
  Color get gray5001 => const Color(0XFFF8F8F8);
  Color get gray600 => const Color(0XFF717171);
  Color get gray60001 => const Color(0XFF757575);
  Color get gray700 => const Color(0XFF666666);
  // Red
  Color get red900 => const Color(0XFF9C0000);
}

/// Class containing app decorations
class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillOnPrimary => BoxDecoration(
    color: theme.colorScheme.onPrimary,
  );
  // Outline decorations
  static BoxDecoration get outlineBlueGray => BoxDecoration(
    color: theme.colorScheme.onPrimary,
    border: Border.all(
      color: appTheme.blueGray10001,
      width: 1,
    ),
  );
  static BoxDecoration get outlineBluegray10004 => BoxDecoration(
    color: theme.colorScheme.onPrimary,
    border: Border.all(
      color: appTheme.blueGray10004,
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: appTheme.black9001c.withValues(
          alpha: 0x40,
        ),
        spreadRadius: 2,
        blurRadius: 2,
        offset: const Offset(0, 0),
      ),
    ],
  );
  static BoxDecoration get outlineGray => BoxDecoration(
    color: appTheme.gray50,
    border: Border.all(
      color: appTheme.gray200,
      width: 1,
    ),
  );
  static BoxDecoration get outlineGray400 => BoxDecoration(
    color: theme.colorScheme.onPrimary,
    border: Border.all(
      color: appTheme.gray400,
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: appTheme.black9001c,
        spreadRadius: 2,
        blurRadius: 2,
        offset: const Offset(0, 0),
      ),
    ],
  );
  static BoxDecoration get outlinePrimary => BoxDecoration(
    color: theme.colorScheme.primary.withOpacity(0.12),
    border: Border.all(
      color: theme.colorScheme.primary,
      width: 1,
    ),
  );
}

/// Class containing border radius styles
class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder20 => BorderRadius.circular(20);
  static BorderRadius get circleBorder42 => BorderRadius.circular(42);
  // Rounded borders
  static BorderRadius get roundedBorder12 => BorderRadius.circular(12);
  static BorderRadius get roundedBorder4 => BorderRadius.circular(4);
  static BorderRadius get roundedBorder8 => BorderRadius.circular(8);
}