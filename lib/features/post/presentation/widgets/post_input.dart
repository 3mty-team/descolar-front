import 'package:descolar_front/features/profil/presentation/widgets/profil_picture.dart';
import 'package:flutter/material.dart';

class PostInput extends StatefulWidget {
  final String hint;
  final int maxPostCharacters;
  final TextEditingController? controller;

  const PostInput({
    super.key,
    required this.hint,
    required this.maxPostCharacters,
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
              prefixIcon: const Padding(
                padding: EdgeInsets.only(right: 10, left: 5),
                child: ProfilPicture(
                  radius: 20,
                  // TODO : Add user pp
                ),
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
