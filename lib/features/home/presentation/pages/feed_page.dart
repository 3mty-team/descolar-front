import 'package:descolar_front/core/components/app_bars.dart';
import 'package:descolar_front/core/components/navigation_bar.dart';
import 'package:descolar_front/core/constants/cached_posts.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/post/presentation/providers/get_post_provider.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
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
      appBar: AppBars.homeAppBar(context, key),
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
