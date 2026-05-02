/// Wolwoloom — editorial / typewriter Flutter design system.
///
/// Import this single file to get every public widget, token and theme.
///
/// ```dart
/// import 'package:wolwoloom/wolwoloom.dart';
///
/// MaterialApp(
///   theme: WlmTheme.light(),
///   darkTheme: WlmTheme.dark(),
///   home: const MyPage(),
/// );
/// ```
library;

// Foundations
export 'src/tokens/wlm_tokens.dart';
export 'src/tokens/wlm_colors.dart';
export 'src/tokens/wlm_type.dart';
export 'src/tokens/wlm_motion.dart';
export 'src/theme/wlm_theme.dart';

// Components — buttons
export 'src/components/buttons/wlm_primary_button.dart';
export 'src/components/buttons/wlm_secondary_button.dart';
export 'src/components/buttons/wlm_ghost_button.dart';
export 'src/components/buttons/wlm_icon_button.dart';
export 'src/components/buttons/wlm_header_icon_button.dart';

// Components — inputs
export 'src/components/inputs/wlm_text_field.dart';
export 'src/components/inputs/wlm_search_field.dart';
export 'src/components/inputs/wlm_key_field.dart';

// Components — display
export 'src/components/display/wlm_badge.dart';
export 'src/components/display/wlm_chip.dart';
export 'src/components/display/wlm_pill.dart';
export 'src/components/display/wlm_spec_row.dart';
export 'src/components/display/wlm_divider.dart';

// Components — layout
export 'src/components/layout/wlm_card.dart';
export 'src/components/layout/wlm_page_header.dart';
export 'src/components/layout/wlm_section_label.dart';

// Components — lists
export 'src/components/lists/wlm_list_tile.dart';
export 'src/components/lists/wlm_action_row.dart';
export 'src/components/lists/wlm_switch_tile.dart';

// Components — feedback
export 'src/components/feedback/wlm_loader.dart';
export 'src/components/feedback/wlm_scan_bar.dart';
export 'src/components/feedback/wlm_skeleton.dart';
export 'src/components/feedback/wlm_grid_skeleton.dart';
export 'src/components/feedback/wlm_snack_bar.dart';

// Components — navigation
export 'src/components/navigation/wlm_bottom_nav.dart';
export 'src/components/navigation/wlm_step_dots.dart';

// Components — overlays
export 'src/components/overlays/wlm_bottom_sheet.dart';
export 'src/components/overlays/wlm_dialog.dart';

// Components — media
export 'src/components/media/wlm_network_image.dart';
export 'src/components/media/wlm_progressive_image.dart';
export 'src/components/media/wlm_masonry_grid.dart';
