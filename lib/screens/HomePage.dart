//package imports
import 'package:Todos/common/Colors.dart';
import 'package:Todos/screens/BmiCalculator.dart';
import 'package:Todos/screens/MathCalculator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//provider file imports
import '../providers/todo_provider.dart';
//model import
import '../models/todo_model.dart';
//screen imports
import './NewTodo.dart';
import 'TodoList.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homepage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Todos> _userTodos = [];

  //method to add new todo
  void _addNewTodo(String tdTitle, DateTime chosenDate) {
    final newTd = Todos(
        id: DateTime.now().toString(),
        title: tdTitle,
        date: DateFormat("yyyy-MM-dd").format(chosenDate));
    setState(() {
      _userTodos.add(newTd);
    });
  }

  //method to delete a todo
  void _deleteTodo(String id) {
    TodoProvider deleteProvider =
        Provider.of<TodoProvider>(context, listen: false);
    deleteProvider.deleteTodos(id);
  }

  void _openModelBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        barrierColor: Color(0xffcdc0d3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {},
                child: NewTodo(_addNewTodo),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                  child: Text('Todos',
                      style: TextStyle(
                          color: AppColors.lightBlueColor, fontSize: 20.0))),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
              ),
            ),
            ListTile(
              title: Text('BMI Calculator'),
              subtitle: Text('Soon'),
              leading: Icon(Icons.accessibility),
              onTap: () {
                Navigator.of(context).pushNamed(BmiCalculator.routeName);
              },
            ),
            Divider(
              height: 10,
            ),
            ListTile(
              title: Text('Calculator'),
              subtitle: Text('Soon'),
              leading: Icon(Icons.calculate),
              onTap: () {
                Navigator.of(context).pushNamed(MathCalculator.routeName);
              },
            ),
            Divider(
              height: 10,
            ),
            ListTile(
              title: Text('Birthday Reminder'),
              subtitle: Text('Soon'),
              leading: Icon(Icons.wallet_giftcard),
              onTap: () {
                Navigator.of(context).pushNamed(BmiCalculator.routeName);
              },
            ),
            Divider(
              height: 10,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
              icon: Icon(Icons.light_mode_outlined),
              color: AppColors.lightBlueColor,
              onPressed: () {
                TodoProvider themeProvider =
                    Provider.of<TodoProvider>(context, listen: false);
                themeProvider.swapTheme();
              })
        ],
        title: Text(
          'Todos',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [TodoList(_userTodos, _deleteTodo)],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.lightBlueColor,
          child: Icon(
            Icons.add,
            color: AppColors.primaryColor,
            size: 30.0,
          ),
          onPressed: () {
            _openModelBottomSheet(context);
          }),
    );
  }
}
