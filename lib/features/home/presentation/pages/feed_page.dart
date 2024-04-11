import 'package:descolar_front/core/components/app_bars.dart';
import 'package:descolar_front/core/components/navigation_bar.dart';
import 'package:descolar_front/features/auth/data/datasources/user_local_data_source.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.homeAppBar(context),
      bottomNavigationBar: DescolarNavigationBar.mainNavBar(context),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            PostItem(
              username: Text('Zakiryo'),
              text: Text(
                'Ouais salut les gens oe oe oeeeedfizhefeiuzofheuifhzfhezfiuehofafhuiegfiuoghyrifgzoifyuegfyieghfoiuafueiofghieafghyafgehoifeayfge',
              ),
              likes: 43,
              responses: 12,
              profilPicture: Icon(Icons.account_circle_rounded, size: 40),
            ),
            PostItem(
              username: Text('Zakiryo'),
              text: Text(
                'Ouais salut les gens oe oe oeeeedfizhefeiuzofheuifhzfhezfiuehofafhuiegfiuoghyrifgzoifyuegfyieghfoiuafueiofghieafghyafgehoifeayfge',
              ),
              likes: 43,
              responses: 12,
              profilPicture: Icon(Icons.account_circle_rounded, size: 40),
            ),
          ],
        ),
      ),
    );
  }
}
