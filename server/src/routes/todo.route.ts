// src/routes/todo.routes.ts
import { Router } from 'express';
import { Todo } from '../models/todo.model';

export const todoRouter = Router();

// In-memory array to store todos
const todos: Todo[] = [];
todos.push({ id: 1, title: 'Learn React', completed: false });

// Get all todos
todoRouter.get('/', (req, res) => {
  res.json(todos);
});

// Create a new todo
todoRouter.post('/', (req, res) => {
  const newTodo: Todo = req.body;
  todos.push(newTodo);
  res.status(201).json(newTodo);
});

// supprimer un todo
todoRouter.delete('/:id', (req, res) => {
  const id = parseInt(req.params.id);
  const index = todos.findIndex((todo) => todo.id === id);
  if (index >= 0) {
    todos.splice(index, 1);
    res.status(204).end();
  } else {
    res.status(404).end();
  }
});
