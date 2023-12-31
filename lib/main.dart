import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/pages/todos_page.dart';
import 'package:todo_provider/providers/active_todo_count.dart';
import 'package:todo_provider/providers/filtered_todos.dart';
import 'package:todo_provider/providers/todo_filter.dart';
import 'package:todo_provider/providers/todo_list.dart';
import 'package:todo_provider/providers/todo_search_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider<TodoFilter, TodoFilterState>(
            create: (context) => TodoFilter()),
        StateNotifierProvider<TodoSearch, TodoSearchState>(
            create: (context) => TodoSearch()),
        StateNotifierProvider<TodoList, TodoListState>(
            create: (context) => TodoList()),
        StateNotifierProvider<ActiveTodoCount, ActiveTodoCountState>(
            create: (context) => ActiveTodoCount()),
        StateNotifierProvider<FilteredTodos, FilteredTodosState>(
            create: (context) => FilteredTodos()),
      ],
      child: MaterialApp(
          title: 'Todos',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: TodosPage()),
    );
  }
}
