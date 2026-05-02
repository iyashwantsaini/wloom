import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Wolwoloom crumb class.
class WlmCrumb {
  const WlmCrumb(this.label, {this.onTap});
  final String label;
  final VoidCallback? onTap;
}

/// Horizontal breadcrumb trail. Last crumb is rendered un-tappable in
/// the foreground colour; preceding crumbs in muted with `/` separators.
class WlmBreadcrumbs extends StatelessWidget {
  const WlmBreadcrumbs({super.key, required this.crumbs});
  final List<WlmCrumb> crumbs;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: WlmTokens.spaceXs,
      children: [
        for (var i = 0; i < crumbs.length; i++) ...[
          if (i > 0)
            Text('/', style: WlmType.label(scheme.outline)),
          if (i == crumbs.length - 1)
            Text(crumbs[i].label, style: WlmType.label(scheme.onSurface))
          else
            InkWell(
              onTap: crumbs[i].onTap,
              child: Text(
                crumbs[i].label,
                style: WlmType.label(scheme.outline),
              ),
            ),
        ],
      ],
    );
  }
}
