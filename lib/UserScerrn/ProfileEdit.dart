
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wherenxnew1/ApiCallingPage/GetCity.dart';
import 'package:wherenxnew1/ApiCallingPage/GetCountries.dart';
import 'package:wherenxnew1/ApiCallingPage/GetState.dart';
import 'package:wherenxnew1/ApiCallingPage/UpdateProfileImage.dart';
import 'package:wherenxnew1/ApiCallingPage/UpdateUserData.dart';
import 'package:wherenxnew1/ApiCallingPage/ViewUserProfileImage.dart';
import 'package:wherenxnew1/modelclass/CityResponse.dart';
import 'package:wherenxnew1/modelclass/CountriesResponse.dart';
import 'package:wherenxnew1/modelclass/ProfileImageResponse.dart';
import 'package:wherenxnew1/modelclass/StateResponse.dart';

import '../Dimension.dart';
import '../Routes/RouteHelper.dart';
import '../model/WherenxDeo.dart';
import '../model/WherenxEntity.dart';
import '../model/app_database.dart';

import 'package:http/http.dart' as http;

import '../modelclass/UpdateUserResponse.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileEdit extends StatefulWidget {
  WherenxDeo? _todoDao;
  List<WherenxModel> todolist = [];
  final database = $FloorAppDatabase.databaseBuilder('Todo.db').build();

  ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  // String F_name = "Chandan Kumar nath";
  // String Phone_no = "+91 7978986151";
  // String Email_id = "chandan.devpolosoft@gmail.com";
  // String Country = "United States of America";
  // String State = "California";

  late String F_name = "", city = "", State = "", Country = "", Phone_no = "",profileImage = "";
  late bool islogin = false;
  late int userId = 0;

  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
 // TextEditingController countryController = TextEditingController();
 // TextEditingController stateController = TextEditingController();
 // TextEditingController cityController = TextEditingController();

  void showData() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    F_name = pre.getString("name") ?? "";
    Phone_no = pre.getString("email") ?? "";
    Country = pre.getString("country") ?? "";
    State = pre.getString("state") ?? "";
    city = pre.getString("city") ?? "";
    islogin = pre.getBool("islogin") ?? false;
    userId = pre.getInt("userId") ?? 0;

    fullnameController.text = F_name;
    mobileNoController.text = Phone_no;

    if(Country != ""){
       dropdownCountry = Country;
    }
    if(State != ""){
       dropdownState = State;
    }
    if(city != ""){
       dropdownCity = city;
    }




    //SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {});
  }

  Future<String> showProfileImage() async {

    SharedPreferences pre = await SharedPreferences.getInstance();
    islogin = pre.getBool("islogin") ?? false;
    userId = pre.getInt("userId") ?? 0;

    String str_userId = userId.toString();

    print(userId);

    http.Response? response = await ViewUserProfileImage().getProfileImage(str_userId);
    var jsonResponse = jsonDecode(response.body);
    var userResponse1 = ProfileImageResponse.fromJson(jsonResponse);

    if(userResponse1.status == "success"){

      profileImage = userResponse1.image!;

      // Fluttertoast.showToast(
      //     msg: profileImage,
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.green,
      //     textColor: Colors.white,
      //     fontSize: 16.0);

      print(profileImage);

    }else{

      profileImage = "";
    }

    setState(() {});

    return profileImage;
  }

  String? dropdownCountry,dropdownState,dropdownCity,dropdownCountryId;

  void clearText() {
    fullnameController.clear();
    mobileNoController.clear();
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

    _userModelCity = await GetCityMethod().getCity(stateId);

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

  @override
  void initState() {
    super.initState();
    showData();
    _getData();
    showProfileImage();
  }

  @override
  Widget build(BuildContext context) {

    ImagePicker picker = ImagePicker();
    XFile? image;

    ProgressDialog pr9 = ProgressDialog(context);
    pr9 = ProgressDialog(context, type: ProgressDialogType.normal);
    pr9.style(
        message: 'Upload Image Wait.....',
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

    ProgressDialog pr6 = ProgressDialog(context);
    pr6 = ProgressDialog(context, type: ProgressDialogType.normal);
    pr6.style(
        message: 'Update User Details Wait...',
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

    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0,
      ),
      body: ResponsiveSizer(builder: (context, orientation, screenType){

        return Container(
          height: Dimensions.screenHeight,
          width: Dimensions.screenWidth,
          child: Stack(children: [
            Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      color: Color(0xFFF8F8F8),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          blurRadius: 15.0,
                          spreadRadius: 5,
                          offset: Offset(
                            0,
                            -5,
                          ),
                        )
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formGlobalKey,
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 100, left: 10, right: 10),
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: Column(
                            children: [
                              Container(
                                color: Colors.white,
                                child: TextFormField(
                                  cursorColor: const Color(0xFFA1A8A9),
                                  controller: fullnameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Field can not be empyty';
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      return;
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                  decoration: const InputDecoration(
                                    contentPadding:
                                    EdgeInsets.fromLTRB(5, 5, 5, 0),
                                    labelText: 'Full name',
                                    labelStyle: TextStyle(
                                      color: Color(0xFFDDE4E4),
                                    ),
                                    floatingLabelStyle:
                                    TextStyle(color: Color(0xFFA1A8A9)),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFDDE4E4), width: 1.0),
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
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                color: Colors.white,
                                child: TextFormField(
                                  cursorColor: const Color(0xFFA1A8A9),
                                  controller: mobileNoController,
                                  enabled: false,
                                  focusNode: FocusNode(canRequestFocus: false),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Field can not be empyty';
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      return;
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                  decoration: const InputDecoration(
                                    contentPadding:
                                    EdgeInsets.fromLTRB(5, 5, 5, 0),
                                    labelText: 'Phone number or Email address',
                                    labelStyle: TextStyle(
                                      color: Color(0xFFDDE4E4),
                                    ),
                                    floatingLabelStyle:
                                    TextStyle(color: Color(0xFFA1A8A9)),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFDDE4E4), width: 1.0),
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
                              SizedBox(
                                height: 1.h,
                              ),
                              DropdownButtonFormField(
                                hint: Text(dropdownCountry ?? "Choose an Country",style: TextStyle(fontSize: 15.sp),),
                                decoration:InputDecoration(

                                  //  labelText: 'Choose an Country',
                                  isDense: true, // important line
                                  contentPadding: EdgeInsets.fromLTRB(1.h, 3.5.h, 1.h, 0),
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
                                      color: Color(0xFFDDE4E4),
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
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                // validator: (value) => value == null
                                //     ? "Select a country"
                                //     : null,
                                dropdownColor: Colors.white,
                                value: dropdownCountry == "" ? "Country" : dropdownCountry,
                                isExpanded: true,
                                itemHeight: null,

                                // items: countriesRes.map((String item) {
                                //   return DropdownMenuItem<String>(
                                //     value: item,
                                //     child: Text(
                                //       item,
                                //       style: const TextStyle(
                                //         fontSize: 14,
                                //       ),
                                //     ),
                                //   );
                                // }
                                // ).toList(),

                                items: _userModel?.map<DropdownMenuItem<String>>((CountriesResponse country) {
                                  return DropdownMenuItem<String>(
                                    value:  country.name!,
                                    child: Text(
                                      country.name!,
                                      style: TextStyle(fontSize: 15.sp),
                                      overflow: TextOverflow.ellipsis,

                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {

                                    dropdownCountry = ((newValue ?? "") as String?)!;

                                    var dropdownCountryId = mapCountry[dropdownCountry];
                                    //var country = mapCountry.entries.firstWhere((entry) => entry.value
                                    //    == 'A020').key;

                                    // int dropdownCountryId = int.parse(dropdownCountry!);
                                    print(dropdownCountryId);
                                    dropdownState = null;
                                    _getData1(dropdownCountryId!);

                                    // Fluttertoast.showToast(
                                    //     msg: dropdownCountry!,
                                    //     toastLength: Toast.LENGTH_SHORT,
                                    //     gravity: ToastGravity.CENTER,
                                    //     timeInSecForIosWeb: 1,
                                    //     backgroundColor: Colors.red,
                                    //     textColor: Colors.white,
                                    //     fontSize: 16.0
                                    // );

                                  });
                                },

                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              DropdownButtonFormField(
                                hint: Text(dropdownState ?? "Choose an State",style: TextStyle(fontSize: 15.sp)),
                                decoration: InputDecoration(
                                  // labelText: 'Choose an State',
                                  isDense: true, // important line
                                  contentPadding: EdgeInsets.fromLTRB(1.h, 3.5.h, 1.h, 0),
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
                                      color: Color(0xFFDDE4E4),
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
                                  filled: true,
                                  fillColor: Colors.white,
                                ),

                                // validator: (value) => value == null
                                //     ? "Select a State"
                                //     : null,

                                dropdownColor: Colors.white,
                                value: dropdownState == "" ? "State" : dropdownState,
                                isExpanded: true,
                                itemHeight: null,
                                onChanged: (String? newValue) {
                                  setState(() {

                                    dropdownState = newValue;

                                    var dropdownStateId = mapState[dropdownState];
                                    //var country = mapCountry.entries.firstWhere((entry) => entry.value
                                    //    == 'A020').key;

                                    print(dropdownCountryId);
                                    dropdownCity = null;

                                    //int intdropdownCountry = int.parse(dropdownCountryId!);
                                    // _getData1(dropdownCountryId!);

                                    // int intdropdownState = int.parse(dropdownState!);
                                    _getData2(dropdownStateId!);

                                  });
                                },
                                // selectedItemBuilder: (BuildContext context) {
                                //   return countriesRes
                                //       .map((String value) {
                                //     return Text(
                                //       dropdownState,
                                //       style: const TextStyle(
                                //         fontSize: 13,
                                //         height: 2.0,
                                //         color: Color(0xFF000000),
                                //       ),
                                //     );
                                //   }).toList();
                                // },
                                items: _userModelState?.map<DropdownMenuItem<String>>((StateResponse state) {
                                  return DropdownMenuItem<String>(
                                    value: state.name!.toString(),
                                    child: Text(
                                      state.name!,
                                      style: TextStyle(fontSize: 15.sp),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }).toList(growable: true),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              DropdownButtonFormField(
                                hint: Text(dropdownCity ?? "Choose an City",style: TextStyle(fontSize: 15.sp)),
                                decoration: InputDecoration(
                                  // labelText: 'Choose an City',
                                  isDense: true, // important line
                                  contentPadding: EdgeInsets.fromLTRB(1.h, 3.5.h, 1.h, 0),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFDDE4E4),
                                        width: 1.0),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFDDE4E4),
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
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                // validator: (value) => value == null
                                //     ? "Select a city"
                                //     : null,
                                dropdownColor: Colors.white,
                                value: dropdownCity == "" ? "City" : dropdownCity,

                                // items: countriesRes.map((String item) {
                                //   return DropdownMenuItem<String>(
                                //     value: item,
                                //     child: Text(
                                //       item,
                                //       style: const TextStyle(
                                //         fontSize: 14,
                                //       ),
                                //     ),
                                //   );
                                // }
                                // ).toList(),

                                items: _userModelCity?.map<DropdownMenuItem<String>>((CityResponse city) {
                                  return DropdownMenuItem<String>(
                                    value: city.name!.toString(),
                                    child: Text(
                                      city.name!,
                                      style: TextStyle(fontSize: 15.sp),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {

                                    dropdownCity = ((newValue ?? "") as String?)!;

                                    Fluttertoast.showToast(
                                        msg: dropdownCity!,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );

                                  });
                                },

                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: const ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFF1FCBDC),
                                      Color(0xFF00B8CA)
                                    ],
                                  ),
                                ),
                                height: 46,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    //Get.toNamed(RouteHelper.getotpScreenpage());
                                    // Get.back();

                                    if (formGlobalKey.currentState!.validate()) {
                                      formGlobalKey.currentState?.save();
                                      // use the email provided here

                                      // AppDatabase appDatabase = await widget.database;
                                      // widget._todoDao = appDatabase.wherenxdeo;
                                      //
                                      // final employee = WherenxModel(
                                      //     userId,fullnameController.text.toString(),mobileNoController.text.toString(),
                                      //     countryController.text.toString(),stateController.text.toString());
                                      //
                                      // await widget._todoDao!.updateTodo(employee);
                                      //
                                      // widget.todolist = await widget._todoDao!.findUserById(mobileNoController.text.toString());
                                      //
                                      // SharedPreferences pre = await SharedPreferences.getInstance();
                                      // pre.setString("name", widget.todolist[0].name); //save string
                                      // pre.setString("mobileNo", widget.todolist[0].mobileno); //save integer
                                      // pre.setString("countary", widget.todolist[0].choose1); //save boolean
                                      // pre.setString("state", widget.todolist[0].choose2);
                                      // pre.setBool("islogin", true); //save boolean//save double
                                      // pre.setInt("userId", widget.todolist[0].id); //save boolean//save double
                                      //
                                      //
                                      // Fluttertoast.showToast(
                                      //
                                      //     msg: "Profile Update Success",
                                      //     toastLength: Toast.LENGTH_SHORT,
                                      //     gravity: ToastGravity.BOTTOM,
                                      //     timeInSecForIosWeb: 1,
                                      //     backgroundColor: Colors.green,
                                      //     textColor: Colors.white,
                                      //     fontSize: 16.0
                                      // );

                                      pr6.show();

                                      String str_userId = userId.toString();

                                      http.Response? response =
                                      await UpdateUserData().updateuserDet(
                                          str_userId,
                                          fullnameController.text.toString(),
                                          mobileNoController.text.toString(),
                                          dropdownCountry!,
                                          dropdownState!,
                                          dropdownCity!);

                                      var jsonResponse =
                                      json.decode(response!.body);

                                      var user_Upadte =
                                      UpdateUser.fromJson(jsonResponse);

                                      if (user_Upadte.status == "Success") {

                                        pr6.hide();

                                        Fluttertoast.showToast(
                                            msg: user_Upadte.message!,
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0);

                                        UserInfo? userInfo = user_Upadte.userInfo!;

                                        SharedPreferences pre = await SharedPreferences.getInstance();
                                        pre.setString("name", userInfo.name!); //save integer
                                        pre.setString("email", userInfo.email!); //save integer
                                        pre.setString("country", userInfo.country!); //save String
                                        pre.setString("state", userInfo.state!); //save String
                                        pre.setString("city", userInfo.city!); //save String
                                        pre.setBool("data", true); //save String

                                        Get.toNamed(RouteHelper.getprofileScreenpage());

                                      }else{

                                        pr6.hide();

                                        Fluttertoast.showToast(
                                            msg: user_Upadte.message!,
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.transparent,
                                    backgroundColor: Colors.transparent,
                                    minimumSize: Size(
                                        MediaQuery.of(context).size.width, 40),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(12), // <-- Radius
                                    ),
                                  ),
                                  child: const Text('Save Changes',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.screenWidth * 0.32, top: Dimensions.size1),
                  child: Card(
                      elevation: 5,
                      shadowColor: const Color.fromRGBO(0, 0, 0, 0.4),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(100),
                              bottomLeft: Radius.circular(100),
                              topLeft: Radius.circular(100),
                              topRight: Radius.circular(100)),
                          side: BorderSide(width: 6, color: Colors.white)),
                      child: Stack(children: [
                        Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              image:profileImage == "" ? const DecorationImage(
                                image: AssetImage('assets/images/profileimage.jpg'),//Your Background image
                              ) : DecorationImage(
                                image: NetworkImage(profileImage),
                                fit:BoxFit.cover,

                                //Your Background image
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ))
                      ])),
                ),

                // ),
                GestureDetector(
                  onTap: () async {

                    image = await picker.pickImage(source: ImageSource.gallery);
                    File imageFile = File(image!.path);
                    print(imageFile);

                    pr9.show();

                    SharedPreferences pre = await SharedPreferences.getInstance();
                    islogin = pre.getBool("islogin") ?? false;
                    userId = pre.getInt("userId") ?? 0;

                    String str_userId = userId.toString();

                    http.StreamedResponse? response = await UpdateProfileImage().updateImageProfile(str_userId, image!.path);

                    print(await response!.stream.bytesToString());

                    if(response.statusCode == 200){

                    pr9.hide();
                    showProfileImage();

                    Fluttertoast.showToast(

                    msg: "Upload Success",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);


                    }else{

                    pr9.hide();

                    Fluttertoast.showToast(
                    msg: "Image Not Upload",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);

                    }

                    setState(() {});


                  },
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.size210, top: Dimensions.size95),
                      child: Material(
                        color: Theme.of(context).cardColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        elevation: 5,
                        shadowColor: const Color.fromRGBO(0, 0, 0, 0.4),
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.camera_alt_sharp, color: Colors.cyan,
                            size: 25,
                            // color: Theme.of(context).primarySwatch,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        );
      },
      )
    );
  }
}
