import 'package:studhub/screens/chat/chat.dart';
import 'package:studhub/screens/blog/blog.dart';
import 'package:studhub/screens/home/home.dart';
import 'package:studhub/screens/login/email_login_screen.dart';
import 'package:studhub/screens/posts/posts.dart';
import 'package:studhub/screens/login/login.dart';
import 'package:studhub/screens/search/search.dart';
import 'package:studhub/screens/profile/profile.dart';
import 'package:studhub/screens/posts/post_create.dart';
import 'package:studhub/screens/chat/messageScreen.dart';
import 'package:studhub/screens/notifications/notifications.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/blog': (context) => const BlogScreen(),
  '/chat': (context) => const ChatScreen(),
  '/login': (context) => const LoginScreen(),
  '/posts': (context) => const PostsScreen(),
  '/search': (context) => const SearchScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/message_screen': (context) => const MessageScreen(),
  '/post_create': (context) => const PostCreateScreen(),
  '/login_with_email': (context) => const EmailLoginScreen(),
  '/notifications': (context) => const NotificationsScreen(),
};
