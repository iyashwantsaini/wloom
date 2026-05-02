import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';
import '../overlays/wlm_popover.dart';
import 'wlm_text_field.dart';

/// Single combobox option.
class WlmComboboxOption<T> {
  const WlmComboboxOption({
    required this.value,
    required this.label,
    this.subtitle,
    this.icon,
  });

  final T value;
  final String label;
  final String? subtitle;
  final IconData? icon;
}

/// Searchable single-select dropdown. A text field acts as both the
/// trigger and the filter; matching options appear in a popover below.
class WlmCombobox<T> extends StatefulWidget {
  const WlmCombobox({
    super.key,
    required this.options,
    required this.value,
    required this.onChanged,
    this.label,
    this.hintText = 'Search…',
    this.emptyText = 'No matches',
    this.maxOptionsVisible = 6,
  });

  final List<WlmComboboxOption<T>> options;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String? label;
  final String hintText;
  final String emptyText;
  final int maxOptionsVisible;

  @override
  State<WlmCombobox<T>> createState() => _WlmComboboxState<T>();
}

class _WlmComboboxState<T> extends State<WlmCombobox<T>> {
  late TextEditingController _ctl;
  final _popover = WlmPopoverController();
  String _filter = '';

  @override
  void initState() {
    super.initState();
    _ctl = TextEditingController(text: _labelOf(widget.value));
  }

  @override
  void didUpdateWidget(covariant WlmCombobox<T> old) {
    super.didUpdateWidget(old);
    if (old.value != widget.value) _ctl.text = _labelOf(widget.value);
  }

  String _labelOf(T? value) {
    if (value == null) return '';
    return widget.options
        .firstWhere(
          (o) => o.value == value,
          orElse: () => WlmComboboxOption<T>(value: value, label: '$value'),
        )
        .label;
  }

  @override
  void dispose() {
    _ctl.dispose();
    _popover.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final filtered = widget.options.where((o) {
      if (_filter.isEmpty) return true;
      return o.label.toLowerCase().contains(_filter.toLowerCase());
    }).toList();
    final maxH = (widget.maxOptionsVisible * 44).toDouble();

    return WlmPopover(
      controller: _popover,
      maxWidth: 360,
      content: (ctx) => ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxH),
        child: filtered.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(WlmTokens.spaceMd),
                child: Text(widget.emptyText,
                    style: WlmType.bodySmall(scheme.outline),),
              )
            : ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: WlmTokens.spaceXs),
                itemCount: filtered.length,
                itemBuilder: (_, i) {
                  final opt = filtered[i];
                  final selected = opt.value == widget.value;
                  return InkWell(
                    onTap: () {
                      widget.onChanged(opt.value);
                      _ctl.text = opt.label;
                      _filter = '';
                      _popover.close();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: WlmTokens.spaceMd,
                          vertical: WlmTokens.spaceSm,),
                      child: Row(
                        children: [
                          if (opt.icon != null) ...[
                            Icon(opt.icon, size: 14, color: scheme.outline),
                            const SizedBox(width: WlmTokens.spaceSm),
                          ],
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(opt.label,
                                    style: WlmType.bodySmall(scheme.onSurface),),
                                if (opt.subtitle != null)
                                  Text(opt.subtitle!,
                                      style: WlmType.tiny(scheme.outline),),
                              ],
                            ),
                          ),
                          if (selected)
                            Icon(Icons.check_rounded,
                                size: 14, color: scheme.onSurface,),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      child: AbsorbPointer(
        absorbing: false,
        child: WlmTextField(
          label: widget.label,
          controller: _ctl,
          hintText: widget.hintText,
          suffixIcon: Icons.unfold_more_rounded,
          onChanged: (v) {
            setState(() => _filter = v);
            if (!_popover.isOpen) _popover.open();
          },
        ),
      ),
    );
  }
}
