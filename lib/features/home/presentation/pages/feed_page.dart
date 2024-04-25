import 'package:descolar_front/core/components/app_bars.dart';
import 'package:descolar_front/core/components/navigation_bar.dart';
import 'package:descolar_front/core/constants/cached_posts.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/auth/presentation/widgets/cgu_text.dart';
import 'package:descolar_front/features/post/presentation/providers/get_post_provider.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      GetPostProvider provider = Provider.of<GetPostProvider>(context, listen: false);
      provider.addPostsToFeed();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );
    final GlobalKey<ScaffoldState> key = GlobalKey();
    GetPostProvider provider = Provider.of<GetPostProvider>(context);
    return Scaffold(
      key: key,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          AppBars.homeSliverAppBar(context, key),
        ],
        body: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async {
            provider.addPostsToFeed();
          },
          child: ListView(
            children: CachedPost.feed.reversed.map((item) {
              return PostItem(
                post: item,
              );
            }).toList(),
          ),
        ),
      ),
      bottomNavigationBar: DescolarNavigationBar.mainNavBar(context),
      drawer: Drawer(
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
              title: const Text(
                'Conditions Générales d\'Utilisation',
              ),
              onTap: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CGUText(),));
              },
            ),
            ListTile(
              title: const Text(
                'Se déconnecter',
                style: TextStyle(
                  color: AppColors.error,
                ),
              ),
              onTap: () async {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
