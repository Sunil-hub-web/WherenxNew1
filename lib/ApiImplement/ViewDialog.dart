
import 'package:flutter/material.dart';

class ViewDialog{

  BuildContext context;
  ViewDialog({required this.context});

  void showLoadingIndicator(String text,String heading,BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))
                ),
                backgroundColor: Colors.white,
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _getLoadingIndicator(),
                    _getHeading(context,heading),
                    _getText(text)
                  ],
                )
            )
        );
      },
    );
  }

  void hideOpenDialog() async {
    Navigator.of(context).pop();
  }
  Padding _getLoadingIndicator() {
    return Padding(
        child: Container(
            child: CircularProgressIndicator(
              strokeWidth: 4,
              color: Colors.blueAccent,
            ),
            width: 32,
            height: 32
        ),
        padding: EdgeInsets.only(bottom: 16)
    );
  }

  Widget _getHeading(context,heading) {
    return
      Padding(
          padding: EdgeInsets.only(bottom: 1),
          child: Text(
            heading,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 16
            ),
            textAlign: TextAlign.center,
          )
      );
  }

  Text _getText(String displayedText) {
    return Text(
      displayedText,
      style: TextStyle(
          color: Colors.black,
          fontSize: 14
      ),
      textAlign: TextAlign.center,
    );
  }
}