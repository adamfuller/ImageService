import 'package:image_service/app/app.dart';
import 'package:image_service/business_logic/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:docustore_dart/docustore_dart.dart' as ds;

void main() async {
  ds.init(
    server: "www.octalbyte.com",
    port: 8081,
    timeout: Duration(seconds: 15),
  );

  Future.delayed(Duration(milliseconds: 50), () {
    PreferencesSvc.init();
  });
  runApp(MainView());
}
