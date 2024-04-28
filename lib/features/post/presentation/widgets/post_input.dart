import 'package:flutter/material.dart';

class PostInput extends StatefulWidget {
  final String hint;
  final int maxPostCharacters;
  final Icon userIcon;
  final TextEditingController? controller;

  const PostInput({
    super.key,
    required this.hint,
    required this.maxPostCharacters,
    required this.userIcon,
    this.controller,
  });

  @override
  State<PostInput> createState() => _PostInputState();
}

class _PostInputState extends State<PostInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: TextField(
            controller: widget.controller,
            maxLines: null,
            maxLength: widget.maxPostCharacters,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 10, left: 5),
                child: widget.userIcon,
              ),
              hintText: widget.hint,
              counter: const Offstage(),
            ),
          ),
        ),
      ],
    );
  }
}
