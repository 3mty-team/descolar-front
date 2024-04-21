import 'package:descolar_front/core/components/app_bars.dart';
import 'package:descolar_front/core/components/navigation_bar.dart';
import 'package:descolar_front/core/constants/cached_posts.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/post/presentation/providers/get_post_provider.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    GetPostProvider provider = Provider.of<GetPostProvider>(context);
    return Scaffold(
      appBar: AppBars.homeAppBar(context),
      bottomNavigationBar: DescolarNavigationBar.mainNavBar(context),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async {
          provider.addPostsToFeed(context);
        },
        child: ListView(
          children: CachedPost.feed.reversed.map((item) {
            return PostItem(
              post: item,
            );
          }).toList(),
        ),
      ),
    );
  }
}
