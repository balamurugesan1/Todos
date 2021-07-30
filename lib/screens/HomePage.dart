//package imports
import 'package:Todos/common/AppTextStyles.dart';
import 'package:Todos/common/Colors.dart';
import 'package:Todos/screens/BirthdayRemainder.dart';

import 'package:Todos/screens/BmiCalculator.dart';
import 'package:Todos/screens/MathCalculator.dart';
import 'package:Todos/screens/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:Todos/providers/todo_provider.dart';

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

final nickName = GetStorage();
final ScrollController _scrollController = ScrollController();

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
        backgroundColor: Color(0xff28282B),
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

  // void _openEditName(BuildContext ctx) {
  //   showModalBottomSheet(
  //       context: ctx,
  //       builder: (_) {
  //         return Column(children: [
  //           TextField(
  //             decoration: InputDecoration(labelText: "Nick Name"),
  //           ),
  //           TextButton(onPressed: () {}, child: Text("Save"))
  //         ]);
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                  child: Text("Hello ${nickName.read("nickname")} !",
                      style: AppTextStyle.heading1Style(
                          color: AppColors.lightBlueColor))),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
              ),
            ),
            Expanded(
                child: Container(
                    child: ListView(
              children: [
                ListTile(
                  title: const Text('BMI Calculator'),
                  subtitle: const Text('Soon'),
                  leading: Icon(Icons.accessibility),
                  onTap: () {
                    Get.to(() => BmiCalculator());
                  },
                ),
                Divider(
                  height: 10,
                ),
                ListTile(
                  title: const Text('Calculator'),
                  subtitle: const Text('Soon'),
                  leading: const Icon(Icons.calculate),
                  onTap: () {
                    Get.to(() => MathCalculator());
                  },
                ),
                Divider(
                  height: 10,
                ),
                ListTile(
                  title: const Text('Birthday Reminder'),
                  subtitle: const Text('Soon'),
                  leading: Icon(Icons.wallet_giftcard),
                  onTap: () {
                    Get.to(() => BirthdayRemainder());
                  },
                ),
                Divider(
                  height: 10,
                ),
              ],
            ))),
            ListTile(
              title: const Text('Edit Nickname'),
              leading: Icon(Icons.edit),
              onTap: () {
                nickName.write("isLogged", false);
                nickName.remove('nickname');
                Get.offAll(() => WelcomeScreen());
              },
            ),
            Divider(
              height: 10,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.lightBlueColor),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
              icon: Icon(Icons.light_mode_outlined),
              color: AppColors.lightBlueColor,
              onPressed: () {
                TodoProvider themeProvider =
                    Provider.of<TodoProvider>(context, listen: false);
                themeProvider.swapTheme();
              }),
          // PopupMenuButton(
          //   itemBuilder: (context) => [
          //     PopupMenuItem(
          //         child: Row(
          //       children: [
          //         Icon(
          //           Icons.delete,
          //           color: AppColors.lightBlueColor,
          //         ),
          //         const SizedBox(
          //           width: 12,
          //         ),
          //         Text("Delete")
          //       ],
          //     )),
          //     PopupMenuItem(
          //         child: GestureDetector(
          //       onTap: () {
          //         _openEditName(context);
          //       },
          //       child: Row(
          //         children: [
          //           Icon(
          //             Icons.share,
          //             color: AppColors.lightBlueColor,
          //           ),
          //           const SizedBox(
          //             width: 12,
          //           ),
          //           Text("Share")
          //         ],
          //       ),
          //     )),
          //     PopupMenuItem(
          //         child: GestureDetector(
          //       onTap: () {
          //         nickName.write("isLogged", false);
          //         nickName.remove('nickname');
          //         Get.offAll(() => WelcomeScreen());
          //         print("object");
          //       },
          //       child: Row(
          //         children: [
          //           Icon(
          //             Icons.edit,
          //             color: AppColors.lightBlueColor,
          //           ),
          //           const SizedBox(
          //             width: 12,
          //           ),
          //           Text("Edit Name")
          //         ],
          //       ),
          //     ))
          //   ],
          //   child: Icon(
          //     Icons.more_vert,
          //     color: AppColors.lightBlueColor,
          //   ),
          // )
        ],
        title: const Text(
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
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: AppColors.lightBlueColor,
      //     child: Icon(
      //       Icons.add,
      //       color: AppColors.primaryColor,
      //       size: 30.0,
      //     ),
      //     onPressed: () {
      //       _openModelBottomSheet(context);
      //     }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // FloatingActionButton(onPressed: () {
            //   _scrollController.animateTo(
            //       _scrollController.position.minScrollExtent,
            //       duration: Duration(milliseconds: 500),
            //       curve: Curves.fastOutSlowIn);
            // }),
            FloatingActionButton(
                backgroundColor: AppColors.lightBlueColor,
                child: Icon(
                  Icons.add,
                  color: AppColors.primaryColor,
                  size: 30.0,
                ),
                onPressed: () {
                  _openModelBottomSheet(context);
                }),
            // FloatingActionButton(onPressed: () {
            //   _scrollController.animateTo(
            //       _scrollController.position.maxScrollExtent,
            //       duration: Duration(milliseconds: 500),
            //       curve: Curves.fastOutSlowIn);
            // })
          ],
        ),
      ),
    );
  }
}
