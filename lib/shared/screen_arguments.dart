import 'package:studhub/services/models.dart';

class ChatArguments {
  final String roomId;
  final UserDetails userData;

  ChatArguments(this.roomId, this.userData);
}

class PostArguments {
  final List tags;
  final List skills;
  final String title;

  PostArguments(this.title, this.skills, this.tags);
}
