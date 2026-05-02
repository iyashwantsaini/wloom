import 'package:flutter/widgets.dart';

/// Density multiplier applied to vertical padding / gap of compatible
/// components. Surfaces this through an `InheritedWidget` so a single
/// host (catalog page, settings screen) can dial up or down without
/// touching every child.
enum WlmDensity { compact, standard, comfortable }

/// Conversion helper.
extension WlmDensityX on WlmDensity {
  double get verticalScale => switch (this) {
        WlmDensity.compact => 0.75,
        WlmDensity.standard => 1.0,
        WlmDensity.comfortable => 1.25,
      };
}

/// Inherited density for a subtree. Components read this via
/// `WlmDensityScope.of(context)`.
class WlmDensityScope extends InheritedWidget {
  const WlmDensityScope({
    super.key,
    required this.density,
    required super.child,
  });

  final WlmDensity density;

  static WlmDensity of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<WlmDensityScope>();
    return scope?.density ?? WlmDensity.standard;
  }

  @override
  bool updateShouldNotify(WlmDensityScope oldWidget) =>
      oldWidget.density != density;
}
