import 'package:descolar_front/core/components/app_bars.dart';
import 'package:descolar_front/core/components/navigation_bar.dart';
import 'package:flutter/material.dart';

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
    );
  }
}
