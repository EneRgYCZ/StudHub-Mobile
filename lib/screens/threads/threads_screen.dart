import 'package:flutter/material.dart';

class ThreadScreen extends StatelessWidget {
  const ThreadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thread"),
      ),
      body: Column(
        children: [
          Center(
            child: const Text("Thread"),
          )
        ],
      ),
    );
  }
}
