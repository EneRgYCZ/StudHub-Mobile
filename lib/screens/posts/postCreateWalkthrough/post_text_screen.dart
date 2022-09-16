import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studhub/services/firestore.dart';
import 'package:studhub/services/models.dart';
import 'package:studhub/shared/screen_arguments.dart';

class PostTextScreen extends StatefulWidget {
  const PostTextScreen({Key? key}) : super(key: key);

  @override
  State<PostTextScreen> createState() => _PostTextScreenState();
}

class _PostTextScreenState extends State<PostTextScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _text = TextEditingController();

  var isEmpty = false;

  @override
  void initState() {
    super.initState();
    _text.addListener(() {
      setState(() {
        isEmpty = _text.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final passedData =
        ModalRoute.of(context)!.settings.arguments as PostArguments;
    final user = Provider.of<UserDetails>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 25),
        child: Form(
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: isEmpty
                        ? () {
                            FirestoreService().createPost(_text.text,
                                passedData.title, passedData.skills, user);
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil('/', (route) => false);
                          }
                        : null,
                    child: const Text("Post"),
                  )
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
                      isEmpty = true;
                      return 'Please enter some text';
                    }
                    isEmpty = false;
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
