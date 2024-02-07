//body.dart
import 'package:flutter/material.dart';
import 'package:todolist/model/functionApi.dart';
import 'package:todolist/screens/todoScreen/components/tache_widget.dart';

import '../../../model/todo.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String val = '';
  TextEditingController todo = TextEditingController();
  List<Todo> maListe = [];

  int i = 2;
  Todo? currentTodo; // Déclarer currentTodo en dehors du setState

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  void loadTodos() async {
    try {
      List<Todo> todosList = await receiveTodo(); //la methode get todo
      setState(() {
        maListe = todosList;
      });
    } catch (e) {
      debugPrint("Error loading todos: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Text(
                "Todoslist",
                textScaleFactor: 3,
                style: TextStyle(
                  letterSpacing: 3,
                  color: Colors.deepPurpleAccent,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: todo,
                // onEditingComplete: () {},
                keyboardType: TextInputType.text,
                onSubmitted: (String s) async {
                  setState(() {
                    val = s;
                    todo.text = '';
                    currentTodo = Todo(
                      name: s,
                      id: i,
                      isClick: true,
                    );
                    maListe.add(currentTodo!); // Utilisation de currentTodo ici
                    i++;
                  });
                  try {
                    if (currentTodo != null) {
                      await postTodo(
                          currentTodo!); // Utilisation de currentTodo ici
                    }
                  } catch (e) {
                    debugPrint("Error adding todo: $e");
                    setState(() {
                      if (currentTodo != null) {
                        maListe.remove(
                            currentTodo!); // Utilisation de currentTodo ici
                      }
                    });
                  }
                },
                decoration: const InputDecoration(
                  labelText: "Enter your todos",
                  hintText: "Task 1: do something",
                  contentPadding: EdgeInsets.only(left: 20, bottom: 35),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              ...List.generate(
                  maListe.length,
                  (index) => Dismissible(
                        background: Container(
                          decoration: const BoxDecoration(
                            color: Colors.deepPurpleAccent,
                          ),
                          width: MediaQuery.of(context).size.width,
                        ),
                        direction: DismissDirection.startToEnd,
                        key: Key(maListe[index].id.toString()),
                        onDismissed: (direction) async {
                          Todo currentTodo = maListe[index];
                          setState(() {
                            maListe.remove(currentTodo);
                          });
                          try {
                            await deleteTodo(currentTodo.id); //le delete
                          } catch (e) {
                            debugPrint("Error deleting todo: $e");
                            setState(() {
                              maListe.insert(index, currentTodo);
                            });
                          }
                        },
                        child: TacheWidget(
                          todo: maListe[index],
                        ),
                      )),
              // make index removable onSecondaryTap
            ],
          ),
        ),
      ),
    );
  }
}
