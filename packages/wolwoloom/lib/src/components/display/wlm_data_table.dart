import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Mono table for dense data. Hairline borders, ALL-CAPS column labels,
/// optional row tap handler. Lays itself out using a horizontal scroll
/// when [columns] don't fit.
class WlmDataTable extends StatelessWidget {
  const WlmDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.onRowTap,
    this.compact = false,
    this.minColumnWidth = 96,
  });

  final List<WlmDataColumn> columns;
  final List<WlmDataRow> rows;
  final ValueChanged<int>? onRowTap;
  final bool compact;
  final double minColumnWidth;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final padV = compact ? WlmTokens.spaceSm : WlmTokens.spaceMd;

    Widget cell(Widget child, {bool header = false, int? flex}) => Expanded(
          flex: flex ?? 1,
          child: Container(
            constraints: BoxConstraints(minWidth: minColumnWidth),
            padding: EdgeInsets.symmetric(
                horizontal: WlmTokens.spaceMd, vertical: padV,),
            alignment: Alignment.centerLeft,
            child: child,
          ),
        );

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(WlmTokens.radMd),
        border: WlmTokens.hairlineBorder(scheme, opacity: 0.6),
      ),
      child: Column(
        children: [
          // header
          DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(WlmTokens.radMd),),
            ),
            child: Row(
              children: [
                for (final col in columns)
                  cell(
                    Text(col.label.toUpperCase(),
                        style: WlmType.label(scheme.outline),),
                    header: true,
                    flex: col.flex,
                  ),
              ],
            ),
          ),
          for (var i = 0; i < rows.length; i++) ...[
            Divider(
                height: 1,
                thickness: 1,
                color: scheme.outlineVariant.withValues(alpha: 0.4),),
            InkWell(
              onTap: onRowTap == null ? null : () => onRowTap!(i),
              child: Row(
                children: [
                  for (var c = 0; c < columns.length; c++)
                    cell(rows[i].cells[c], flex: columns[c].flex),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class WlmDataColumn {
  const WlmDataColumn({required this.label, this.flex = 1});
  final String label;
  final int flex;
}

class WlmDataRow {
  const WlmDataRow({required this.cells});
  final List<Widget> cells;
}
