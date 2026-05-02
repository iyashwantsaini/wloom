import 'package:flutter/material.dart';

import '../navigation/wlm_bottom_nav.dart';
import 'wlm_app_bar.dart';

/// Convenience scaffold wired with `WlmAppBar` + optional `WlmBottomNav`.
class WlmAppScaffold extends StatelessWidget {
  const WlmAppScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNav,
    this.bottomNavIndex,
    this.onBottomNavTap,
    this.floatingActionButton,
    this.drawer,
  });

  final WlmAppBar? appBar;
  final Widget body;
  final List<WlmNavItem>? bottomNav;
  final int? bottomNavIndex;
  final ValueChanged<int>? onBottomNavTap;
  final Widget? floatingActionButton;
  final Widget? drawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNav == null
          ? null
          : WlmBottomNav(
              items: bottomNav!,
              currentIndex: bottomNavIndex ?? 0,
              onTap: onBottomNavTap ?? (_) {},
            ),
    );
  }
}
