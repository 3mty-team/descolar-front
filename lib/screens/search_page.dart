import 'package:flutter/material.dart';

import 'package:descolar_front/core/components/app_bars.dart';
import 'package:descolar_front/core/components/search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBars.backAppBar(context),
        body: Column(
          children: [
            DescolarSearchBar.searchBar('Rechercher', this.controller),
            const TabBar(
              tabs: [
                Tab(
                  text: 'Utilisateurs',
                  height: 30,
                ),
                Tab(
                  text: 'Posts',
                  height: 30,
                ),
              ],
            ),
            const Divider(height: 10, color: Colors.grey),
            const Expanded(
              child: TabBarView(
                children: [
                  Center(
                    child: Text('Utilisateurs'),
                  ),
                  Center(
                    child: Text('Posts'),
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
