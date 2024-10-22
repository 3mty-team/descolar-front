import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_item_without_icons.dart';
import 'package:descolar_front/features/post/presentation/providers/action_post_provider.dart';
import 'package:descolar_front/core/components/app_bars.dart';
import 'package:descolar_front/core/components/buttons.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_input.dart';

class NewQuote extends StatefulWidget {
  final PostEntity post;

  const NewQuote({
    super.key,
    required this.post,
  });

  @override
  State<StatefulWidget> createState() => _NewQuoteState();
}

class _NewQuoteState extends State<NewQuote> {
  @override
  Widget build(BuildContext context) {
    ActionPostProvider provider = Provider.of<ActionPostProvider>(context);
    TextEditingController controller = provider.controller;
    return Scaffold(
      appBar: AppBars.closeIconAppBar(context, controller),
      body: Expanded(
        child: ListView(
          children: [
            Column(
              children: [
                PostInput(
                  controller: controller,
                  hint: 'Message de votre citation...',
                  maxPostCharacters: 400,
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                  ),
                ),
                PostItemWithoutIcons(post: widget.post),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      const Spacer(),
                      PrimaryTextButton(
                        text: 'Republier le post',
                        onTap: () {
                          if (controller.text.isNotEmpty) {
                            provider.repostPost(context, widget.post.postId);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
