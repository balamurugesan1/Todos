import 'package:Todos/common/AppTextStyles.dart';
import 'package:Todos/common/Colors.dart';
import 'package:Todos/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final nickNameController = TextEditingController();
    final nickData = GetStorage();

    void getNickName() {
      String nickName = nickNameController.text;
      if (nickName != '') {
        print('successful');
        nickData.write('isLogged', true);
        nickData.write('nickname', nickName);
        Get.to(() => HomePage());
      } else {
        Get.snackbar("Error", "Please enter Nickname");
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Form(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset("assets/images/welcome-screen.png"),
                    TextField(
                      style: TextStyle(color: AppColors.primaryColor),
                      cursorColor: AppColors.primaryColor,
                      controller: nickNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: AppColors.primaryColor),
                        disabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                                BorderSide(color: AppColors.primaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                                BorderSide(color: AppColors.primaryColor)),
                        labelText: 'Nickname',
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        getNickName();
                        print("object");
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Center(
                          child: Text(
                            "Save",
                            style: AppTextStyle.semiBoldStyle(
                                fontSize: 18,
                                color: AppColors.lightBlueColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
