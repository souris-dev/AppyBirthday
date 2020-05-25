import 'package:flutter/material.dart';

enum FieldEmpty { NAME, ACCESSTOKEN, NONE, BOTH }
enum SignInStatus { INVALID_ACCESS_TOKEN, DONE, NONE }

class SignInServices {
  static FieldEmpty checkInputEmpty(TextEditingController nameCont, TextEditingController accessTokenCont, bool both) {
    // both == true ? checks for both fields, else checks only accessTokenCont
    if (nameCont.text == "" || accessTokenCont.text == "") {
      return FieldEmpty.BOTH;
    } else if (nameCont.text == "") {
      return FieldEmpty.NAME;
    } else if (accessTokenCont.text == "") {
      return FieldEmpty.ACCESSTOKEN;
    } else {
      return FieldEmpty.NONE;
    }
  }

  static bool validateAccessToken() {
    return true;
  }

  static SignInStatus doGoogleSignIn() {
    if (!validateAccessToken()) {
      return SignInStatus.INVALID_ACCESS_TOKEN;
    }
    return SignInStatus.DONE;
  }
}
