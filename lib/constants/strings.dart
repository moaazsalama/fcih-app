import 'dart:io';

import 'package:flutter/cupertino.dart';

const homepage = "/home-page";
const feedbackScreen = '/feedback-screen';
const onBoardingScreen = '/on-screen';
const primaryColor = Color.fromRGBO(14, 118, 188, 1);
PlatForm platformGetter() {
  try {
    if (Platform.isAndroid) {
      return PlatForm.android;
    } else {
      return PlatForm.windows;
    }
  } catch (e) {
    return PlatForm.web;
  }
}

enum PlatForm {
  android,
  windows,
  web
}
