import 'package:flutter/material.dart';

class PostFromWidget extends StatefulWidget {
  const PostFromWidget({Key? key}) : super(key: key);

  @override
  State<PostFromWidget> createState() => _PostFromWidgetState();
}

class _PostFromWidgetState extends State<PostFromWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _text = TextEditingController();

  var isEmpty = true;

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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: isEmpty
                    ? () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/profile_setup', (route) => false);
                      }
                    : null,
                child: const Text("Next"),
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
    );
  }
}
