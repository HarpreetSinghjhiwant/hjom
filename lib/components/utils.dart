import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

final Map<String, String> en = {
  "lbl_4_events_added": "4 Events added ",
  "lbl_add_event": "Add event",
  "lbl_add_event2": "Add Event",
  "lbl_bride_name": "Bride Name",
  "lbl_bride_s_details": "Bride’s Details",
  "lbl_create_event": "Create Event",
  "lbl_edit": "Edit",
  "lbl_event_created": "Event Created",
  "lbl_event_details": "Event Details",
  "lbl_event_name": "Event name",
  "lbl_event_venue": "Event Venue",
  "lbl_father_s_name": "Father’s Name",
  "lbl_got_it": "Got it",
  "lbl_groom_name": "Groom Name",
  "lbl_groom_s_details": "Groom’s Details",
  "lbl_ladke_wale": "Ladke \nWale",
  "lbl_ladki_wale": "Ladki\nWale",
  "lbl_mehendi": "Mehendi  ",
  "lbl_mother_s_name": "Mother’s Name",
  "lbl_music_name": "Music Name",
  "lbl_need_help": "Need Help ?",
  "lbl_next": "Next",
  "lbl_or": "or",
  "lbl_sangeet": "Sangeet",
  "lbl_skip": "Skip",
  "msg_21st_june_2024": " 21st June 2024 | 4:00 PM Onwards ",
  "msg_add_event_details": "Add Event Details",
  "msg_ayush_weds_netali": "Ayush weds Netali | 21st June 2025",
  "msg_bride_groom_details": "Bride & Groom Details",
  "msg_bride_groom_details2": "Bride & Groom Details ",
  "msg_bride_groom_family": "Bride & Groom family details added",
  "msg_choose_your_side": "Choose Your Side",
  "msg_click_to_select": "Click to select event",
  "msg_event_date_time": "Event Date & Time",
  "msg_follow_these_points": "Follow these points for the best results",
  "msg_grandfather_s_name": "Grandfather’s name",
  "msg_grandmother_s_name": "Grandmother’s Name",
  "msg_haldi_mehendi": "Haldi | Mehendi  | Sangeet | Wedding",
  "msg_images_should_be":
  "Images should be front facing \nAvoid glasses \nNo darkeness in the background \nonly one face in the image",
  "msg_selected_music": "Selected music :",
  "msg_song_caricature": "Song & Caricature",
  "msg_upload_bride_image": "Upload Bride\nImage",
  "msg_upload_groom_image": "Upload Groom\nImage",
  "msg_upload_the_photos": "Upload the photos of bride & Groom",
  "msg_venue_delete_it":
  "Venue - delete it. close. this generator's current url is: venue. to change it, just enter a",
  "msg_network_err": "Network Error",
  "msg_something_went_wrong": "Something Went Wrong!"
};
// These are the Viewport values of your Figma Design.
// These are used in the code as a reference to create your UI Responsively.
const num FIGMA_DESIGN_WIDTH = 393;
const num FIGMA_DESIGN_HEIGHT = 852;
const num FIGMA_DESIGN_STATUS_BAR = 0;
const String dateTimeFormatPattern = 'dd/MM/yyyy';

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
  static String img202408131520263191 =
      '$imagePath/img_2024_08_13_15_20_26_3191.png';

  static String imgArrowLeft = '$imagePath/img_arrow_left.svg';

  static String imgWowInvites512 = '$imagePath/img_wow_invites_512.png';

  static String imgGroup1321314841 = '$imagePath/img_group_1321314841.png';

  static String imgGroup132131484136x36 =
      '$imagePath/img_group_1321314841_36x36.png';

  static String imgRectangle40198 = '$imagePath/img_rectangle_40198.png';

  static String imgFrame = '$imagePath/img_frame.svg';

  static String imgCheckmark = '$imagePath/img_checkmark.svg';

  static String imgArrowdown = '$imagePath/img_arrowdown.svg';

  static String imgGroup132131484140x40 =
      '$imagePath/img_group_1321314841_40x40.png';

  static String imgGroup13213148411 = '$imagePath/img_group_1321314841_1.png';

  static String imgFrameRed900 = '$imagePath/img_frame_red_900.svg';

  static String imgFramePrimary = '$imagePath/img_frame_primary.svg';

  static String imgFrameGray50005 = '$imagePath/img_frame_gray_500_05.svg';

  static String imgArrowdownGray60001 =
      '$imagePath/img_arrowdown_gray_600_01.svg';

  static String imgFramePrimary32x32 = '$imagePath/img_frame_primary_32x32.svg';

  static String imageNotFound = 'assets/images/image_not_found.png';
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