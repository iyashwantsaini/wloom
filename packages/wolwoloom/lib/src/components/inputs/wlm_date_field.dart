import 'package:flutter/material.dart';

import 'wlm_text_field.dart';

/// Date picker field. Renders a `WlmTextField` showing the formatted
/// date; tapping opens the platform date picker themed against the
/// active scheme.
class WlmDateField extends StatefulWidget {
  const WlmDateField({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.hintText = 'Pick a date',
    this.firstDate,
    this.lastDate,
    this.format,
  });

  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final String? label;
  final String hintText;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String Function(DateTime)? format;

  @override
  State<WlmDateField> createState() => _WlmDateFieldState();
}

class _WlmDateFieldState extends State<WlmDateField> {
  late final TextEditingController _ctrl =
      TextEditingController(text: _format(widget.value));

  @override
  void didUpdateWidget(covariant WlmDateField old) {
    super.didUpdateWidget(old);
    if (old.value != widget.value) _ctrl.text = _format(widget.value);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  String _format(DateTime? d) {
    if (d == null) return '';
    if (widget.format != null) return widget.format!(d);
    return '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  Future<void> _pick() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.value ?? now,
      firstDate: widget.firstDate ?? DateTime(now.year - 100),
      lastDate: widget.lastDate ?? DateTime(now.year + 100),
    );
    if (picked != null) widget.onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pick,
      child: AbsorbPointer(
        child: WlmTextField(
          controller: _ctrl,
          label: widget.label,
          hintText: widget.hintText,
          prefixIcon: Icons.calendar_today_outlined,
          suffixIcon: Icons.expand_more_rounded,
        ),
      ),
    );
  }
}
