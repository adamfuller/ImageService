import 'package:image_service/app/app.dart';
import 'package:image_service/business_logic/business_logic.dart';
import 'package:flutter/material.dart';

void main() async {
  Future.delayed(Duration(milliseconds: 50), (){
    PreferencesSvc.init();
  });
  runApp(MainView());
}

