import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wherenxnew1/ApiImplement/ViewDialog.dart';
import '../ApiCallingPage/OTPVerifaction.dart';
import '../ApiCallingPage/SigninPage.dart';
import '../Controller/OtpController.dart';
import '../modelclass/ShowLoginData.dart';
import '../modelclass/logindata.dart';
import '../Dimension.dart';
import '../Routes/RouteHelper.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final OtpController controller = Get.put(OtpController());

  String entredOtp = "", otp = "", email = "";
  int userId = 0;
  int otpId = 0;
  List<UserInfo> showLoginData = [];

  void showData() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    userId = pre.getInt("userId") ?? 0;
    otpId = pre.getInt("otpId") ?? 0;
    otp = pre.getString("otp") ?? "";
    email = pre.getString("email") ?? "";

    //SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {});
  }

  // Future<http.Response> otpVerifationApi(int user_id,int otp_id, String otp) {
  //   return http.post(
  //     Uri.parse(ApiUrl.login_otp_verification),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, dynamic>{'user_id': user_id, 'otp_id': otp_id, 'otp': otp}),
  //   );
  // }

  Future<ShowLoginData> otpVerifaction() async {
    http.Response? response = await otpVerifationApi(userId, otpId, entredOtp);
    var jsonResponse = json.decode(response!.body);
    var objRoot = ShowLoginData.fromJson(jsonResponse);
    print(response.body);
    showLoginData.add(objRoot.userInfo!);
    print(response.body);

    return objRoot;
  }

  Future<ShowData> _userLogin() async {
    http.Response? response = await loginApi(email);
    var jsonResponse = json.decode(response!.body);
    var objRoot = ShowData.fromJson(jsonResponse);
    print(response.body);
    // datalist.add(objRoot);

    return objRoot;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.startTimer();
    showData();
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr1 = ProgressDialog(context);
    pr1 = ProgressDialog(context, type: ProgressDialogType.normal);
    pr1.style(
        message: 'Verify OTP Wait...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: const CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w600));

    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(context, type: ProgressDialogType.normal);
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
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w600));

    print("___build___");
    print(controller.count);
    return Scaffold(
      // backgroundColor: Colors.white,
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
                              fontSize: 23,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    //color: _toggle == true ? Colors.white : Colors.white,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: Dimensions.screenWidth,
                        margin: const EdgeInsets.only(top: 20, bottom: 10),
                        child: const Text('Enter verification code',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF212828),
                                fontSize: 15)),
                      ),
                      Container(
                        width: Dimensions.screenWidth,
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: const Text(
                          'Enter the verification code sent to the \nregistered Phone number/Email address',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 14,
                            height: 1.2,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        height: 80,
                        child: OTPTextField(
                          length: 5,
                          fieldWidth: 45,
                          style: const TextStyle(fontSize: 15),
                          fieldStyle: FieldStyle.box,
                          onChanged: (pin) {
                            entredOtp = pin;
                            print("Completed: $pin");
                          },
                          onCompleted: (pin) {
                            entredOtp = pin;
                            print("Completed: $pin");
                          },
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: Dimensions.screenWidth,
                            margin: const EdgeInsets.only(top: 10, bottom: 0),
                            child: const Text(
                              'Problem receiving code?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 15,
                                height: 0.8,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Obx(
                                () => controller.count != 0
                                    ? Text(
                                        'Resend code in ${controller.count}s',
                                        style: const TextStyle(
                                            color: Colors.teal,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      )
                                    : TextButton(
                                        child: const Text("Resend code",
                                            style: TextStyle(
                                                color: Colors.teal,
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal)),
                                        onPressed: () async {
                                          // pr.show();

                                          if (controller.count != 0) {
                                            controller.startTimer();
                                            Text(
                                              'Resend code in ${controller.count}s',
                                              style: const TextStyle(
                                                  color: Colors.teal,
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            );
                                          }

                                          ShowData showData =
                                              await _userLogin();

                                          if (showData.status == "success") {
                                            pr.hide();

                                            // Get.toNamed(RouteHelper.getotpScreenpage());
                                            SharedPreferences pre = await SharedPreferences.getInstance();
                                            pre.setInt("userId", showData.userId!); //save integer
                                            pre.setInt("otpId", showData.otpId!); //save integer
                                            pre.setInt("otp", showData.otp!); //save String
                                            pre.setString("email", email); //save String

                                          } else {

                                            pr.hide();

                                            Fluttertoast.showToast(
                                                msg: "Already exists",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }

                                          setState(() {});
                                        },
                                      ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: 46,
                        margin: const EdgeInsets.only(
                            top: 15, right: 32, left: 32, bottom: 35),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFF1FCBDC), Color(0xFF00B8CA)],
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {

                            ViewDialog(context: context).showLoadingIndicator("Verify OTP Wait...","OTP Screen", context);

                            // int otpvali = int.parse(entredOtp);

                            ShowLoginData showLoadingData =
                                await otpVerifaction();

                            if (showLoadingData.status == "success") {
                             // pr1.hide();

                              ViewDialog(context: context).hideOpenDialog();

                              Get.toNamed(RouteHelper.getdelightsScreenpage());

                              SharedPreferences pre =
                                  await SharedPreferences.getInstance();
                              pre.setString(
                                  "name",
                                  showLoadingData
                                      .userInfo!.name!); //save integer
                              pre.setString(
                                  "email",
                                  showLoadingData
                                      .userInfo!.email!); //save integer
                              pre.setString(
                                  "country",
                                  showLoadingData
                                      .userInfo!.country!); //save String
                              pre.setString(
                                  "state",
                                  showLoadingData
                                      .userInfo!.state!); //save String
                              pre.setString(
                                  "city",
                                  showLoadingData
                                      .userInfo!.city!); //save String
                              pre.setInt(
                                  "userId",
                                  showLoadingData
                                      .userInfo!.userId!); //save String
                              pre.setBool("success", true); //save Boolean
                              pre.setBool("islogin", true); //save String //save Boolean

                            } else {
                             // pr1.hide();

                              ViewDialog(context: context).hideOpenDialog();

                              Fluttertoast.showToast(
                                  msg: showLoadingData.message!,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            minimumSize:
                                Size(MediaQuery.of(context).size.width, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                          child: const Text('Sign up',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
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

