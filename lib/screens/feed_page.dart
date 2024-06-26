import 'package:descolar_front/features/auth/presentation/providers/login_provider.dart';
import 'dart:convert';

import 'package:descolar_front/core/constants/user_info.dart';
import 'package:descolar_front/core/constants/websocket.dart';
import 'package:descolar_front/features/auth/business/repositories/user_repository.dart';
import 'package:descolar_front/features/auth/business/usecases/sign_out.dart';
import 'package:descolar_front/features/messages/presentation/provider/message_provider.dart';
import 'package:descolar_front/features/settings/presentation/providers/settings_provider.dart';
import 'package:descolar_front/core/components/app_bars.dart';
import 'package:descolar_front/core/components/navigation_bar.dart';
import 'package:descolar_front/core/constants/cached_posts.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/auth/presentation/widgets/cgu_text.dart';
import 'package:descolar_front/features/post/presentation/providers/get_post_provider.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

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
      // POSTS
      final postProvider = Provider.of<GetPostProvider>(context, listen: false);
      postProvider.getLikedPost();
      postProvider.addPostsToFeed();

      // WEB SOCKET
      MessageProvider messageProvider = Provider.of<MessageProvider>(context, listen: false);
      WebSocket.connect();
      WebSocket.channel.ready.then(
            (value) {
          debugPrint('CHANNEL READY');
          // Listen answers
          WebSocket.channel.stream.listen(
                (data) {
              debugPrint(data);
              data = json.decode(data);
              if (data['message'] != null) {
                // Check if message is send or received by uuid
                bool isMessageSent = data['fromUUID'] == UserInfo.user.uuid;
                if (isMessageSent) {
                  messageProvider.sendMessage(data['message'], data['toUUID'], isMessageSent, int.parse(data['iat']));
                }
                else {
                  messageProvider.sendMessage(data['message'], data['fromUUID'], isMessageSent, int.parse(data['iat']));
                }
              }
            },
            onDone: () {
              debugPrint('WS channel closed');
            },
            onError: (error) {
              debugPrint('WS error $error');
            },
          );

          // Connect to websocket channel
          // Sender
          WebSocket.channel.sink.add(
            json.encode({
              'method': 'register',
              'userUUID': UserInfo.user.uuid,
            }),
          );
        },
      );
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
        body: _buildPostFeed(context, provider),
      ),
      bottomNavigationBar: DescolarNavigationBar.mainNavBar(context),
      drawer: _buildDrawer(context),
    );
  }

  Widget _buildPostFeed(BuildContext context, GetPostProvider provider) {
    return RefreshIndicator(
      color: Theme.of(context).colorScheme.primary,
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
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Text(
              'Paramètres',
              style: TextStyle(color: AppColors.white, fontSize: 24),
            ),
          ),
          SwitchListTile(
            title: const Text('Mode sombre'),
            value: Provider.of<SettingsProvider>(context).isDarkMode,
            onChanged: (bool value) {
              Provider.of<SettingsProvider>(context, listen: false).toggleTheme();
            },
          ),
          ListTile(
            title: const Text('Comptes bloqués'),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/blocked-users',
              );
            },
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
            title: Text(
              'Se déconnecter',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            onTap: () async {
              UserRepository repository = await UserRepository.getUserRepository();
              final failureOrSignout = await SignOut(userRepository: repository).call();
              Provider.of<LoginProvider>(context, listen: false).reset();
              WebSocket.disconnect();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
