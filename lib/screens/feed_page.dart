import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:descolar_front/core/components/app_bars.dart';
import 'package:descolar_front/core/components/navigation_bar.dart';
import 'package:descolar_front/core/constants/cached_posts.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/auth/presentation/widgets/cgu_text.dart';
import 'package:descolar_front/features/post/presentation/providers/get_post_provider.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_item.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<GetPostProvider>(context, listen: false);
      provider.getLikedPost();
      provider.addPostsToFeed();
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final provider = Provider.of<GetPostProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, _) => [
          AppBars.homeSliverAppBar(context, scaffoldKey),
        ],
        body: _buildPostFeed(provider),
      ),
      bottomNavigationBar: DescolarNavigationBar.mainNavBar(context),
      drawer: _buildDrawer(context),
    );
  }

  Widget _buildPostFeed(GetPostProvider provider) {
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        provider.getLikedPost();
        provider.addPostsToFeed();
      },
      child: ListView.builder(
        itemCount: CachedPost.feed.reversed.length,
        itemBuilder: (context, index) {
          final post = CachedPost.feed.reversed.toList()[index];
          return PostItem(post: post);
        },
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
            child: Text('Paramètres'),
          ),
          ListTile(
            title: const Text("Conditions Générales d'Utilisation"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CGUText(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Se déconnecter',
              style: TextStyle(
                color: AppColors.error,
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
