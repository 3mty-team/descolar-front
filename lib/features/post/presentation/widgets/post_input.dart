import 'package:flutter/material.dart';

class PostInput extends StatefulWidget {
  static const String hint = 'Quoi de neuf ?';
  static const maxPostCharacters = 400;
  static const defaultUserIcon = Icon(Icons.account_circle_rounded, size: 40);
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const PostInput({super.key, this.controller, this.keyboardType});

  @override
  State<PostInput> createState() => _PostInputState();
}

class _PostInputState extends State<PostInput> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: <Widget>[
        Flexible(
          child: TextField(
            maxLines: null,
            maxLength: PostInput.maxPostCharacters,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.only(right: 10, left: 5),
                child: PostInput.defaultUserIcon,
              ),
              hintText: PostInput.hint,
              counter: Offstage(),
            ),
          ),
        ),
      ],
    );
  }
}
