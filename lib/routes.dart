import 'package:studhub/screens/chat/chat_screen.dart';
import 'package:studhub/screens/blog/blog_screen.dart';
import 'package:studhub/screens/home/home_screen.dart';
import 'package:studhub/screens/posts/posts_screen.dart';
import 'package:studhub/screens/login/login_screen.dart';
import 'package:studhub/screens/chat/message_screen.dart';
import 'package:studhub/screens/search/search_screen.dart';
import 'package:studhub/screens/profile/profile_screen.dart';
import 'package:studhub/screens/posts/post_create_screen.dart';
import 'package:studhub/screens/login/email_login_screen.dart';
import 'package:studhub/screens/profile/profile_setup_screen.dart';
import 'package:studhub/screens/notifications/notifications_screen.dart';

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
  '/profile_setup': (context) => const ProfileSetupScreen(),
  '/login_with_email': (context) => const EmailLoginScreen(),
  '/notifications': (context) => const NotificationsScreen(),
};
