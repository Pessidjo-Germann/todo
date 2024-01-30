//functionApi.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todolist/model/todo.dart';

Future<void> postTodo(List<Todo> list) async {

  final uri = Uri.parse("http://127.0.0.1:3000");
  Map<String, List<Todo>> request = {"list": list};

  try {
    final response = await http.post(uri, body: request);
    if (response.statusCode == 200) {
      debugPrint("Succeful send");
    } else {
      throw Exception('Erreur lors de la sauvegarde');
    }
  } catch (e) {
    throw Exception('Fail to load get');
  }
}

Future<List<Todo>> receiveTodo() async {
  final uri = Uri.parse("uri");

  try {

    final response = await http.post(uri);

    if (response.statusCode == 200) {
      Map<List<String>, dynamic> data = jsonDecode(response.body);
      return data[''];
    }
    else {
      throw Exception('Erreur lors de l envoie du get');
    }
  } catch (e) {
    throw Exception('erreur au nivequ de la connexion');
  }
}
