import 'package:flutter/material.dart';

import '../../utils/wlm_breakpoints.dart';
import '../layout/wlm_app_bar.dart';
import 'wlm_bottom_nav.dart';

/// Navigation shell that switches between bottom-nav (compact) and a
/// `NavigationRail` (expanded). Stateful — owns the current tab index.
class WlmShell extends StatefulWidget {
  const WlmShell({
    super.key,
    required this.items,
    required this.builder,
    this.appBarTitle,
    this.initialIndex = 0,
  });

  final List<WlmNavItem> items;
  final Widget Function(BuildContext, int) builder;
  final String? appBarTitle;
  final int initialIndex;

  @override
  State<WlmShell> createState() => _WlmShellState();
}

class _WlmShellState extends State<WlmShell> {
  late int _index = widget.initialIndex;

  @override
  Widget build(BuildContext context) {
    final bp = WlmBreakpoint.of(context);
    final body = widget.builder(context, _index);

    return Scaffold(
      appBar: widget.appBarTitle == null
          ? null
          : WlmAppBar(title: widget.appBarTitle!),
      body: bp.isHandheld
          ? body
          : Row(
              children: [
                NavigationRail(
                  selectedIndex: _index,
                  onDestinationSelected: (i) => setState(() => _index = i),
                  labelType: NavigationRailLabelType.all,
                  destinations: [
                    for (final i in widget.items)
                      NavigationRailDestination(
                        icon: Icon(i.icon),
                        selectedIcon: Icon(i.activeIcon ?? i.icon),
                        label: Text(i.label),
                      ),
                  ],
                ),
                Expanded(child: body),
              ],
            ),
      bottomNavigationBar: bp.isHandheld
          ? WlmBottomNav(
              items: widget.items,
              currentIndex: _index,
              onTap: (i) => setState(() => _index = i),
            )
          : null,
    );
  }
}
