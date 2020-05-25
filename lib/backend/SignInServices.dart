import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum FieldEmpty { NAME, ACCESSTOKEN, NONE, BOTH }
enum SignInStatus { INVALID_ACCESS_TOKEN, DONE, NONE, ERROR }

class SignInServices {
  static GoogleSignInAccount currentGoogleAccount;
  static GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile']);

  static FieldEmpty checkInputEmpty(TextEditingController nameCont, TextEditingController accessTokenCont, bool both) {
    // both == true ? checks for both fields, else checks only accessTokenCont
    if (nameCont.text == "" && accessTokenCont.text == "") {
      return FieldEmpty.BOTH;
    } else if (nameCont.text == "") {
      return FieldEmpty.NAME;
    } else if (accessTokenCont.text == "") {
      return FieldEmpty.ACCESSTOKEN;
    } else {
      return FieldEmpty.NONE;
    }
  }

  // Returns a Future
  static get isGoogleSignedIn {
    return _googleSignIn.isSignedIn();
  }

  static bool validateAccessToken() {
    return true;
  }

  static Future<SignInStatus> doGoogleSignIn() async {
    if (!validateAccessToken()) {
      return SignInStatus.INVALID_ACCESS_TOKEN;
    }
    currentGoogleAccount = await _googleSignIn.signIn();
    if (currentGoogleAccount.displayName != '') {
      return SignInStatus.DONE;
    } else {
      return SignInStatus.ERROR;
    }
  }

  static void doGoogleSignOut() async {
    currentGoogleAccount = await _googleSignIn.signOut();
  }
}
