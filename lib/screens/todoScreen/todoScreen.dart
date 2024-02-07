// todoScreen.dart 
import 'package:flutter/material.dart';

import 'components/body.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});
  static String routeName = "/todo";

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODOS LIST"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: const Body(),
    );
  }
}
