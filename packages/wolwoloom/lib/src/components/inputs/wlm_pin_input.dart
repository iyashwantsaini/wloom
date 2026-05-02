import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../tokens/wlm_motion.dart';
import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';
import '../../utils/wlm_a11y.dart';

/// Code-style PIN / OTP input. Renders [length] hairline cells; the
/// underlying single text field handles keyboard input and paste.
class WlmPinInput extends StatefulWidget {
  const WlmPinInput({
    super.key,
    this.length = 6,
    this.controller,
    this.onChanged,
    this.onCompleted,
    this.obscure = false,
    this.errorText,
    this.autofocus = false,
  });

  final int length;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final bool obscure;
  final String? errorText;
  final bool autofocus;

  @override
  State<WlmPinInput> createState() => _WlmPinInputState();
}

class _WlmPinInputState extends State<WlmPinInput> {
  late TextEditingController _ctl;
  late FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _ctl = widget.controller ?? TextEditingController();
    _focus = FocusNode();
    _ctl.addListener(_onChange);
  }

  @override
  void dispose() {
    _ctl.removeListener(_onChange);
    if (widget.controller == null) _ctl.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _onChange() {
    setState(() {});
    widget.onChanged?.call(_ctl.text);
    if (_ctl.text.length == widget.length) {
      widget.onCompleted?.call(_ctl.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final hasError = widget.errorText != null;

    final cells = List<Widget>.generate(widget.length, (i) {
      final ch = i < _ctl.text.length ? _ctl.text[i] : '';
      final filled = ch.isNotEmpty;
      final isCursor = i == _ctl.text.length && _focus.hasFocus;
      final color = hasError
          ? scheme.error
          : (isCursor
              ? scheme.onSurface
              : scheme.outlineVariant.withValues(alpha: 0.6));
      return AnimatedContainer(
        duration: WlmA11y.motion(context, WlmMotion.fast),
        width: 40,
        height: 48,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(WlmTokens.radSm),
          border: Border.all(color: color, width: isCursor || hasError ? 1.5 : 1.0),
        ),
        alignment: Alignment.center,
        child: Text(
          filled ? (widget.obscure ? '•' : ch) : '',
          style: WlmType.h2(scheme.onSurface).copyWith(fontSize: 18),
        ),
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Row(mainAxisSize: MainAxisSize.min, children: cells),
            Positioned.fill(
              child: Opacity(
                opacity: 0.001,
                child: TextField(
                  controller: _ctl,
                  focusNode: _focus,
                  autofocus: widget.autofocus,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(widget.length),
                  ],
                  cursorWidth: 0,
                  showCursor: false,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
          ],
        ),
        if (hasError) ...[
          const SizedBox(height: WlmTokens.spaceSm),
          Text(widget.errorText!, style: WlmType.meta(scheme.error)),
        ],
      ],
    );
  }
}
