import 'package:flutter/material.dart';
import 'package:wolwoloom/wolwoloom.dart';

/// Chat / messages screen using WlmMessageBubble.
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _Msg {
  const _Msg({
    required this.text,
    required this.side,
    required this.time,
    this.author,
    this.status,
  });
  final String text;
  final WlmMessageSide side;
  final String time;
  final String? author;
  final WlmMessageStatus? status;
}

class _ChatScreenState extends State<ChatScreen> {
  final _input = TextEditingController();
  final List<_Msg> _msgs = [
    const _Msg(
      author: 'Miko',
      text: "Hey — did you see the new editorial layout?",
      side: WlmMessageSide.incoming,
      time: '09:14',
    ),
    const _Msg(
      text: "Yeah, looks slick. Mono headlines really work.",
      side: WlmMessageSide.outgoing,
      time: '09:15',
      status: WlmMessageStatus.read,
    ),
    const _Msg(
      author: 'Miko',
      text:
          "I shipped the timeline + KPI components too. Try the dashboard screen.",
      side: WlmMessageSide.incoming,
      time: '09:16',
    ),
    const _Msg(
      text: "On it. Want me to add a chat template?",
      side: WlmMessageSide.outgoing,
      time: '09:17',
      status: WlmMessageStatus.delivered,
    ),
    const _Msg(
      author: 'Miko',
      text: "Please. Hairline borders only — no glassmorphism.",
      side: WlmMessageSide.incoming,
      time: '09:17',
    ),
  ];

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  void _send() {
    final t = _input.text.trim();
    if (t.isEmpty) return;
    setState(() {
      _msgs.add(_Msg(
        text: t,
        side: WlmMessageSide.outgoing,
        time: 'now',
        status: WlmMessageStatus.sending,
      ));
      _input.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final wlm = WlmThemeExtension.of(context);
    return Scaffold(
      backgroundColor: scheme.surfaceContainerLowest,
      appBar: WlmAppBar(
        title: 'miko',
        actions: [
          WlmHeaderIconButton(
              icon: Icons.videocam_outlined, onPressed: () {}),
          WlmHeaderIconButton(
              icon: Icons.call_outlined, onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(WlmTokens.spaceLg),
              itemCount: _msgs.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: WlmTokens.spaceMd),
              itemBuilder: (_, i) {
                final m = _msgs[i];
                return WlmMessageBubble(
                  text: m.text,
                  side: m.side,
                  author: m.author,
                  time: m.time,
                  status: m.status,
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: scheme.surface,
              border: Border(
                top: BorderSide(
                    color: wlm.hairline, width: WlmTokens.hairline),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(
              WlmTokens.spaceMd,
              WlmTokens.spaceSm,
              WlmTokens.spaceMd,
              WlmTokens.spaceMd,
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  WlmIconButton(
                    icon: Icons.add_rounded,
                    onPressed: () {},
                  ),
                  const SizedBox(width: WlmTokens.spaceSm),
                  Expanded(
                    child: WlmTextField(
                      controller: _input,
                      hintText: 'Message',
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  const SizedBox(width: WlmTokens.spaceSm),
                  WlmFab(
                    icon: Icons.arrow_upward_rounded,
                    onPressed: _send,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
