import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/core/components/buttons.dart';
import 'package:descolar_front/core/constants/cached_posts.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_item_without_icons.dart';
import 'package:descolar_front/features/post/presentation/providers/action_post_provider.dart';
import 'package:descolar_front/core/components/app_bars.dart';

class NewReport extends StatefulWidget {
  final PostEntity post;

  const NewReport({
    super.key,
    required this.post,
  });

  @override
  State<StatefulWidget> createState() => _NewReportState();
}

class _NewReportState extends State<NewReport> {
  String? selectedReason;

  @override
  Widget build(BuildContext context) {
    ActionPostProvider provider = Provider.of<ActionPostProvider>(context);
    TextEditingController controller = provider.controller;
    return Scaffold(
      appBar: AppBars.closeIconAppBar(context, controller),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostItemWithoutIcons(post: widget.post),
              const Divider(
                height: 10,
                color: Colors.grey,
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(right: 14, left: 14),
                child: Column(
                  children: [
                    const Text(
                      'Ce post pose problème ?\n'
                      'Merci de le signaler en remplissant le formulaire ci-dessous. Les modérateurs de Descolar se chargeront de prendre une décision.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: DropdownButton<String>(
                        value: selectedReason,
                        hint: const Text('Choisissez une raison'),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedReason = newValue;
                          });
                        },
                        items: CachedPost.reportCategories.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Center(
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Décrivez le problème',
                        ),
                        maxLines: 4,
                      ),
                    ),
                    const SizedBox(height: 25),
                    PrimaryTextButton(
                      text: 'Soumettre le signalement',
                      onTap: () {
                        if (selectedReason != null && controller.text.isNotEmpty) {
                          provider.reportPost(
                            context,
                            ReportPostParams(post: widget.post, reportCategoryID: CachedPost.reportCategories.indexOf(selectedReason!) + 1, comment: controller.text, date: DateTime.now().millisecondsSinceEpoch ~/ 1000),
                          );
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
    );
  }
}
