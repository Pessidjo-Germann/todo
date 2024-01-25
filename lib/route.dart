import 'package:flutter/material.dart';
import 'package:todolist/screens/todoScreen/todoScreen.dart';

final Map<String, WidgetBuilder> route = {
  TodoScreen.routeName: (context) => const TodoScreen()
};
