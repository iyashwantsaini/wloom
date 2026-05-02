import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Single command palette entry.
class WlmCommand {
  const WlmCommand({
    required this.id,
    required this.label,
    this.subtitle,
    this.icon,
    this.shortcut,
    this.group,
    required this.onRun,
  });

  final String id;
  final String label;
  final String? subtitle;
  final IconData? icon;
  final String? shortcut;
  final String? group;
  final VoidCallback onRun;
}

/// Cmd-K style command palette. Show via [WlmCommandPalette.show].
class WlmCommandPalette extends StatefulWidget {
  const WlmCommandPalette({
    super.key,
    required this.commands,
    this.placeholder = 'Type a command…',
  });

  final List<WlmCommand> commands;
  final String placeholder;

  static Future<void> show(BuildContext context,
      {required List<WlmCommand> commands,
      String placeholder = 'Type a command…',}) {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Command palette',
      barrierColor: Colors.black.withValues(alpha: 0.4),
      transitionDuration: const Duration(milliseconds: 140),
      pageBuilder: (ctx, anim, secondAnim) => Align(
        alignment: const Alignment(0, -0.4),
        child: Material(
          color: Colors.transparent,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: WlmCommandPalette(
              commands: commands,
              placeholder: placeholder,
            ),
          ),
        ),
      ),
      transitionBuilder: (ctx, anim, secondAnim, child) => FadeTransition(
        opacity: anim,
        child: ScaleTransition(
          scale: Tween(begin: 0.96, end: 1.0).animate(
              CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),),
          child: child,
        ),
      ),
    );
  }

  @override
  State<WlmCommandPalette> createState() => _WlmCommandPaletteState();
}

class _WlmCommandPaletteState extends State<WlmCommandPalette> {
  final _ctl = TextEditingController();
  final _focus = FocusNode();
  int _highlight = 0;
  String _query = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focus.requestFocus());
  }

  @override
  void dispose() {
    _ctl.dispose();
    _focus.dispose();
    super.dispose();
  }

  List<WlmCommand> get _filtered {
    if (_query.isEmpty) return widget.commands;
    final q = _query.toLowerCase();
    return widget.commands
        .where((c) =>
            c.label.toLowerCase().contains(q) ||
            (c.subtitle?.toLowerCase().contains(q) ?? false) ||
            (c.group?.toLowerCase().contains(q) ?? false),)
        .toList();
  }

  void _run(WlmCommand cmd) {
    Navigator.of(context).pop();
    cmd.onRun();
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    final filtered = _filtered;
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() =>
          _highlight = (_highlight + 1).clamp(0, filtered.length - 1),);
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() => _highlight = (_highlight - 1).clamp(0, filtered.length - 1));
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.enter) {
      if (filtered.isNotEmpty) _run(filtered[_highlight]);
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.escape) {
      Navigator.of(context).maybePop();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final filtered = _filtered;
    if (_highlight >= filtered.length) _highlight = 0;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(WlmTokens.radLg),
        border: WlmTokens.hairlineBorder(scheme, opacity: 0.6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.16),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // search row
          Padding(
            padding: const EdgeInsets.fromLTRB(WlmTokens.spaceLg, WlmTokens.spaceMd,
                WlmTokens.spaceLg, WlmTokens.spaceSm,),
            child: Row(
              children: [
                Icon(Icons.search_rounded, size: 16, color: scheme.outline),
                const SizedBox(width: WlmTokens.spaceMd),
                Expanded(
                  child: Focus(
                    onKeyEvent: _onKey,
                    child: TextField(
                      controller: _ctl,
                      focusNode: _focus,
                      cursorColor: scheme.secondary,
                      style: WlmType.body(scheme.onSurface),
                      onChanged: (v) => setState(() {
                        _query = v;
                        _highlight = 0;
                      }),
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: widget.placeholder,
                        hintStyle: WlmType.body(scheme.outline),
                      ),
                    ),
                  ),
                ),
                Text('ESC', style: WlmType.tiny(scheme.outline)),
              ],
            ),
          ),
          Divider(height: 1, color: scheme.outlineVariant.withValues(alpha: 0.4)),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 360),
            child: filtered.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(WlmTokens.spaceXl),
                    child: Center(
                      child: Text('No commands match',
                          style: WlmType.bodySmall(scheme.outline),),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: WlmTokens.spaceXs),
                    itemCount: filtered.length,
                    itemBuilder: (_, i) {
                      final cmd = filtered[i];
                      final highlighted = i == _highlight;
                      return InkWell(
                        onTap: () => _run(cmd),
                        onHover: (h) {
                          if (h) setState(() => _highlight = i);
                        },
                        child: Container(
                          color: highlighted
                              ? scheme.surfaceContainerHighest
                              : Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: WlmTokens.spaceLg,
                              vertical: WlmTokens.spaceSm,),
                          child: Row(
                            children: [
                              if (cmd.icon != null) ...[
                                Icon(cmd.icon,
                                    size: 14, color: scheme.outline,),
                                const SizedBox(width: WlmTokens.spaceMd),
                              ],
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(cmd.label,
                                        style: WlmType.bodySmall(
                                            scheme.onSurface,),),
                                    if (cmd.subtitle != null)
                                      Text(cmd.subtitle!,
                                          style: WlmType.tiny(scheme.outline),),
                                  ],
                                ),
                              ),
                              if (cmd.group != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: WlmTokens.spaceMd,),
                                  child: Text(cmd.group!.toUpperCase(),
                                      style: WlmType.tiny(scheme.outline),),
                                ),
                              if (cmd.shortcut != null)
                                Text(cmd.shortcut!,
                                    style: WlmType.tiny(scheme.outline),),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
