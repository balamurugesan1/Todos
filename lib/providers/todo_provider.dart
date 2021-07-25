//package imports
import 'package:flutter/foundation.dart';
// import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// models import
import '../models/todo_model.dart';
import '../helpers/db_helper.dart';

class TodoProvider extends ChangeNotifier {
  static bool isDarkModeOn = false;

  //light theme
  ThemeData _selectedTheme;
  ThemeData light = ThemeData.light().copyWith(
      appBarTheme: AppBarTheme(
        color: Color(0xff572E6C),
        titleSpacing: 5.0,
        centerTitle: true,
      ),
      primaryColor: Color(0xff572E6C),
      accentColor: Color(0xffFDF862),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color(0xff572E6C),
      ));

  //dark theme
  ThemeData dark = ThemeData.dark().copyWith(
      appBarTheme: AppBarTheme(
        color: Color(0xff000000),
        titleSpacing: 5.0,
        centerTitle: true,
      ),
      primaryColor: Colors.black,
      accentColor: Colors.black,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.black));
  TodoProvider({bool isDarkModeOn}) {
    _selectedTheme = isDarkModeOn ? dark : light;
  }
  //methods to swap theme
  void swapTheme() {
    _selectedTheme = _selectedTheme == dark ? light : dark;
    notifyListeners();
  }

  ThemeData get getTheme => _selectedTheme;

  List<Todos> todoListItems = [];

  //add todo
  addTodos(String id, String title, DateTime date) async {
    final newTodo = Todos(
        id: DateTime.now().toString(),
        title: title,
        date: DateFormat("yyyy-MM-dd").format(date));
    DBHelper.insert('user_todo',
        {'id': newTodo.id, 'title': newTodo.title, 'date': newTodo.date});
    notifyListeners();
  }

  //delete todos
  deleteTodos(String id) async {
    await DBHelper.deleteTodos(id);
    todoListItems.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  //get todo from database
  bool isLoading = true;
  Future<void> getTodos() async {
    isLoading = true;
    todoListItems = [];
    final dataList = await DBHelper.getData('user_todo');
    dataList.forEach((element) {
      todoListItems.add(Todos(
          id: element['id'],
          title: element['title'],
          date: element['date'].toString()));
    });
    isLoading = false;
    notifyListeners();
  }
}
