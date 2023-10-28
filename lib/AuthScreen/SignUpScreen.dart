import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wherenxnew1/ApiCallingPage/GetState.dart';
import 'package:wherenxnew1/ApiImplement/ViewDialog.dart';
import 'package:wherenxnew1/modelclass/StateResponse.dart';
import 'package:wherenxnew1/modelclass/UserRegister.dart';
import '../ApiCallingPage/RegisterResponse.dart';
import '../GoogleSigninPack/Authentication_GoogleSignIn.dart';
import '../modelclass/CityResponse.dart';
import '../ApiCallingPage/GetCountries.dart';
import '../modelclass/CountriesResponse.dart';
import '../Dimension.dart';
import '../Routes/RouteHelper.dart';
import '../model/WherenxDeo.dart';
import '../model/WherenxEntity.dart';
import '../model/app_database.dart';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:responsive_sizer/responsive_sizer.dart';


class SignUpScreen extends StatefulWidget {

  WherenxDeo? _todoDao;
  List<WherenxModel> todolist = [];
  final database = $FloorAppDatabase.databaseBuilder('Todo.db').build();

  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final formGlobalKey = GlobalKey < FormState > ();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileoremailController = TextEditingController();

  //String dropdownCountry;
 // String dropdownState = "";

  String? dropdownCountry,dropdownState,dropdownCity,dropdownCountryId;

  void clearText() {
    fullNameController.clear();
    mobileoremailController.clear();
    dropdownCountry = 'Country*';
    dropdownState = 'State*';
    dropdownCity = 'City*';
  }

  List<CountriesResponse>? _userModel = [];
  List<String> countriesRes = [];
  List<int> countriesId = [];

  List<StateResponse>? _userModelState = [];
  List<String> stateRes = [];
  List<int> stateId = [];

  List<CityResponse>? _userModelCity = [];
  List<String> coityRes = [];

  late Map<String, int> mapCountry;
  late Map<String, int> mapState;

  bool _isSigningIn = false;

  void _getData() async {
    _userModel = (await CountriesRes().getCountries())!;

    print(_userModel.toString());

    for(int i= 0;i < _userModel!.length;i++){
      countriesRes.add(_userModel![i].name!);
      countriesId.add(_userModel![i].id!);
    }

    mapCountry = Map.fromIterables(countriesRes, countriesId);
    print(countriesRes.toString());
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  void _getData1(int countryId) async {

    _userModelState?.clear();
    stateRes.clear();
    stateId.clear();

    _userModelState = (await GetState().getState(countryId));

    if(_userModelState!.isNotEmpty){

      print(_userModelState.toString());

      for(int i= 0;i < _userModelState!.length;i++){

        stateRes.add(_userModelState![i].name!);
        stateId.add(_userModelState![i].id!);

      }

      print("statementing${ stateRes.length}");
      print("statementing1${  stateId.length}");

      mapState = Map.fromIterables(stateRes, stateId);

    }else{

      Fluttertoast.showToast(
          msg: "State List Not Found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

    print(mapState.toString());
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  void _getData2(int stateId) async {

    _userModelCity!.clear();
    coityRes.clear();

   //  _userModelCity = await GetCityMethod().getCity(stateId);

    if(_userModelCity!.isNotEmpty){

      print(_userModelCity.toString());
      for(int i= 0;i < _userModelCity!.length;i++){
        coityRes.add(_userModelCity![i].name!);
      }
    }else{

      Fluttertoast.showToast(
          msg: "City List Not Found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

    print(coityRes.toString());
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));

  }

  var countries = CountriesResponse();

  // void _getData() async {
  //   http.Response? response = await CountriesRes().getCountries();
  //   var jsonResponse = json.decode(response!.body);
  //   countries = CountriesResponse.fromJson(jsonResponse);
  //   countriesRes.add(countries.name!);
  //   Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  // }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "USA", child: Text("USA")),
      const DropdownMenuItem(value: "Canada11", child: Text("Canada")),
      const DropdownMenuItem(value: "Brazil11", child: Text("Brazil")),
      const DropdownMenuItem(value: "England11", child: Text("England")),
    ];
    return menuItems;
  }

  @override
  void dispose() {
    fullNameController.dispose();
    super.dispose();
  }

  List images = [
    "google.png",
    "facebook.png",
    "instagram.png",
  ];
  int length = 3;
  late int id = 0,val = 10;
  Random random = Random();
  Random random2 = Random.secure();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: ResponsiveSizer(builder: (context, orientation, screenType) {
        return  SingleChildScrollView(
          //scrollDirection: Axis.vertical,
          child: Container(
            height: 100.h,
            width: 100.h,
            child: Padding(padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(15.sp),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            height: 5.h,
                            width: 5.w,
                            child: Image.asset(
                              'assets/images/logo_w.png',
                            ),
                          ),
                          Text(
                            " WhereNX",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 5.sp,),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                      ),
                      //curve: Curves.easeInOutBack,
                      width: 100.w,
                      child: Form(
                        key: formGlobalKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  // margin: EdgeInsets.only(top: 20, bottom: 20),
                                    padding: EdgeInsets.all(15.sp),
                                    child: Center(
                                      child: Text('Sign in',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                              fontSize: 18.sp)),
                                    )),
                                //sign up
                                Container(
                                  margin:
                                  EdgeInsets.only(left: 20.sp, right: 20.sp),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        cursorColor: const Color(0xFFA1A8A9),
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        controller: fullNameController,
                                        // validator:  (value){
                                        //   if (value == null || value.isEmpty) {
                                        //     return "Enter Your Name";
                                        //   }
                                        //   return null;
                                        // },
                                        onChanged: (value) {
                                          // if (value.isEmpty) {
                                          //   return;
                                          // }
                                          // return null;
                                        },

                                        style: TextStyle(
                                          fontSize: 15.sp,
                                        ),
                                        decoration: InputDecoration(
                                          errorStyle: TextStyle(height: 0),
                                          isDense: true, // important line
                                          contentPadding: EdgeInsets.fromLTRB(1.h, 4.h, 4.h, 0),
                                          // filled: true,// control your hints text size
                                          labelText: 'Full Name',
                                          labelStyle: const TextStyle(
                                            color: Color(0xFFDDE4E4),
                                          ),
                                          floatingLabelStyle:TextStyle(color: Color(0xFFA1A8A9)),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xFFDDE4E4),
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12.sp),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFA1A8A9),
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12.sp),
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12.sp),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      TextFormField(
                                        cursorColor: const Color(0xFFA1A8A9),
                                        controller: mobileoremailController,
                                        // validator: (value){
                                        //   if (value == null || value.isEmpty) {
                                        //     return "Enter Mobile No" ;
                                        //   }
                                        //   return null;
                                        // },

                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        onChanged: (value) {
                                          // if (value.isEmpty) {
                                          //   return;
                                          // }
                                          // return null;
                                        },
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                        ),
                                        decoration: InputDecoration(
                                          errorStyle: TextStyle(height: 0),
                                          isDense: true, // important line
                                          contentPadding: EdgeInsets.fromLTRB(1.h, 4.h, 4.h, 0),
                                          labelText:
                                          'Email address',
                                          labelStyle: const TextStyle(
                                            color: Color(0xFFDDE4E4),
                                          ),
                                          floatingLabelStyle:
                                          const TextStyle(color: Color(0xFFA1A8A9)),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xFFDDE4E4),
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12.sp),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFA1A8A9),
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12.sp),
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12.sp),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      // DropdownButtonFormField(
                                      //   hint: Text("Choose an Country",style: TextStyle(fontSize: 15.sp),),
                                      //   decoration:InputDecoration(
                                      //
                                      //     //  labelText: 'Choose an Country',
                                      //     isDense: true, // important line
                                      //     contentPadding: EdgeInsets.fromLTRB(1.h, 3.5.h, 1.h, 0),
                                      //     enabledBorder: OutlineInputBorder(
                                      //       borderSide: BorderSide(
                                      //           color: Color(0xFFDDE4E4),
                                      //           width: 1.0),
                                      //       borderRadius: BorderRadius.all(
                                      //         Radius.circular(12),
                                      //       ),
                                      //     ),
                                      //     focusedBorder: OutlineInputBorder(
                                      //       borderSide: BorderSide(
                                      //         color: Color(0xFFDDE4E4),
                                      //       ),
                                      //       borderRadius: BorderRadius.all(
                                      //         Radius.circular(12),
                                      //       ),
                                      //     ),
                                      //     border: OutlineInputBorder(
                                      //       borderRadius: BorderRadius.all(
                                      //         Radius.circular(12),
                                      //       ),
                                      //     ),
                                      //     filled: true,
                                      //     fillColor: Colors.white,
                                      //   ),
                                      //   // validator: (value) => value == null
                                      //   //     ? "Select a country"
                                      //   //     : null,
                                      //   dropdownColor: Colors.white,
                                      //   value: dropdownCountry, isExpanded: true,
                                      //   itemHeight: null,
                                      //
                                      //   // items: countriesRes.map((String item) {
                                      //   //   return DropdownMenuItem<String>(
                                      //   //     value: item,
                                      //   //     child: Text(
                                      //   //       item,
                                      //   //       style: const TextStyle(
                                      //   //         fontSize: 14,
                                      //   //       ),
                                      //   //     ),
                                      //   //   );
                                      //   // }
                                      //   // ).toList(),
                                      //
                                      //   items: _userModel?.map<DropdownMenuItem<String>>((CountriesResponse country) {
                                      //     return DropdownMenuItem<String>(
                                      //       value:  country.name!,
                                      //       child: Text(
                                      //         country.name!,
                                      //         style: TextStyle(fontSize: 15.sp),
                                      //         overflow: TextOverflow.ellipsis,
                                      //
                                      //       ),
                                      //     );
                                      //   }).toList(),
                                      //   onChanged: (newValue) {
                                      //     setState(() {
                                      //
                                      //       dropdownCountry = ((newValue ?? "") as String?)!;
                                      //
                                      //       var dropdownCountryId = mapCountry[dropdownCountry];
                                      //       //var country = mapCountry.entries.firstWhere((entry) => entry.value
                                      //       //    == 'A020').key;
                                      //
                                      //       // int dropdownCountryId = int.parse(dropdownCountry!);
                                      //       print(dropdownCountryId);
                                      //       dropdownState = null;
                                      //       _getData1(dropdownCountryId!);
                                      //
                                      //
                                      //
                                      //       // Fluttertoast.showToast(
                                      //       //     msg: dropdownCountry!,
                                      //       //     toastLength: Toast.LENGTH_SHORT,
                                      //       //     gravity: ToastGravity.CENTER,
                                      //       //     timeInSecForIosWeb: 1,
                                      //       //     backgroundColor: Colors.red,
                                      //       //     textColor: Colors.white,
                                      //       //     fontSize: 16.0
                                      //       // );
                                      //
                                      //     });
                                      //   },
                                      //
                                      // ),
                                      // SizedBox(
                                      //   height: 0.5.h,
                                      // ),
                                      // DropdownButtonFormField(
                                      //   hint: Text("Choose an State",style: TextStyle(fontSize: 15.sp)),
                                      //   decoration: InputDecoration(
                                      //     // labelText: 'Choose an State',
                                      //     isDense: true, // important line
                                      //     contentPadding: EdgeInsets.fromLTRB(1.h, 3.5.h, 1.h, 0),
                                      //     enabledBorder: OutlineInputBorder(
                                      //       borderSide: BorderSide(
                                      //           color: Color(0xFFDDE4E4),
                                      //           width: 1.0),
                                      //       borderRadius: BorderRadius.all(
                                      //         Radius.circular(12),
                                      //       ),
                                      //     ),
                                      //     focusedBorder: OutlineInputBorder(
                                      //       borderSide: BorderSide(
                                      //         color: Color(0xFFDDE4E4),
                                      //       ),
                                      //       borderRadius: BorderRadius.all(
                                      //         Radius.circular(12),
                                      //       ),
                                      //     ),
                                      //     border: OutlineInputBorder(
                                      //       borderRadius: BorderRadius.all(
                                      //         Radius.circular(12),
                                      //       ),
                                      //     ),
                                      //     filled: true,
                                      //     fillColor: Colors.white,
                                      //   ),
                                      //
                                      //   // validator: (value) => value == null
                                      //   //     ? "Select a State"
                                      //   //     : null,
                                      //
                                      //   dropdownColor: Colors.white,
                                      //   value: dropdownState,
                                      //   isExpanded: true,
                                      //   itemHeight: null,
                                      //   onChanged: (String? newValue) {
                                      //     setState(() {
                                      //
                                      //       dropdownState = newValue;
                                      //
                                      //       var dropdownStateId = mapState[dropdownState];
                                      //       //var country = mapCountry.entries.firstWhere((entry) => entry.value
                                      //       //    == 'A020').key;
                                      //
                                      //       print(dropdownCountryId);
                                      //       dropdownCity = null;
                                      //
                                      //       //int intdropdownCountry = int.parse(dropdownCountryId!);
                                      //       // _getData1(dropdownCountryId!);
                                      //
                                      //       // int intdropdownState = int.parse(dropdownState!);
                                      //       _getData2(dropdownStateId!);
                                      //
                                      //     });
                                      //   },
                                      //   // selectedItemBuilder: (BuildContext context) {
                                      //   //   return countriesRes
                                      //   //       .map((String value) {
                                      //   //     return Text(
                                      //   //       dropdownState,
                                      //   //       style: const TextStyle(
                                      //   //         fontSize: 13,
                                      //   //         height: 2.0,
                                      //   //         color: Color(0xFF000000),
                                      //   //       ),
                                      //   //     );
                                      //   //   }).toList();
                                      //   // },
                                      //   items: _userModelState?.map<DropdownMenuItem<String>>((StateResponse state) {
                                      //     return DropdownMenuItem<String>(
                                      //       value: state.name!.toString(),
                                      //       child: Text(
                                      //         state.name!,
                                      //         style: TextStyle(fontSize: 15.sp),
                                      //         overflow: TextOverflow.ellipsis,
                                      //       ),
                                      //     );
                                      //   }).toList(growable: true),
                                      // ),
                                      // SizedBox(
                                      //   height: 0.5.h,
                                      // ),
                                      // DropdownButtonFormField(
                                      //   hint: Text("Choose an City",style: TextStyle(fontSize: 15.sp)),
                                      //   decoration: InputDecoration(
                                      //     // labelText: 'Choose an City',
                                      //     isDense: true, // important line
                                      //     contentPadding: EdgeInsets.fromLTRB(1.h, 3.5.h, 1.h, 0),
                                      //     enabledBorder: const OutlineInputBorder(
                                      //       borderSide: BorderSide(
                                      //           color: Color(0xFFDDE4E4),
                                      //           width: 1.0),
                                      //       borderRadius: BorderRadius.all(
                                      //         Radius.circular(12),
                                      //       ),
                                      //     ),
                                      //     focusedBorder: OutlineInputBorder(
                                      //       borderSide: BorderSide(
                                      //         color: Color(0xFFDDE4E4),
                                      //       ),
                                      //       borderRadius: BorderRadius.all(
                                      //         Radius.circular(12),
                                      //       ),
                                      //     ),
                                      //     border: OutlineInputBorder(
                                      //       borderRadius: BorderRadius.all(
                                      //         Radius.circular(12),
                                      //       ),
                                      //     ),
                                      //     filled: true,
                                      //     fillColor: Colors.white,
                                      //   ),
                                      //   // validator: (value) => value == null
                                      //   //     ? "Select a city"
                                      //   //     : null,
                                      //   dropdownColor: Colors.white,
                                      //   value: dropdownCity,
                                      //
                                      //   // items: countriesRes.map((String item) {
                                      //   //   return DropdownMenuItem<String>(
                                      //   //     value: item,
                                      //   //     child: Text(
                                      //   //       item,
                                      //   //       style: const TextStyle(
                                      //   //         fontSize: 14,
                                      //   //       ),
                                      //   //     ),
                                      //   //   );
                                      //   // }
                                      //   // ).toList(),
                                      //
                                      //   items: _userModelCity?.map<DropdownMenuItem<String>>((CityResponse city) {
                                      //     return DropdownMenuItem<String>(
                                      //       value: city.name!.toString(),
                                      //       child: Text(
                                      //         city.name!,
                                      //         style: TextStyle(fontSize: 15.sp),
                                      //       ),
                                      //     );
                                      //   }).toList(),
                                      //   onChanged: (newValue) {
                                      //     setState(() {
                                      //
                                      //       dropdownCity = ((newValue ?? "") as String?)!;
                                      //
                                      //       Fluttertoast.showToast(
                                      //           msg: dropdownCity!,
                                      //           toastLength: Toast.LENGTH_SHORT,
                                      //           gravity: ToastGravity.CENTER,
                                      //           timeInSecForIosWeb: 1,
                                      //           backgroundColor: Colors.red,
                                      //           textColor: Colors.white,
                                      //           fontSize: 16.0
                                      //       );
                                      //
                                      //     });
                                      //   },
                                      //
                                      // ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Container (
                                        decoration: const ShapeDecoration(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))
                                          ),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [Color(0xFF1FCBDC), Color(0xFF00B8CA)],
                                          ),
                                        ),
                                        height: Dimensions.size46,
                                        child: ElevatedButton(

                                          onPressed: () async {
                                            //Get.toNamed(RouteHelper.getotpScreenpage());
                                            // if (formGlobalKey.currentState!.validate()) {
                                            //   formGlobalKey.currentState?.save();
                                            // use the email provided here

                                            //    AppDatabase appDatabase = await widget.database;
                                            //      widget._todoDao = appDatabase.wherenxdeo;

                                            var min = 1;
                                            var max = 50;
                                            id = min + random.nextInt(max - min);

                                            if(fullNameController.text.toString().isEmpty){

                                              Left_indicator_bar_Flushbar(context,"Enter User Name");

                                            }else if(mobileoremailController.text.toString().isEmpty){

                                              Left_indicator_bar_Flushbar(context,"Enter User Mobile No");

                                            }

                                            // else if(dropdownCountry == null){
                                            //
                                            //   Left_indicator_bar_Flushbar(context,"Select Your Country");
                                            //
                                            // }
                                            // else if(dropdownState == null){
                                            //
                                            //   Register(fullNameController.text.toString(),
                                            //   mobileoremailController.text.toString(),dropdownCountry!,"","");
                                            //
                                            // //  Left_indicator_bar_Flushbar(context,"Select Your State");
                                            //
                                            // }
                                            // else if(dropdownCity == null){
                                            //
                                            //   Register(fullNameController.text.toString(),
                                            //       mobileoremailController.text.toString(),dropdownCountry!,dropdownState!,"");
                                            //
                                            //  // Left_indicator_bar_Flushbar(context,"Select Your City");
                                            //
                                            // }

                                            else{

                                              ViewDialog(context: context).showLoadingIndicator("User Login Wait..","Sign Up Page", context);

                                              Register(fullNameController.text.toString(),
                                                  mobileoremailController.text.toString(),"","","");

                                              print("${fullNameController.text} ${mobileoremailController.text}");

                                              // final employee = WherenxModel(
                                              //     id,fullNameController.text.toString(),mobileoremailController.text.toString(),
                                              //     dropdownCountry!,dropdownState!);
                                              //
                                              // await widget._todoDao!.insertTodo(employee);
                                              //
                                              // Fluttertoast.showToast(
                                              //
                                              //     msg: "Register Success",
                                              //     toastLength: Toast.LENGTH_SHORT,
                                              //     gravity: ToastGravity.BOTTOM,
                                              //     timeInSecForIosWeb: 1,
                                              //     backgroundColor: Colors.green,
                                              //     textColor: Colors.white,
                                              //     fontSize: 16.0
                                              // );

                                            }

                                            // }else{
                                            //
                                            //   Fluttertoast.showToast(
                                            //
                                            //       msg: "Register Not Success",
                                            //       toastLength: Toast.LENGTH_SHORT,
                                            //       gravity: ToastGravity.BOTTOM,
                                            //       timeInSecForIosWeb: 1,
                                            //       backgroundColor: Colors.red,
                                            //       textColor: Colors.white,
                                            //       fontSize: 16.0
                                            //   );
                                            // }
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
                                          child: const Text('Sign up',
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 15)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: Dimensions.screenWidth,
                                  margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          width: Dimensions.screenWidth * 0.25,
                                          height: 0.5,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).dividerColor,
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
                                            child: Text(
                                              'or sign in with',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 12.sp),
                                            )),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          width: Dimensions.screenWidth * 0.25,
                                          height: 0.5,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).dividerColor,
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
                                          onTap: () async {


                                            if(index == 0){

                                              setState(() {
                                                _isSigningIn = true;
                                              });

                                              User? user = await Authentication_GoogleSignIn.signInWithGoogle(context: context);

                                              setState(() {
                                                _isSigningIn = false;
                                              });

                                              if (user != null) {
                                                //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => UserInfoScreen(user: user,),),);

                                                Fluttertoast.showToast(
                                                    msg: user.email!,
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.green,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );

                                                ViewDialog(context: context).showLoadingIndicator("User Login Wait..","Sign Up Page", context);

                                                Register(user.displayName!,user.email!,"","","");

                                              }

                                                //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => GoogleSignInButton(),),);
                                            }

                                          },
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
                                                    image: AssetImage( "assets/images/" + images[index],),
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
                                // Container(
                                //     width: Dimensions.screenWidth,
                                //     margin: const EdgeInsets.only(left: 30, right: 30, bottom: 20,),
                                //     child: RichText(
                                //       textAlign: TextAlign.center,
                                //       text: TextSpan(
                                //         style: TextStyle(
                                //           fontFamily: 'Poppins',
                                //         ),
                                //         children: <TextSpan>[
                                //           TextSpan(
                                //             text: 'By signing up, you agree to our',
                                //             style: TextStyle(
                                //                 color: Colors.blueGrey,
                                //                 fontSize: 14.sp),
                                //           ),
                                //           TextSpan(
                                //             text: ' Terms of Service',
                                //             style: TextStyle(
                                //                 color: Colors.cyan, fontSize: 14.sp),
                                //           ),
                                //           TextSpan(
                                //             text: '\nand ',
                                //             style: TextStyle(
                                //                 color: Colors.blueGrey,
                                //                 fontSize: 14.sp),
                                //           ),
                                //           TextSpan(
                                //             text: 'Privacy Policy.',
                                //             style: TextStyle(
                                //                 color: Colors.cyan, fontSize: 14.sp),
                                //           ),
                                //         ],
                                //       ),
                                //     )),
                              ],
                            ),
                            // Container(
                            //   width: 100.w,
                            //   decoration: const BoxDecoration(
                            //     color: Color(0xFFF8F8F8),
                            //     borderRadius: BorderRadius.only(
                            //         bottomRight: Radius.circular(20),
                            //         bottomLeft: Radius.circular(20)),
                            //   ),
                            //   child: Column(
                            //     children: [
                            //       const SizedBox(
                            //         height: 10,
                            //       ),
                            //       const Center(
                            //           child: Text(
                            //             'Don’t have an account?',
                            //             style: TextStyle(color: Colors.blueGrey),
                            //           )),
                            //       Container(
                            //         padding: const EdgeInsets.only(bottom: 20, top: 20, left: 20, right: 20),
                            //         width: 100.w,
                            //         child: TextButton(
                            //           style: ButtonStyle(
                            //             padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(2.h)),
                            //             backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            //                 RoundedRectangleBorder(
                            //                   borderRadius: BorderRadius.circular(12.0),
                            //                   side: const BorderSide(color: Color(0xFF00B8CA),),
                            //                 )
                            //             ),
                            //           ),
                            //           onPressed: () {
                            //             Get.toNamed(RouteHelper.getSignInScreen());
                            //           },
                            //           child: const Text('Sign in',
                            //               style: TextStyle(
                            //                   height: 1.4,
                            //                   color: Colors.cyan,
                            //                   fontWeight: FontWeight.normal,
                            //                   fontSize: 15)),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      )
                  )

                ],
              ),),
          )
        );
      }),
    );
  }

  void Left_indicator_bar_Flushbar(BuildContext context,String Message){

    Flushbar(
      message: Message,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.blue[300],
      ),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: Colors.red[300],
    )..show(context);
  }

  Future<void> Register(String fullName, String EmailId, String dropdownCountry, String dropdownState, String dropdownCity) async {

    http.Response? response = await userRegister_det(fullName,
        EmailId,dropdownCountry,dropdownState,dropdownCity);
    var jsonResponse = json.decode(response!.body);
    var userRegister = UserRegister.fromJson(jsonResponse);
    print(response.body);

    if(userRegister.status == "failed"){

      ViewDialog(context: context).hideOpenDialog();

      Fluttertoast.showToast(

          msg: "User Not Register",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );

      Get.toNamed(RouteHelper.getdelightsScreenpage());

    }else{

      Fluttertoast.showToast(

          msg: userRegister.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );

        ViewDialog(context: context).hideOpenDialog();

        SharedPreferences pre =
        await SharedPreferences.getInstance();
        pre.setString(
            "name",
            userRegister
                .data!.name!); //save integer
        pre.setString(
            "email",
            userRegister
                .data!.email!); //save integer
        pre.setString(
            "country",
            userRegister
                .data!.country!); //save String
        pre.setString(
            "state",
            userRegister
                .data!.state!); //save String
        pre.setString(
            "city",
            userRegister
                .data!.city!); //save String
        pre.setInt("userId", userRegister.data!.id!); //save String
        pre.setInt("radius", userRegister.data!.radius!); //save String
        pre.setBool("success", true); //save Boolean
        pre.setBool("islogin", true);

      Get.toNamed(RouteHelper.getdelightsScreenpage());
      //save String //save Boolean

      clearText();

      //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInScreen()));
      // use the email provided here
    }
  }
}



/*mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length == 6;

  bool isEmailValid(String email) {
    Pattern pattern = r '^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(email);
  }
}*/
