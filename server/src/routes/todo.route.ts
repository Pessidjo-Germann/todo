// src/routes/todo.routes.ts
import { Router } from 'express';
import { Todo } from '../models/todo.model';

export const todoRouter = Router();

// In-memory array to store todos
const todos: Todo[] = [];
todos.push({  name: 'Learn React',id: 1, isClick: false });

// Get all todos
todoRouter.get('/', (req, res) => {
  console.log("je suis charge la maintenant");//
  res.json({"message":todos});
});

// Create a new todo
todoRouter.post('/', (req, res) => {
  console.log("Je suis ajouter la maintenant");
  const newTodo: Todo = req.body;
  todos.push(newTodo);
  res.status(201).json(newTodo);
});

// supprimer un todo
todoRouter.delete('/:id', (req, res) => {
  console.log("Je suis supprimer la maintenant");
  const id = parseInt(req.params.id);
  const index = todos.findIndex((todo) => todo.id === id);
  if (index >= 0) {
    todos.splice(index, 1);
    res.status(204).end();
  } else {
    res.status(404).end();
  }
});
