import 'package:flutter/material.dart';
import 'package:wolwoloom/wolwoloom.dart';

import '../catalog_scaffold.dart';

class InputsPage extends StatefulWidget {
  const InputsPage({super.key});
  @override
  State<InputsPage> createState() => _InputsPageState();
}

class _InputsPageState extends State<InputsPage> {
  bool _check = true;
  String _radio = 'b';
  int _segment = 0;
  String? _drop = 'wallhaven';
  double _slider = 0.4;
  int _count = 1;
  DateTime? _date;
  int _stars = 4;
  String? _city;
  bool _bold = false;
  Set<String> _format = {'b'};
  String _pin = '';

  @override
  Widget build(BuildContext context) {
    return CatalogScaffold(
      title: 'Inputs',
      intro:
          'Mono inputs with hairline borders. Each component is themed for '
          'both schemes and respects the standard tap-target.',
      sections: [
        const Section(
          label: 'Text',
          children: [
            WlmTextField(
              label: 'Email',
              hintText: 'you@domain.com',
              helperText: 'We never share this.',
              prefixIcon: Icons.alternate_email,
            ),
            WlmTextField(
              label: 'Password',
              hintText: '••••••••',
              obscureText: true,
              prefixIcon: Icons.lock_outline_rounded,
            ),
            WlmSearchField(hintText: 'Search wallpapers'),
          ],
        ),
        Section(
          label: 'Key field',
          children: [
            WlmKeyField(
              label: 'Wallhaven API key',
              hintText: 'paste your key',
              onGetKey: () {},
            ),
          ],
        ),
        Section(
          label: 'Choice',
          children: [
            Row(
              children: [
                WlmCheckbox(
                  value: _check,
                  onChanged: (v) => setState(() => _check = v),
                ),
                const SizedBox(width: WlmTokens.spaceMd),
                Text('I agree to the terms',
                    style: WlmType.body(Theme.of(context).colorScheme.onSurface)),
              ],
            ),
            Row(
              children: [
                for (final v in const ['a', 'b', 'c']) ...[
                  WlmRadio<String>(
                    value: v,
                    groupValue: _radio,
                    onChanged: (n) => setState(() => _radio = n ?? _radio),
                  ),
                  const SizedBox(width: WlmTokens.spaceXs),
                  Text(
                    v.toUpperCase(),
                    style: WlmType.label(
                        Theme.of(context).colorScheme.onSurface),
                  ),
                  const SizedBox(width: WlmTokens.spaceLg),
                ],
              ],
            ),
            WlmSegmentedControl<int>(
              expand: true,
              value: _segment,
              onChanged: (v) => setState(() => _segment = v),
              segments: const [
                WlmSegment(value: 0, label: 'Daily'),
                WlmSegment(value: 1, label: 'Weekly'),
                WlmSegment(value: 2, label: 'Monthly'),
              ],
            ),
            WlmDropdown<String>(
              label: 'Source',
              value: _drop,
              onChanged: (v) => setState(() => _drop = v),
              items: const [
                WlmDropdownItem(value: 'wallhaven', label: 'Wallhaven'),
                WlmDropdownItem(value: 'reddit', label: 'Reddit'),
                WlmDropdownItem(value: 'nasa', label: 'NASA'),
              ],
            ),
          ],
        ),
        Section(
          label: 'Numeric',
          children: [
            WlmSlider(
              value: _slider,
              onChanged: (v) => setState(() => _slider = v),
            ),
            WlmStepper(
              label: 'Quantity',
              value: _count,
              onChanged: (v) => setState(() => _count = v),
            ),
          ],
        ),
        Section(
          label: 'Date & rating',
          children: [
            WlmDateField(
              label: 'Birthday',
              value: _date,
              onChanged: (v) => setState(() => _date = v),
            ),
            Row(
              children: [
                WlmRating(value: _stars, onChanged: (v) => setState(() => _stars = v)),
                const SizedBox(width: WlmTokens.spaceMd),
                Text(
                  '$_stars / 5',
                  style: WlmType.meta(Theme.of(context).colorScheme.outline),
                ),
              ],
            ),
          ],
        ),
        Section(
          label: 'Combobox',
          caption: 'Searchable type-ahead with hairline popover.',
          children: [
            WlmCombobox<String>(
              label: 'City',
              hintText: 'Start typing…',
              value: _city,
              onChanged: (v) => setState(() => _city = v),
              options: const [
                WlmComboboxOption(value: 'tok', label: 'Tokyo', subtitle: 'JP'),
                WlmComboboxOption(value: 'ber', label: 'Berlin', subtitle: 'DE'),
                WlmComboboxOption(value: 'nyc', label: 'New York', subtitle: 'US'),
                WlmComboboxOption(value: 'mum', label: 'Mumbai', subtitle: 'IN'),
                WlmComboboxOption(value: 'lon', label: 'London', subtitle: 'UK'),
              ],
            ),
          ],
        ),
        Section(
          label: 'Toggle',
          caption: 'Press-to-pin toggle and grouped multi-select.',
          children: [
            Row(
              children: [
                WlmToggle(
                  selected: _bold,
                  onChanged: (v) => setState(() => _bold = v),
                  icon: Icons.format_bold_rounded,
                  label: 'Bold',
                ),
                const SizedBox(width: WlmTokens.spaceMd),
                WlmToggle(
                  selected: !_bold,
                  onChanged: (v) => setState(() => _bold = !v),
                  icon: Icons.format_italic_rounded,
                ),
              ],
            ),
            WlmToggleGroup<String>(
              allowMultiple: true,
              selected: _format,
              onChanged: (s) => setState(() => _format = s),
              items: const [
                WlmToggleItem(value: 'b', label: 'BOLD', icon: Icons.format_bold_rounded),
                WlmToggleItem(value: 'i', label: 'ITALIC', icon: Icons.format_italic_rounded),
                WlmToggleItem(value: 'u', label: 'UNDER', icon: Icons.format_underline_rounded),
              ],
            ),
          ],
        ),
        Section(
          label: 'Pin input',
          caption: 'One-time-code input with monospaced cells.',
          children: [
            WlmPinInput(
              length: 6,
              onChanged: (v) => setState(() => _pin = v),
              onCompleted: (_) {},
            ),
            Text(
              _pin.isEmpty ? 'Enter code' : 'Code: $_pin',
              style: WlmType.meta(Theme.of(context).colorScheme.outline),
            ),
          ],
        ),
      ],
    );
  }
}
