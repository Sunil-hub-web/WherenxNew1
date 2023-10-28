import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../ApiCallingPage/SigninPage.dart';
import '../modelclass/logindata.dart';
import '../Dimension.dart';
import '../Routes/RouteHelper.dart';
import '../model/WherenxDeo.dart';
import '../model/WherenxEntity.dart';
import '../model/app_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:http/http.dart' as http;

class SignInScreen extends StatelessWidget {

  WherenxDeo? _todoDao;
  List<WherenxModel> todolist = [];
  List<ShowData> showDataList = [];
  List<String> todolist1 = [];
  final database = $FloorAppDatabase.databaseBuilder('Todo.db').build();

  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController mobileNoController = TextEditingController();
  List<ShowData> datalist = [];
  String email = "";


  SignInScreen({Key? key}) : super(key: key);

  // Future<http.Response> loginApi(String user_email) {
  //   return http.post(
  //     Uri.parse(ApiUrl.login),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{'user_email': user_email}),
  //   );
  // }

  Future<ShowData> _userLogin() async {
    email = mobileNoController.text.trim().toString();

    http.Response? response = await loginApi(email);
    var jsonResponse = json.decode(response!.body);
    var objRoot = ShowData.fromJson(jsonResponse);
    print(response.body);
    datalist.add(objRoot);
    print(response.body);

    return objRoot;
  }


  @override
  Widget build(BuildContext context) {

    int length = 3;

    List images = [
      "google.png",
      "facebook.png",
      "twitter.png",
    ];

    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(context,type: ProgressDialogType.normal);
    pr.style(
        message: 'Send Otp Wait...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: const CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w600)
    );

    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(6.123234262925839e-17, 1),
              end: Alignment(-1, 6.123234262925839e-17),
              colors: [
                Color.fromRGBO(31, 203, 220, 1),
                Color.fromRGBO(0, 184, 202, 1)
              ]),
        ),
        child: SingleChildScrollView(
          child: Container(
            height: Dimensions.screenHeight,
            width: Dimensions.screenWidth,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 42,
                          width: 38,
                          child: Image.asset(
                            'assets/images/logo_w.png',
                          ),
                        ),
                        const Text(
                          " WhereNX",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  //curve: Curves.easeInOutBack,
                  width: Dimensions.screenWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                // margin: EdgeInsets.only(top: 20, bottom: 20),
                                padding: const EdgeInsets.all(20),
                                child: const Center(
                                  child: Text('Sign in',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                          fontSize: 18)),
                                )),
                            //sign up
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Form(
                                key: formGlobalKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        bottom: 20,
                                      ),
                                      child: TextFormField(
                                        controller: mobileNoController,

                                        validator:  (value){
                                          if (value == null || value.isEmpty) {
                                            return 'Field can not be empyty';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          if (value.isEmpty) {
                                            return;
                                          }
                                          return null;
                                        },

                                        cursorColor: const Color(0xFFA1A8A9),
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF000000),
                                        ),
                                        decoration: const InputDecoration(
                                          isDense: true, // important line
                                          contentPadding: EdgeInsets.fromLTRB(15, 25, 25, 0),
                                          labelText:
                                              'Email address',
                                          labelStyle: TextStyle(
                                            color: Color(0xFFDDE4E4),
                                          ),
                                          floatingLabelStyle: TextStyle(
                                              color: Color(0xFFA1A8A9)),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFDDE4E4),
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFA1A8A9),
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 46,
                                      decoration: const ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xFF1FCBDC),
                                            Color(0xFF00B8CA)
                                          ],
                                        ),
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () async {

                                          if (formGlobalKey.currentState!.validate()) {
                                            formGlobalKey.currentState?.save();

                                        //    AppDatabase appDatabase = await database;
                                       //     _todoDao = appDatabase.wherenxdeo;
                                       //     todolist =  await _todoDao!.findAllTodo();

                                            // if(todolist != null)
                                            // {
                                            //
                                            //   for(int i = 0;i<todolist.length;i++){
                                            //
                                            //     if(todolist[i].mobileno == mobileNoController.text.toString()){
                                            //
                                            //       String todolist2 = todolist[i].mobileno;
                                            //       todolist1.add(todolist2);
                                            //
                                            //       SharedPreferences pre = await SharedPreferences.getInstance();
                                            //       pre.setString("name", todolist[i].name); //save string
                                            //       pre.setString("mobileNo", todolist[i].mobileno); //save integer
                                            //       pre.setString("countary", todolist[i].choose1); //save boolean
                                            //       pre.setString("state", todolist[i].choose2);
                                            //       pre.setBool("islogin", true); //save boolean//save double
                                            //       pre.setInt("userId", todolist[i].id); //save boolean//save double
                                            //
                                            //     };
                                            //   }
                                            //
                                            //   if(todolist1.contains(mobileNoController.text.toString())){
                                            //
                                            //     Get.toNamed(RouteHelper.getotpScreenpage());
                                            //
                                            //   }else{
                                            //
                                            //     Fluttertoast.showToast(
                                            //         msg: "Mobile No Not Found ?",
                                            //         toastLength: Toast.LENGTH_SHORT,
                                            //         gravity: ToastGravity.BOTTOM,
                                            //         timeInSecForIosWeb: 1,
                                            //         backgroundColor: Colors.green,
                                            //         textColor: Colors.white,
                                            //         fontSize: 16.0
                                            //     );
                                            //   }
                                            //
                                            // }
                                            // else{
                                            //
                                            //   Fluttertoast.showToast(
                                            //       msg: "Data Not Found ?",
                                            //       toastLength: Toast.LENGTH_SHORT,
                                            //       gravity: ToastGravity.BOTTOM,
                                            //       timeInSecForIosWeb: 1,
                                            //       backgroundColor: Colors.red,
                                            //       textColor: Colors.white,
                                            //       fontSize: 16.0
                                            //   );
                                            // }

                                            pr.show();

                                           // datalist.isNotEmpty ? const CircularProgressIndicator() : _userLogin();

                                            ShowData showData = await _userLogin();

                                            if(showData.status == "success"){

                                              pr.hide();

                                              Fluttertoast.showToast(
                                                  msg: showData.message!,
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0
                                              );

                                              Get.toNamed(RouteHelper.getotpScreenpage());
                                              SharedPreferences pre = await SharedPreferences.getInstance();
                                              pre.setInt("userId", showData.userId!); //save integer
                                              pre.setInt("otpId", showData.otpId!); //save integer
                                              pre.setInt("otp", showData.otp!); //save String
                                              pre.setString("email", email); //save String

                                            }else{

                                              pr.hide();

                                              Fluttertoast.showToast(
                                                  msg: showData.message!,
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0
                                              );

                                            }

                                          }else{
                                            pr.hide();

                                            Fluttertoast.showToast(
                                                msg: "Enter Email Id",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        },

                                        style: ElevatedButton.styleFrom(
                                          shadowColor: Colors.transparent,
                                          backgroundColor: Colors.transparent,
                                          minimumSize: Size(
                                              MediaQuery.of(context).size.width,
                                              40),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                12), // <-- Radius
                                          ),
                                        ),
                                        child: const Text(
                                            'Send verification code',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: Dimensions.screenWidth,
                              margin: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                                bottom: 15,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      width: Dimensions.screenWidth * 0.25,
                                      height: 0.5,
                                      child: const DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Color(0xFF616768),
                                          //color:Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        width: Dimensions.screenWidth * 0.25,
                                        child: const Text(
                                          'or sign in with',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xFF616768),
                                              fontSize: 12),
                                        )),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      width: Dimensions.screenWidth * 0.25,
                                      height: 0.5,
                                      child: const DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Color(0xFF616768),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Wrap(
                              children: List<Widget>.generate(
                                length,
                                (index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        child: Material(
                                          color: Theme.of(context).cardColor,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(50),
                                                bottomLeft: Radius.circular(50),
                                                topLeft: Radius.circular(50),
                                                topRight: Radius.circular(50)),
                                          ),
                                          elevation: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              child: Image(
                                                image: AssetImage(
                                                  "assets/images/" +
                                                      images[index],
                                                ),
                                                height: 20,
                                                width: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // child: GestureDetector(
                                    //   onTap: (){
                                    //
                                    //   },
                                    //   child: Container(
                                    //     margin: EdgeInsets.all(5),
                                    //     child: CircleAvatar(
                                    //       backgroundColor: Colors.white,
                                    //       radius: 25,
                                    //       backgroundImage: AssetImage(
                                    //           "assets/images/"+images[index],
                                    //
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: Dimensions.screenWidth,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF8F8F8),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            const Center(
                                child: Text(
                              'Don’t have an account?',
                              style: TextStyle(color: Colors.blueGrey),
                            )),
                            Container(
                              padding: const EdgeInsets.only(bottom: 20, top: 20, left: 20, right: 20),
                              width: Dimensions.screenWidth,
                              child: TextButton(
                                style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          const EdgeInsets.all(15)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: const BorderSide(
                                      color: Color(0xFF00B8CA),
                                    ),
                                  )),
                                ),
                                onPressed: () {
                                  Get.toNamed(RouteHelper.getSignUpScreen());
                                },
                                child: const Text('Sign Up',
                                    style: TextStyle(
                                        height: 1.4,
                                        color: Colors.cyan,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
