/// wloom — editorial / typewriter Flutter design system.
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
export 'src/tokens/wlm_size.dart';
export 'src/tokens/wlm_density.dart';
export 'src/tokens/wlm_icons.dart';
export 'src/theme/wlm_theme.dart';
export 'src/theme/wlm_theme_extension.dart';

// Utilities
export 'src/utils/wlm_breakpoints.dart';
export 'src/utils/wlm_a11y.dart';

// Navigation primitives
export 'src/navigation/wlm_page_route.dart';

// Components — primitives
export 'src/components/primitives/wlm_focusable.dart';

// Components — buttons
export 'src/components/buttons/wlm_button.dart';
export 'src/components/buttons/wlm_primary_button.dart';
export 'src/components/buttons/wlm_secondary_button.dart';
export 'src/components/buttons/wlm_ghost_button.dart';
export 'src/components/buttons/wlm_icon_button.dart';
export 'src/components/buttons/wlm_header_icon_button.dart';
export 'src/components/buttons/wlm_fab.dart';

// Components — inputs
export 'src/components/inputs/wlm_text_field.dart';
export 'src/components/inputs/wlm_search_field.dart';
export 'src/components/inputs/wlm_key_field.dart';
export 'src/components/inputs/wlm_checkbox.dart';
export 'src/components/inputs/wlm_radio.dart';
export 'src/components/inputs/wlm_segmented_control.dart';
export 'src/components/inputs/wlm_dropdown.dart';
export 'src/components/inputs/wlm_combobox.dart';
export 'src/components/inputs/wlm_slider.dart';
export 'src/components/inputs/wlm_stepper.dart';
export 'src/components/inputs/wlm_date_field.dart';
export 'src/components/inputs/wlm_rating.dart';
export 'src/components/inputs/wlm_toggle.dart';
export 'src/components/inputs/wlm_pin_input.dart';
export 'src/components/inputs/wlm_form.dart';

// Components — display
export 'src/components/display/wlm_badge.dart';
export 'src/components/display/wlm_chip.dart';
export 'src/components/display/wlm_pill.dart';
export 'src/components/display/wlm_spec_row.dart';
export 'src/components/display/wlm_divider.dart';
export 'src/components/display/wlm_avatar.dart';
export 'src/components/display/wlm_avatar_stack.dart';
export 'src/components/display/wlm_tag.dart';
export 'src/components/display/wlm_kbd.dart';
export 'src/components/display/wlm_stat.dart';
export 'src/components/display/wlm_callout.dart';
export 'src/components/display/wlm_code_block.dart';
export 'src/components/display/wlm_progress_bar.dart';
export 'src/components/display/wlm_progress_ring.dart';
export 'src/components/display/wlm_tooltip.dart';
export 'src/components/display/wlm_data_table.dart';
export 'src/components/display/wlm_timeline.dart';
export 'src/components/display/wlm_message_bubble.dart';
export 'src/components/display/wlm_kpi_card.dart';

// Components — layout
export 'src/components/layout/wlm_surface.dart';
export 'src/components/layout/wlm_card.dart';
export 'src/components/layout/wlm_page_header.dart';
export 'src/components/layout/wlm_section_label.dart';
export 'src/components/layout/wlm_app_bar.dart';
export 'src/components/layout/wlm_app_scaffold.dart';
export 'src/components/layout/wlm_accordion.dart';
export 'src/components/layout/wlm_breadcrumbs.dart';
export 'src/components/layout/wlm_drawer.dart';

// Components — lists
export 'src/components/lists/wlm_list_tile.dart';
export 'src/components/lists/wlm_action_row.dart';
export 'src/components/lists/wlm_switch_tile.dart';
export 'src/components/lists/wlm_checkbox_tile.dart';
export 'src/components/lists/wlm_radio_tile.dart';

// Components — feedback
export 'src/components/feedback/wlm_loader.dart';
export 'src/components/feedback/wlm_scan_bar.dart';
export 'src/components/feedback/wlm_skeleton.dart';
export 'src/components/feedback/wlm_grid_skeleton.dart';
export 'src/components/feedback/wlm_snack_bar.dart';
export 'src/components/feedback/wlm_banner.dart';
export 'src/components/feedback/wlm_toaster.dart';
export 'src/components/feedback/wlm_toast.dart';
export 'src/components/feedback/wlm_empty_state.dart';
export 'src/components/feedback/wlm_error_state.dart';
export 'src/components/feedback/wlm_refresh.dart';

// Components — navigation
export 'src/components/navigation/wlm_bottom_nav.dart';
export 'src/components/navigation/wlm_step_dots.dart';
export 'src/components/navigation/wlm_tab_bar.dart';
export 'src/components/navigation/wlm_shell.dart';
export 'src/components/navigation/wlm_pagination.dart';

// Components — overlays
export 'src/components/overlays/wlm_bottom_sheet.dart';
export 'src/components/overlays/wlm_dialog.dart';
export 'src/components/overlays/wlm_popover.dart';
export 'src/components/overlays/wlm_menu.dart';
export 'src/components/overlays/wlm_command_palette.dart';
export 'src/components/overlays/wlm_action_sheet.dart';

// Components — media
export 'src/components/media/wlm_network_image.dart';
export 'src/components/media/wlm_progressive_image.dart';
export 'src/components/media/wlm_masonry_grid.dart';
