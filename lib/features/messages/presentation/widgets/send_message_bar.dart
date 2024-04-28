import 'package:descolar_front/core/components/buttons.dart';
import 'package:descolar_front/features/messages/presentation/widgets/write_message_bar.dart';
import 'package:flutter/material.dart';

class SendMessageBar extends StatefulWidget {
  final TextEditingController? controller;

  const SendMessageBar({
    super.key,
    this.controller,
  });

  @override
  State<StatefulWidget> createState() => _SendMessageBarState();
}

class _SendMessageBarState extends State<SendMessageBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, right: 10, top: 20),
      child: Row(
        children: [
          WriteMessageBar(controller: widget.controller),
          PrimaryTextButton(text: 'Envoyer', onTap: () {}),
        ],
      ),
    );
  }
}
