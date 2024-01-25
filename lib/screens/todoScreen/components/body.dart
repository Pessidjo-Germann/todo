import 'package:flutter/material.dart';

import '../../../model/todo.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isClick = true;
  String val = '';
  TextEditingController todo = TextEditingController();
  List<Todo> maListe = [];

  int i = 0;
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
                    Todo todos = Todo(s, i);

                    maListe.add(todos);
                    i++;
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
                          });
                        },
                        child: TacheWidget(
                          text: maListe[index].name,
                        ),
                      )),
            ],
          ),
        ),
      ),
    );
  }
}

class TacheWidget extends StatefulWidget {
  TacheWidget({super.key, required this.text});
  String text = '';

  @override
  State<TacheWidget> createState() => _TacheWidgetState();
}

class _TacheWidgetState extends State<TacheWidget> {
  late bool isClick = true;

  TextStyle boldStyle = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20,
    decoration: TextDecoration.none,
  );

  TextStyle todoDo = const TextStyle(
    fontWeight: FontWeight.w100,
    fontSize: 17,
    decoration: TextDecoration.lineThrough,
  );
  @override
  Widget build(BuildContext context) {
    return addTach(context);
  }

  InkWell addTach(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isClick = !isClick;
          if (isClick == false) {
            debugPrint("germann");
          }
        });
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.2),
        ),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.text,
              style: isClick ? boldStyle : todoDo,
            )),
      ),
    );
  }
}
