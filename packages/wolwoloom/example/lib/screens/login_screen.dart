import 'package:flutter/material.dart';
import 'package:wolwoloom/wolwoloom.dart';

/// Login / sign-in screen template — composed entirely from wolwoloom.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController(text: 'you@wolwoloom.dev');
  final _pwd = TextEditingController(text: '••••••••');
  bool _remember = true;
  bool _busy = false;

  @override
  void dispose() {
    _email.dispose();
    _pwd.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    setState(() => _busy = true);
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surfaceContainerLowest,
      appBar: WlmAppBar(title: 'sign in'),
      body: LayoutBuilder(
        builder: (ctx, c) {
          final wide = c.maxWidth >= 720;
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: wide ? 420 : c.maxWidth),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(WlmTokens.spaceXl),
                child: WlmSurface(
                  padding: const EdgeInsets.all(WlmTokens.spaceXl),
                  radius: WlmTokens.radLg,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'WOLWOLOOM',
                        style: WlmType.tiny(scheme.outline)
                            .copyWith(letterSpacing: 1.8),
                      ),
                      const SizedBox(height: WlmTokens.spaceSm),
                      Text(
                        'Welcome back.',
                        style: WlmType.h1(scheme.onSurface).copyWith(
                          fontSize: 32,
                          height: 1.05,
                          letterSpacing: -0.6,
                        ),
                      ),
                      const SizedBox(height: WlmTokens.spaceSm),
                      Text(
                        'Sign in to keep weaving.',
                        style: WlmType.body(scheme.onSurfaceVariant),
                      ),
                      const SizedBox(height: WlmTokens.spaceXl),
                      WlmTextField(
                        controller: _email,
                        label: 'Email',
                        hintText: 'you@example.com',
                        prefixIcon: Icons.alternate_email_rounded,
                      ),
                      const SizedBox(height: WlmTokens.spaceMd),
                      WlmTextField(
                        controller: _pwd,
                        label: 'Password',
                        obscureText: true,
                        prefixIcon: Icons.lock_outline_rounded,
                      ),
                      const SizedBox(height: WlmTokens.spaceMd),
                      Row(
                        children: [
                          WlmCheckbox(
                            value: _remember,
                            onChanged: (v) => setState(() => _remember = v),
                          ),
                          const SizedBox(width: WlmTokens.spaceSm),
                          Text(
                            'Remember me',
                            style: WlmType.body(scheme.onSurface),
                          ),
                          const Spacer(),
                          WlmGhostButton(
                            label: 'FORGOT?',
                            onPressed: () {},
                            size: WlmSize.sm,
                          ),
                        ],
                      ),
                      const SizedBox(height: WlmTokens.spaceLg),
                      WlmPrimaryButton(
                        label: 'SIGN IN',
                        onPressed: _signIn,
                        loading: _busy,
                        expand: true,
                        icon: Icons.arrow_forward_rounded,
                      ),
                      const SizedBox(height: WlmTokens.spaceLg),
                      Row(
                        children: [
                          Expanded(child: WlmDivider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: WlmTokens.spaceMd,
                            ),
                            child: Text(
                              'OR',
                              style: WlmType.tiny(scheme.outline)
                                  .copyWith(letterSpacing: 1.6),
                            ),
                          ),
                          Expanded(child: WlmDivider()),
                        ],
                      ),
                      const SizedBox(height: WlmTokens.spaceLg),
                      WlmGhostButton(
                        label: 'CONTINUE WITH GITHUB',
                        onPressed: () {},
                        icon: Icons.code_rounded,
                        expand: true,
                      ),
                      const SizedBox(height: WlmTokens.spaceSm),
                      WlmGhostButton(
                        label: 'CONTINUE WITH GOOGLE',
                        onPressed: () {},
                        icon: Icons.g_mobiledata_rounded,
                        expand: true,
                      ),
                      const SizedBox(height: WlmTokens.spaceXl),
                      Center(
                        child: Text.rich(
                          TextSpan(
                            style: WlmType.meta(scheme.outline),
                            children: [
                              const TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                text: 'CREATE ONE',
                                style: WlmType.meta(scheme.primary)
                                    .copyWith(letterSpacing: 1.6),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
