import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:descolar_front/features/search/presentation/providers/search_provider.dart';
import 'package:descolar_front/core/components/app_bars.dart';
import 'package:descolar_front/core/components/search_bar.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controller = TextEditingController();
  List<PostEntity> postResult = [];

  void _onType(String content) async {
    final provider = Provider.of<SearchProvider>(context, listen: false);
    List<PostEntity> newResult = await provider.getPostsByContent(content);
    setState(() {
      postResult = newResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBars.backAppBar(context),
        body: Column(
          children: [
            DescolarSearchBar.searchBar(
              placeHolder: 'Rechercher',
              controller: controller,
              onChanged: _onType,
            ),
            const TabBar(
              tabs: [
                Tab(text: 'Utilisateurs', height: 30),
                Tab(text: 'Posts', height: 30),
              ],
            ),
            const Divider(height: 10, color: Colors.grey),
            Expanded(
              child: TabBarView(
                children: [
                  const Center(
                    child: Text('Utilisateurs'),
                  ),
                  ListView.builder(
                    itemCount: postResult.length,
                    itemBuilder: (context, index) {
                      final post = postResult[postResult.length - 1 - index];
                      return PostItem(post: post);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
