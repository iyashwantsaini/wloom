import 'package:flutter/animation.dart';

/// Motion tokens. wloom keeps animations short and quiet.
class WlmMotion {
  WlmMotion._();

  static const Duration fast = Duration(milliseconds: 120);
  static const Duration medium = Duration(milliseconds: 220);
  static const Duration slow = Duration(milliseconds: 320);
  static const Duration scan = Duration(milliseconds: 1100);

  static const Curve standard = Curves.easeOutCubic;
  static const Curve emphasized = Curves.easeOutQuart;
}
