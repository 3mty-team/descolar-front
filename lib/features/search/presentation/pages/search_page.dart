import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'package:descolar_front/features/search/presentation/widgets/user_result_item.dart';
import 'package:descolar_front/features/search/presentation/providers/search_provider.dart';
import 'package:descolar_front/core/components/app_bars.dart';
import 'package:descolar_front/core/components/search_bar.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<SearchProvider>(context, listen: false);
      provider.init();
    });
  }

  void _onType(String content) async {
    content = content.trim();
    if (content.isEmpty) {
      return;
    }
    final provider = Provider.of<SearchProvider>(context, listen: false);
    provider.getPostsByContent(content);
    provider.getUsersByUsername(content);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context);
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
                  provider.users == null
                      ? const Padding(
                          padding: EdgeInsets.only(top: 64),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : ListView.builder(
                          itemCount: provider.users!.length,
                          itemBuilder: (context, index) {
                            final user = provider.users![provider.users!.length - 1 - index];
                            return UserResultItem(user: user);
                          },
                        ),
                  provider.posts == null
                      ? const Padding(
                          padding: EdgeInsets.only(top: 64),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : ListView.builder(
                          itemCount: provider.posts!.length,
                          itemBuilder: (context, index) {
                            final post = provider.posts![provider.posts!.length - 1 - index];
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
