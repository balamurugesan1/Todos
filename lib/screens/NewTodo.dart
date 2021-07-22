//package imports
import 'package:Todos/common/Colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

//provider file
import '../providers/todo_provider.dart';

class NewTodo extends StatefulWidget {
  final Function addTd;
  NewTodo(this.addTd);
  @override
  _NewTodoState createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final _titleController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final entertedTitle = _titleController.text;
    if (entertedTitle.isEmpty || _selectedDate == null) {
      return;
    }
    widget.addTd(entertedTitle, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2070))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 30,
        ),
        child: Column(
          children: [
            TextField(
              cursorColor: AppColors.primaryColor,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: AppColors.primaryColor)),
                  labelText: 'Todo',
                  labelStyle: TextStyle(color: AppColors.primaryColor),
                  prefixIcon: Icon(
                    Icons.edit,
                    color: AppColors.primaryColor,
                  )),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat('yMd').format(_selectedDate)}',
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      _presentDatePicker();
                    },
                    color: AppColors.primaryColor,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                        color: AppColors.lightBlueColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (_titleController.text == "") {
                      Toast.show("Title cannot be empty", context);
                    } else {
                      Provider.of<TodoProvider>(context, listen: false)
                          .addTodos(DateTime.now().toString(),
                              _titleController.text, _selectedDate);
                      // _submitData();
                      Provider.of<TodoProvider>(context, listen: false)
                          .getTodos();
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Center(
                      child: Text(
                        "Add Todo",
                        style: TextStyle(
                            fontSize: 18,
                            color: AppColors.lightBlueColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
