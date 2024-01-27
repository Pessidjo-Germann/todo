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

  int i = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    maListe = receiveTodo() as List<Todo>;
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
                onSubmitted: (String s) {
                  setState(() {
                    val = s;
                    todo.text = '';
                    Todo todos = Todo(s, i, true);

                    maListe.add(todos);
                    i++;
                    postTodo(
                        maListe); //envoie de la liste apres ajout d'une todo;
                  });
                  debugPrint(todo.text);
                },
                decoration: const InputDecoration(
                  labelText: "Enter your todos",
                  hintText: "Entrer your todos",
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
                          child: const Text(
                            "Effacer la tache ?",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Arial',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        direction: DismissDirection.startToEnd,
                        key: Key(maListe[index].id.toString()),
                        onDismissed: (direction) {
                          Todo currentTodo = maListe[index];
                          setState(() {
                            maListe.remove(currentTodo);
                            postTodo(
                                maListe); //envoie de la liste apres suppression;
                          });
                        },
                        child: TacheWidget(
                          todo: maListe[index],
                        ),
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
