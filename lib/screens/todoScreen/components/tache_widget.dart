
import 'package:flutter/material.dart';

import '../../../model/todo.dart';

// ignore: must_be_immutable
class TacheWidget extends StatefulWidget {
  TacheWidget({super.key, required this.todo});
  Todo todo;

  @override
  State<TacheWidget> createState() => _TacheWidgetState();
}

class _TacheWidgetState extends State<TacheWidget> {
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
          widget.todo.isClick = !widget.todo.isClick;
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
              widget.todo.name,
              style: widget.todo.isClick ? boldStyle : todoDo,
            )),
      ),
    );
  }
}