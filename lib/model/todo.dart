class Todo {
  final String name;
  final int id;
  bool isClick = false;

  Todo({
    required this.name,
    required this.id,
    required this.isClick,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': name,
      'id': id,
      'isClick': isClick,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      name: json['name'],
      id: json['id'],
      isClick: json['isClick'],
    );
  }
}
