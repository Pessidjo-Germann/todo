//functionApi.dart
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todolist/model/todo.dart';

Future<void> deleteTodo(int id) async {
  final uri = Uri.parse("http://192.168.56.1:3000/$id");
  try {
    final response = await http.delete(uri);
    if (response.statusCode == 204) {
      debugPrint("Delete successful");
    } else {
      throw Exception('Failed to delete todo');
    }
  } catch (e) {
    throw Exception('Failed to delete todo: $e');
  }
}

Future<void> postTodo(Todo todo) async {
  final uri = Uri.parse("http://192.168.56.1:3000/");
  try {
    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(todo.toJson()), // Convertir Todo en JSON
    );
    if (response.statusCode == 201) {
      debugPrint("Post successful");
    } else {
      throw Exception('Failed to create todo');
    }
  } catch (e) {
    throw Exception('Failed to create todo: $e');
  }
}

Future<List<Todo>> receiveTodo() async {
  final uri = Uri.parse("http://192.168.56.1:3000/");

  try {
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)["message"];
      List<Todo> todos = data.map((e) => Todo.fromJson(e)).toList();
      return todos;
    } else {
      throw Exception('Erreur lors de l envoie du get');
    }
  } catch (e) {
    throw Exception('erreur au nivequ de la connexion');
  }
}
