import 'package:flutter/material.dart';
import 'package:studhub/widgets/post/skill_picks_widget.dart';

class PostFromWidget extends StatefulWidget {
  const PostFromWidget({Key? key}) : super(key: key);

  @override
  State<PostFromWidget> createState() => _PostFromWidgetState();
}

class _PostFromWidgetState extends State<PostFromWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false),
                icon: const Icon(Icons.cancel_outlined),
              ),
              TextButton(
                  onPressed: () {
                    SkillPicksWidget(text: _text.text);
                  },
                  child: const Text("Next"))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17),
            child: TextFormField(
              controller: _text,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 5,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
