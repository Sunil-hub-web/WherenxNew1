import 'dart:async';

import 'package:get/get.dart';

class OtpController extends GetxController{
  RxInt count = 30.obs;
  late Timer _timer;

  bool isLoading = true;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
        if (count == 0) {

            timer.cancel();
            isLoading = false;

            count = 30.obs;

        } else {

          count--;
            // print("___________timer___________");
            // print(count);
            // print(_timer);

        }
      },
    );
  }


  // increment(){
  //   count.value--;
  // }


}