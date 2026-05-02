import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Inline search bar. Hairline border, leading magnifier, trailing clear
/// affordance that appears when the field has content.
class WlmSearchField extends StatefulWidget {
  const WlmSearchField({
    super.key,
    this.controller,
    this.hintText = 'Search',
    this.onChanged,
    this.onSubmitted,
    this.autofocus = false,
    this.focusNode,
  });

  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool autofocus;
  final FocusNode? focusNode;

  @override
  State<WlmSearchField> createState() => _WlmSearchFieldState();
}

class _WlmSearchFieldState extends State<WlmSearchField> {
  late final TextEditingController _internal =
      widget.controller ?? TextEditingController();

  @override
  void initState() {
    super.initState();
    _internal.addListener(_rebuild);
  }

  void _rebuild() => setState(() {});

  @override
  void dispose() {
    _internal.removeListener(_rebuild);
    if (widget.controller == null) _internal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(WlmTokens.radMd),
        border: WlmTokens.hairlineBorder(scheme),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              WlmTokens.spaceMd,
              0,
              WlmTokens.spaceSm,
              0,
            ),
            child: Icon(Icons.search_rounded, color: scheme.outline, size: 18),
          ),
          Expanded(
            child: TextField(
              controller: _internal,
              focusNode: widget.focusNode,
              autofocus: widget.autofocus,
              style: WlmType.body(scheme.onSurface),
              cursorColor: scheme.secondary,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: WlmTokens.spaceMd,
                ),
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: WlmType.body(scheme.outline),
              ),
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
            ),
          ),
          if (_internal.text.isNotEmpty)
            InkWell(
              onTap: () {
                _internal.clear();
                widget.onChanged?.call('');
              },
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(WlmTokens.spaceSm + 2),
                child: Icon(
                  Icons.close_rounded,
                  color: scheme.outline,
                  size: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
