import 'package:flutter/material.dart';

/// Curated icon set for wloom.
///
/// Material's filled glyphs are visually heavy against wloom's
/// editorial / typewriter palette. [WlmIcons] re-exports a vetted
/// subset of `Icons.*_outlined` (and a few rounded glyphs) under
/// editorial names, so consumers can write:
///
/// ```dart
/// Icon(WlmIcons.search);
/// Icon(WlmIcons.favoriteOutline);
/// ```
///
/// instead of leaking `Icons.search` everywhere. If you need a glyph
/// not listed here, fall back to `Icons.something_outlined` directly —
/// outlined variants are blessed; filled ones are not.
class WlmIcons {
  WlmIcons._();

  // ── Navigation ────────────────────────────────────────────────────
  static const IconData home = Icons.home_outlined;
  static const IconData homeFilled = Icons.home_rounded;
  static const IconData back = Icons.arrow_back;
  static const IconData forward = Icons.arrow_forward;
  static const IconData close = Icons.close;
  static const IconData menu = Icons.menu;
  static const IconData more = Icons.more_horiz;
  static const IconData moreVert = Icons.more_vert;
  static const IconData expand = Icons.expand_more;
  static const IconData collapse = Icons.expand_less;
  static const IconData chevronLeft = Icons.chevron_left;
  static const IconData chevronRight = Icons.chevron_right;
  static const IconData externalLink = Icons.open_in_new;

  // ── Actions ───────────────────────────────────────────────────────
  static const IconData search = Icons.search;
  static const IconData filter = Icons.tune;
  static const IconData sort = Icons.sort;
  static const IconData add = Icons.add;
  static const IconData remove = Icons.remove;
  static const IconData edit = Icons.edit_outlined;
  static const IconData delete = Icons.delete_outline;
  static const IconData copy = Icons.copy_outlined;
  static const IconData share = Icons.share_outlined;
  static const IconData download = Icons.download_outlined;
  static const IconData upload = Icons.upload_outlined;
  static const IconData refresh = Icons.refresh;
  static const IconData settings = Icons.settings_outlined;
  static const IconData check = Icons.check;
  static const IconData checkCircle = Icons.check_circle_outline;

  // ── Content ───────────────────────────────────────────────────────
  static const IconData favorite = Icons.favorite;
  static const IconData favoriteOutline = Icons.favorite_border;
  static const IconData bookmark = Icons.bookmark;
  static const IconData bookmarkOutline = Icons.bookmark_border;
  static const IconData star = Icons.star;
  static const IconData starOutline = Icons.star_border;
  static const IconData image = Icons.image_outlined;
  static const IconData photoLibrary = Icons.photo_library_outlined;
  static const IconData video = Icons.videocam_outlined;
  static const IconData document = Icons.description_outlined;
  static const IconData folder = Icons.folder_outlined;
  static const IconData tag = Icons.tag;
  static const IconData link = Icons.link;

  // ── Status ────────────────────────────────────────────────────────
  static const IconData info = Icons.info_outline;
  static const IconData warning = Icons.warning_amber_outlined;
  static const IconData error = Icons.error_outline;
  static const IconData success = Icons.check_circle_outline;
  static const IconData help = Icons.help_outline;

  // ── Identity ──────────────────────────────────────────────────────
  static const IconData user = Icons.person_outline;
  static const IconData users = Icons.group_outlined;
  static const IconData login = Icons.login;
  static const IconData logout = Icons.logout;
  static const IconData key = Icons.vpn_key_outlined;
  static const IconData lock = Icons.lock_outline;
  static const IconData unlock = Icons.lock_open_outlined;
  static const IconData visible = Icons.visibility_outlined;
  static const IconData hidden = Icons.visibility_off_outlined;

  // ── System ────────────────────────────────────────────────────────
  static const IconData light = Icons.light_mode_outlined;
  static const IconData dark = Icons.dark_mode_outlined;
  static const IconData wifi = Icons.wifi;
  static const IconData wifiOff = Icons.wifi_off;
  static const IconData bell = Icons.notifications_outlined;
  static const IconData bellOff = Icons.notifications_off_outlined;
  static const IconData clock = Icons.schedule;
  static const IconData calendar = Icons.calendar_today_outlined;
}
