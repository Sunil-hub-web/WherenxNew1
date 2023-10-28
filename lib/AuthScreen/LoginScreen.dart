import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Dimension.dart';
import '../Routes/RouteHelper.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final mobileNo = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String mobile_No = '';
  bool _toggle = true;
  bool sign_in = true;
  bool sign_up = false;
  bool D_sign_up = false;
  int length = 3;
  List images = [
    "google.png",
    "facebook.png",
    "twitter.png",
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (this.mounted) {
        setState(() {
          D_sign_up = sign_up;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Container(
        height: Dimensions.screenHeight,
        width: Dimensions.screenWidth,
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
            margin: const EdgeInsets.all(20),
            child: SafeArea(
              child: Center(
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
                              width: 34,
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
                    AnimatedContainer(
                      decoration: const BoxDecoration(
                        //color: _toggle == true ? Colors.white : Colors.white,
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      //curve: Curves.easeInOutBack,
                      duration: const Duration(seconds: 1),
                      height: _toggle == true ? 450 : 612,
                      width: Dimensions.screenWidth,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // Container(
                                //     // margin: EdgeInsets.only(top: 20, bottom: 20),
                                //     padding: const EdgeInsets.all(20),
                                //     child: Center(
                                //         child: _toggle == true
                                //             ? const Text('Sign in',
                                //                 style: TextStyle(
                                //                     fontWeight: FontWeight.bold,
                                //                     color: Colors.black87,
                                //                     fontSize: 18))
                                //             : const Text('Sign up',
                                //                 style: TextStyle(
                                //                     fontWeight: FontWeight.bold,
                                //                     color: Colors.black87,
                                //                     fontSize: 18)))),

                                //sign in
                                Visibility(
                                  visible: sign_in,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 40,
                                          child: TextFormField(
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                            decoration: const InputDecoration(
                                              labelText: 'Email or Phone no',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12))),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.toNamed(
                                                RouteHelper.getotpScreenpage());
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.cyan,
                                            // set the background color
                                            minimumSize: Size(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                40),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      12), // <-- Radius
                                            ),
                                          ),
                                          child: const Text(
                                              'Send verification code',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                //sign up
                                Visibility(
                                  visible: D_sign_up,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 40,
                                          child: TextFormField(
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                            decoration: const InputDecoration(
                                              labelText: 'Full name',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12))),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 40,
                                          child: TextFormField(
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                            decoration: const InputDecoration(
                                              labelText:
                                                  'Phone number or Email address',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12))),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 40,
                                          child: TextFormField(
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                            decoration: const InputDecoration(
                                              labelText: 'Country',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12))),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 40,
                                          child: TextFormField(
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                            decoration: const InputDecoration(
                                              labelText: 'State',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12))),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.toNamed(
                                                RouteHelper.getotpScreenpage());
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.cyan,
                                            minimumSize: Size(
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                40),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      12), // <-- Radius
                                            ),
                                          ),
                                          child: const Text('Next',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15)),
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
                                      left: 20, right: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          width: Dimensions.screenWidth * 0.25,
                                          height: 0.5,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .dividerColor,
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
                                          child: _toggle == true
                                              ? const Text(
                                                  'or sign in with',
                                                  style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 12),
                                                )
                                              : const Text('or sign up with',
                                                  style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 12)),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          width: Dimensions.screenWidth * 0.25,
                                          height: 0.5,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .dividerColor,
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
                                              color:
                                                  Theme.of(context).cardColor,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(50),
                                                    bottomLeft:
                                                        Radius.circular(50),
                                                    topLeft:
                                                        Radius.circular(50),
                                                    topRight:
                                                        Radius.circular(50)),
                                              ),
                                              elevation: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
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

                                Container(
                                    width: Dimensions.screenWidth,
                                    margin: const EdgeInsets.only(
                                        left: 30, right: 30),
                                    child: _toggle == true
                                        ? const Text("")
                                        : RichText(
                                            textAlign: TextAlign.center,
                                            text: const TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      'By signing up, you agree to our',
                                                  style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 12),
                                                ),
                                                TextSpan(
                                                  text: ' Terms of Service',
                                                  style: TextStyle(
                                                      color: Colors.cyan,
                                                      fontSize: 12),
                                                ),
                                                TextSpan(
                                                  text: ' and ',
                                                  style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 12),
                                                ),
                                                TextSpan(
                                                  text: 'Privacy Policy.',
                                                  style: TextStyle(
                                                      color: Colors.cyan,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          )),
                              ],
                            ),
                          ),
                          Container(
                            width: Dimensions.screenWidth,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: _toggle == true
                                      ? const Text(
                                          'Don’t have an account?',
                                          style:
                                              TextStyle(color: Colors.blueGrey),
                                        )
                                      : const Text('Already have an account?',
                                          style: TextStyle(
                                              color: Colors.blueGrey)),
                                ),
                                Visibility(
                                  visible: true,
                                  child: TextButton(
                                    onPressed: () {
                                      sign_up = true;
                                      sign_in = false;
                                      setState(() {
                                        _toggle = !_toggle;

                                        if (_toggle) {
                                          sign_up = false;
                                          sign_in = true;
                                          D_sign_up = false;
                                        }
                                      });
                                    },
                                    child: _toggle == true
                                        ? const Text(
                                            'Sign up',
                                            style: TextStyle(
                                                color: Colors.cyan,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 15),
                                          )
                                        : const Text('Sign in',
                                            style: TextStyle(
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
        ),
      ),
    );
  }
}
