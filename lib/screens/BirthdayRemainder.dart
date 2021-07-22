import 'package:Todos/common/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';

class BirthdayRemainder extends StatelessWidget {
  static const routeName = '/birthday-remainder';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(
                  Icons.light_mode,
                  color: AppColors.lightBlueColor,
                ),
                color: AppColors.primaryColor,
                onPressed: () {
                  TodoProvider themeProvider =
                      Provider.of<TodoProvider>(context, listen: false);
                  themeProvider.swapTheme();
                })
          ],
          title: Text(
            'Birthday Remainder',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: RaisedButton(
            color: AppColors.primaryColor,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                Text(
                  'Back',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ));
  }
}
