import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'widgets.dart';

final Map<String, String> en = {
  "lbl_bride_name": "Bride Name",
  "lbl_create_event": "Create Event",
  "lbl_event_details": "Event Details",
  "lbl_groom_name": "Groom Name",
  "lbl_ladke_wale": "Ladke \nWale",
  "lbl_ladki_wale": "Ladki\nWale",
  "lbl_need_help": "Need Help ?",
  "lbl_next": "Next",
  "lbl_or": "or",
  "msg_bride_groom_details": "Bride & Groom Details",
  "msg_choose_your_side": "Choose Your Side",
  "msg_song_caricature": "Song & Caricature",
  "err_msg_please_enter_valid_text": "Please enter valid text",
  "err_msg_field_cannot_be_empty": "Field cannot be empty",
  "msg_network_err": "Network Error",
  "msg_something_went_wrong": "Something Went Wrong!"
};
String _appTheme = "lightCode";
// These are the Viewport values of your Figma Design.
// These are used in the code as a reference to create your UI Responsively.
const num FIGMA_DESIGN_WIDTH = 402;
const num FIGMA_DESIGN_HEIGHT = 874;
const num FIGMA_DESIGN_STATUS_BAR = 0;
const String dateTimeFormatPattern = 'dd/MM/yyyy';
LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Checks if string consist only Alphabet. (No Whitespace)
bool isText(String? inputString, {bool isRequired = false}) {
  bool isInputStringValid = false;
  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }
  if (inputString != null && inputString.isNotEmpty) {
    const pattern = r'^[a-zA-Z]+$';
    final regExp = RegExp(pattern);
    isInputStringValid = regExp.hasMatch(inputString);
  }
  return isInputStringValid;
}

extension on TextStyle {
  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }
}

extension ResponsiveExtension on num {
  double get _width => SizeUtils.width;
  double get h => ((this * _width) / FIGMA_DESIGN_WIDTH);
  double get fSize => ((this * _width) / FIGMA_DESIGN_WIDTH);
}

extension FormatExtension on double {
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(this.toStringAsFixed(fractionDigits));
  }

  double isNonZero({num defaultValue = 0.0}) {
    return this > 0 ? this : defaultValue.toDouble();
  }
}

extension DateTimeExtension on DateTime {
  String format({
    String pattern = dateTimeFormatPattern,
    String? locale,
  }) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DateFormat(pattern, locale).format(this);
  }
}

enum DeviceType { mobile, tablet, desktop }

typedef ResponsiveBuild = Widget Function(
    BuildContext context, Orientation orientation, DeviceType deviceType);

// ignore_for_file: must_be_immutable
class ImageConstant {
  // Image folder path
  static String imagePath = 'assets/images';

// Common images
  static String imgArrowLeft = '$imagePath/img_arrow_left.svg';

  static String imgWowInvites512 = '$imagePath/img_wow_invites_512.png';

  static String imgGroup1321314841 = '$imagePath/img_group_1321314841.png';

  static String imgGroup132131484136x36 =
      '$imagePath/img_group_1321314841_36x36.png';

  static String imgRectangle40198 = '$imagePath/img_rectangle_40198.png';

  static String imgFrame = '$imagePath/img_frame.svg';

  static String imageNotFound = 'assets/images/image_not_found.png';
}

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.
class CustomTextStyles {
  // Body text style
  static TextStyle get bodyLargePoppinsGray50001 =>
      theme.textTheme.bodyLarge!.poppins.copyWith(
        color: appTheme.gray50001,
        fontWeight: FontWeight.w400,
      );
  static TextStyle get bodyLargePrimary => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w400,
      );
  static TextStyle get bodyMediumOnPrimary =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 15.fSize,
      );
  static TextStyle get bodyMediumPrimary =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primary,
      );
}

/// Helper class for managing themes and colors.

// ignore_for_file: must_be_immutable
class ThemeHelper {
  // A map of custom color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String _newTheme) {
    _appTheme = _newTheme;
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
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
            width: 1.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
          color: appTheme.blueGray400,
          fontSize: 16.fSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w300,
        ),
        bodyMedium: TextStyle(
          color: appTheme.gray50001,
          fontSize: 14.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: appTheme.gray50002,
          fontSize: 12.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light(
    primary: Color(0XFF6D50CE),
    onPrimary: Color(0XFFFFFFFF),
  );
}

/// Class containing custom colors for a lightCode theme.
class LightCodeColors {
  // BlueGray
  Color get blueGray100 => Color(0XFFD3D3D3);
  Color get blueGray10001 => Color(0XFFD1D1D1);
  Color get blueGray10002 => Color(0XFFD6D6D6);
  Color get blueGray10003 => Color(0XFFD5D5D5);
  Color get blueGray400 => Color(0XFF868686);
// Gray
  Color get gray200 => Color(0XFFE7E7E7);
  Color get gray400 => Color(0XFFCACACA);
  Color get gray50 => Color(0XFFF9F9F9);
  Color get gray500 => Color(0XFF979797);
  Color get gray50001 => Color(0XFF999999);
  Color get gray50002 => Color(0XFFA8A8A8);
}

class Sizer extends StatelessWidget {
  const Sizer({Key? key, required this.builder}) : super(key: key);

  /// Builds the widget whenever the orientation changes.
  final ResponsiveBuild builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeUtils.setScreenSize(constraints, orientation);
        return builder(context, orientation, SizeUtils.deviceType);
      });
    });
  }
}

// ignore_for_file: must_be_immutable
class SizeUtils {
  /// Device's BoxConstraints
  static late BoxConstraints boxConstraints;

  /// Device's Orientation
  static late Orientation orientation;

  /// Type of Device
  ///
  /// This can either be mobile or tablet
  static late DeviceType deviceType;

  /// Device's Height
  static late double height;

  /// Device's Width
  static late double width;

  static void setScreenSize(
    BoxConstraints constraints,
    Orientation currentOrientation,
  ) {
    boxConstraints = constraints;
    orientation = currentOrientation;
    if (orientation == Orientation.portrait) {
      width =
          boxConstraints.maxWidth.isNonZero(defaultValue: FIGMA_DESIGN_WIDTH);
      height = boxConstraints.maxHeight.isNonZero();
    } else {
      width =
          boxConstraints.maxHeight.isNonZero(defaultValue: FIGMA_DESIGN_WIDTH);
      height = boxConstraints.maxWidth.isNonZero();
    }
    deviceType = DeviceType.mobile;
  }
}

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
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineGray => BoxDecoration(
        color: appTheme.gray50,
        border: Border.all(
          color: appTheme.gray200,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlinePrimary => BoxDecoration(
        color: theme.colorScheme.primary.withValues(
          alpha: 0.12,
        ),
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 1.h,
        ),
      );
}

class BorderRadiusStyle {
  // Rounded borders
  static BorderRadius get roundedBorder10 => BorderRadius.circular(
        10.h,
      );
}

// ignore_for_file: must_be_immutable
class Iphone16ProTwentyoneScreen extends StatelessWidget {
  Iphone16ProTwentyoneScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController nameController = TextEditingController();

  TextEditingController nameoneController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(context),
      body: SafeArea(
        top: false,
        child: Form(
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 22.h),
                child: Column(
                  children: [
i