import 'package:flutter/material.dart';
import 'package:wolwoloom/wolwoloom.dart';

import '../catalog_scaffold.dart';

class FormsPage extends StatefulWidget {
  const FormsPage({super.key});

  @override
  State<FormsPage> createState() => _FormsPageState();
}

class _FormsPageState extends State<FormsPage> {
  final _form = WlmFormController();
  String? _result;

  void _submit() {
    if (_form.validate()) {
      setState(() => _result = _form.values.toString());
    } else {
      setState(() => _result = null);
    }
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return CatalogScaffold(
      title: 'Forms',
      intro:
          'WlmFormController + WlmFormField wire any input into a single '
          'controller. WlmValidators provides composable rules.',
      sections: [
        Section(
          label: 'Sign in',
          children: [
            WlmFormField<String>(
              controller: _form,
              name: 'email',
              initialValue: '',
              validator: WlmValidators.compose([
                WlmValidators.required(),
                WlmValidators.email(),
              ]),
              builder: (ctx, value, error, set) => WlmTextField(
                label: 'Email',
                hintText: 'you@domain.com',
                prefixIcon: Icons.alternate_email,
                errorText: error,
                onChanged: set,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
              ),
            ),
            WlmFormField<String>(
              controller: _form,
              name: 'password',
              initialValue: '',
              validator: WlmValidators.compose([
                WlmValidators.required(),
                WlmValidators.minLength(8),
              ]),
              builder: (ctx, value, error, set) => WlmTextField(
                label: 'Password',
                hintText: '••••••••',
                obscureText: true,
                prefixIcon: Icons.lock_outline_rounded,
                errorText: error,
                onChanged: set,
              ),
            ),
            Row(
              children: [
                WlmPrimaryButton(label: 'SIGN IN', onPressed: _submit),
                const SizedBox(width: WlmTokens.spaceMd),
                WlmGhostButton(
                  label: 'RESET',
                  onPressed: () {
                    _form.reset();
                    setState(() => _result = null);
                  },
                ),
              ],
            ),
            if (_result != null)
              WlmCallout(
                tone: WlmCalloutTone.success,
                title: 'Submitted',
                body: _result!,
              )
            else
              Text(
                'Validators: required · email · minLength(8)',
                style: WlmType.meta(scheme.outline),
              ),
          ],
        ),
      ],
    );
  }
}
