import 'package:studhub/services/models.dart';

class ChatArguments {
  final String roomId;
  final UserDetails userData;

  ChatArguments(this.roomId, this.userData);
}

class PostArguments {
  final String title;
  final List skills;

  PostArguments(this.title, this.skills);
}
