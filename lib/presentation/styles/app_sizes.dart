import 'package:flutter/widgets.dart';

class AppSizes {
  AppSizes._();

  /// LTRB: 25px 45px 25px 25px
  static EdgeInsetsGeometry paddingPage = const EdgeInsetsGeometry.fromLTRB(
    25,
    40,
    25,
    25,
  );

  /// 8px
  static const double paddingCard = 8;

  /// 5px
  static const double spacingSmall = 5;

  /// 10px
  static const double spacingMedium = 10;

  /// 15px
  static const double spacingLarge = 15;

  /// 30px
  static const double spacingXLarge = 30;

  /// 50px
  static const double defaultAppIconSize = 50;
}
