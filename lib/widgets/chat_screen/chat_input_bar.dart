import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chat_app/theme/app_colors.dart';

class ChatInputBar extends StatefulWidget {
  final void Function(String)? onSend;
  const ChatInputBar({super.key, this.onSend});

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final TextEditingController _ctrl = TextEditingController();
  bool isTyping = false;
  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _send() {
    final text = _ctrl.text.trim();
    if (text.isNotEmpty) {
      widget.onSend?.call(text);
      _ctrl.clear();
      setState(() {
        isTyping = false;
      });
    }
  }

  void onChange() {
    if (_ctrl.text.isEmpty) {
      setState(() {
        isTyping = false;
      });
    } else {
      setState(() {
        isTyping = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.inputBoxColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 120),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _ctrl,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.newline,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 12,
                  ),
                  border: InputBorder.none,
                  hintText: 'Type here...',
                ),
                onChanged: (value) => onChange(),
              ),
            ),
            isTyping
                ? InkWell(
                    onTap: _send,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(8, 6, 6, 6),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(Icons.send, color: Colors.white),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(1),
                          child: SvgPicture.asset(
                            'assets/icons/gallary-icon.svg',
                            width: 26,
                          ),
                        ),
                      ),

                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(1),
                          child: SvgPicture.asset(
                            'assets/icons/emoji-icon.svg',
                            width: 26,
                          ),
                        ),
                      ),

                      const SizedBox(width: 6),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
