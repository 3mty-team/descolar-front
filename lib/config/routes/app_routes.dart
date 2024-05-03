/*
  /!\ MAYBE USELESS WITH PROVIDERS /!\ 
*/

import 'package:descolar_front/features/auth/presentation/pages/login_page.dart';
import 'package:descolar_front/features/auth/presentation/pages/signup_page.dart';
import 'package:descolar_front/features/auth/presentation/pages/user_created_success.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/post/presentation/pages/new_comment_page.dart';
import 'package:descolar_front/features/post/presentation/pages/new_quote_page.dart';
import 'package:descolar_front/features/post/presentation/pages/new_report_page.dart';
import 'package:descolar_front/features/post/presentation/pages/view_post_page.dart';
import 'package:descolar_front/screens/feed_page.dart';
import 'package:descolar_front/features/messages/presentation/pages/messages_menu_page.dart';
import 'package:descolar_front/features/post/presentation/pages/new_post_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return _materialRoute(const Home());
      case '/search':
        return _materialRoute(const Home());
      case '/newPost':
        return _materialRoute(const NewPost());
      case '/newQuote':
        final quotedPost = settings.arguments as PostEntity;
        return MaterialPageRoute(builder: (_) => NewQuote(post: quotedPost));
      case '/newComment':
        final commentedPost = settings.arguments as PostEntity;
        return MaterialPageRoute(builder: (_) => NewComment(post: commentedPost));
      case '/report':
        final reportedPost = settings.arguments as PostEntity;
        return MaterialPageRoute(builder: (_) => NewReport(post: reportedPost));
      case '/viewPost':
        final post = settings.arguments as PostEntity;
        return MaterialPageRoute(builder: (_) => ViewPostPage(post: post));
      case '/myProfil':
        return _materialRoute(const Home());
      case '/messages':
        return _materialRoute(const MessagesMenu());
      case '/settings':
        return _materialRoute(const Home());
      case '/signup':
        return _materialRoute(const SignupPage());
      case '/login':
        return _materialRoute(const LoginPage());
      case '/user-created-success':
        return _materialRoute(const UserCreatedSuccessPage());
      default:
        return _materialRoute(const Home());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
