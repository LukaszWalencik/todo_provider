import 'package:flutter/material.dart';
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
        ChangeNotifierProvider<TodoFilter>(create: (context) => TodoFilter()),
        ChangeNotifierProvider<TodoSearch>(create: (context) => TodoSearch()),
        ChangeNotifierProvider<TodoList>(create: (context) => TodoList()),
        ChangeNotifierProxyProvider<TodoList, ActiveTodoCount>(
          create: (context) => ActiveTodoCount(
              initialActiveTodoCount:
                  context.read<TodoList>().state.todos.length),
          update: (BuildContext context, TodoList todoList,
                  ActiveTodoCount? activeTodoCount) =>
              activeTodoCount!..update(todoList),
        ),
        ChangeNotifierProxyProvider3<TodoSearch, TodoList, TodoFilter,
                FilteredTodos>(
            create: (context) => FilteredTodos(),
            update: (BuildContext context,
                    TodoSearch todoSearch,
                    TodoList todoList,
                    TodoFilter todoFilter,
                    FilteredTodos? filteredTodos) =>
                filteredTodos!..update(todoFilter, todoSearch, todoList))
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
