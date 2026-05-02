import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../tokens/wlm_motion.dart';
import '../../tokens/wlm_size.dart';
import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';
import '../../utils/wlm_a11y.dart';

/// Hairline-bordered text input. Filled `surfaceContainerHighest`
/// background, rounded `radMd` corners, accent cursor.
///
/// Production extras: animated focus border, optional clear button,
/// optional character counter, widget-composed prefix/suffix, sizes.
class WlmTextField extends StatefulWidget {
  const WlmTextField({
    super.key,
    this.controller,
    this.hintText,
    this.label,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.prefix,
    this.suffixIcon,
    this.suffix,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.showCounter = false,
    this.clearable = false,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
    this.size = WlmSize.md,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.autofillHints,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? label;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? prefix;
  final IconData? suffixIcon;
  final Widget? suffix;
  final bool obscureText;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final bool showCounter;
  final bool clearable;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final bool enabled;
  final bool autofocus;
  final FocusNode? focusNode;
  final WlmSize size;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;

  @override
  State<WlmTextField> createState() => _WlmTextFieldState();
}

class _WlmTextFieldState extends State<WlmTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _focused = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocus);
    _controller.addListener(_onChange);
    _hasText = _controller.text.isNotEmpty;
  }

  @override
  void didUpdateWidget(covariant WlmTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      if (oldWidget.controller == null) _controller.dispose();
      _controller = widget.controller ?? TextEditingController();
      _controller.addListener(_onChange);
      _hasText = _controller.text.isNotEmpty;
    }
    if (oldWidget.focusNode != widget.focusNode) {
      if (oldWidget.focusNode == null) _focusNode.dispose();
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_onFocus);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocus);
    _controller.removeListener(_onChange);
    if (widget.controller == null) _controller.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  void _onFocus() => setState(() => _focused = _focusNode.hasFocus);
  void _onChange() {
    final has = _controller.text.isNotEmpty;
    if (has != _hasText) setState(() => _hasText = has);
  }

  void _clear() {
    _controller.clear();
    widget.onChanged?.call('');
    widget.onClear?.call();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final hasError = widget.errorText != null;
    final borderColor = hasError
        ? scheme.error
        : (_focused
            ? scheme.onSurface
            : scheme.outlineVariant.withValues(alpha: 0.6));
    final padV = wlmBySize(widget.size,
        sm: WlmTokens.spaceSm, md: WlmTokens.spaceMd, lg: WlmTokens.spaceLg,);
    final fontSize = wlmBySize(widget.size, sm: 12.0, md: 14.0, lg: 16.0);

    Widget? buildSuffix() {
      final widgets = <Widget>[];
      if (widget.clearable && _hasText && widget.enabled) {
        widgets.add(
          Semantics(
            button: true,
            label: 'Clear',
            child: GestureDetector(
              onTap: _clear,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: WlmTokens.spaceSm,),
                child: Icon(Icons.close_rounded,
                    size: 14, color: scheme.outline,),
              ),
            ),
          ),
        );
      }
      if (widget.suffixIcon != null) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(right: WlmTokens.spaceMd),
          child: Icon(widget.suffixIcon, size: 18, color: scheme.outline),
        ),);
      }
      if (widget.suffix != null) widgets.add(widget.suffix!);
      if (widgets.isEmpty) return null;
      return Row(mainAxisSize: MainAxisSize.min, children: widgets);
    }

    Widget? buildPrefix() {
      if (widget.prefixIcon != null) {
        return Padding(
          padding: const EdgeInsets.only(left: WlmTokens.spaceMd, right: 4),
          child: Icon(widget.prefixIcon, size: 18, color: scheme.outline),
        );
      }
      return widget.prefix;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!.toUpperCase(),
              style: WlmType.label(scheme.outline),),
          const SizedBox(height: WlmTokens.spaceSm),
        ],
        AnimatedContainer(
          duration: WlmA11y.motion(context, WlmMotion.fast),
          curve: WlmMotion.standard,
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(WlmTokens.radMd),
            border: Border.all(
                color: borderColor, width: _focused || hasError ? 1.5 : 1.0,),
          ),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            autofocus: widget.autofocus,
            enabled: widget.enabled,
            obscureText: widget.obscureText,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            maxLength: widget.maxLength,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            inputFormatters: widget.inputFormatters,
            autofillHints: widget.autofillHints,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            cursorColor: scheme.secondary,
            style: WlmType.body(scheme.onSurface).copyWith(fontSize: fontSize),
            decoration: InputDecoration(
              isDense: true,
              hintText: widget.hintText,
              hintStyle:
                  WlmType.body(scheme.outline).copyWith(fontSize: fontSize),
              filled: false,
              prefixIcon: buildPrefix(),
              prefixIconConstraints: const BoxConstraints(minWidth: 0),
              suffixIcon: buildSuffix(),
              suffixIconConstraints: const BoxConstraints(minWidth: 0),
              counterText: '',
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: WlmTokens.spaceMd,
                vertical: padV,
              ),
            ),
          ),
        ),
        if (widget.helperText != null && !hasError) ...[
          const SizedBox(height: WlmTokens.spaceSm),
          Row(
            children: [
              Expanded(
                child: Text(widget.helperText!,
                    style: WlmType.meta(scheme.outline),),
              ),
              if (widget.showCounter && widget.maxLength != null)
                Text('${_controller.text.length}/${widget.maxLength}',
                    style: WlmType.tiny(scheme.outline),),
            ],
          ),
        ],
        if (hasError) ...[
          const SizedBox(height: WlmTokens.spaceSm),
          Row(
            children: [
              Expanded(
                child: Text(widget.errorText!,
                    style: WlmType.meta(scheme.error),),
              ),
              if (widget.showCounter && widget.maxLength != null)
                Text('${_controller.text.length}/${widget.maxLength}',
                    style: WlmType.tiny(scheme.outline),),
            ],
          ),
        ],
      ],
    );
  }
}
