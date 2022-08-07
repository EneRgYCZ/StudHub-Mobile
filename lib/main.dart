import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:studhub/theme.dart';
import 'package:studhub/routes.dart';
import 'package:studhub/services/models.dart';
import 'package:studhub/services/firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          List<Blog> blogs = [];
          return MultiProvider(
            providers: [
              StreamProvider<UserInfo>(
                create: (_) => FirestoreService().streamCurrentUserData(),
                initialData: UserInfo(),
              ),
              StreamProvider<List<Blog>>(
                create: (_) => FirestoreService().streamBlogData(),
                initialData: blogs,
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              routes: appRoutes,
              theme: appTheme,
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Text('loading');
      },
    );
  }
}
