import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';

enum FieldEmpty { NAME, ACCESSTOKEN, NONE, BOTH }
enum SignInStatus { INVALID_ACCESS_TOKEN, VALID_ACCESS_TOKEN, DONE, NONE, ERROR, CANCELED }

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

  static SignInStatus validateAccessToken(String accessToken) {
    // TODO: Code for accessToken validation
    return SignInStatus.VALID_ACCESS_TOKEN;
  }

  static Future<SignInStatus> doGoogleSignIn(String accessToken) async {
    if (validateAccessToken(accessToken) != SignInStatus.VALID_ACCESS_TOKEN) {
      return SignInStatus.INVALID_ACCESS_TOKEN;
    }

    try {
      currentGoogleAccount = await _googleSignIn.signIn();
    } on PlatformException catch (e) {
      if (e.code == 'sign_in_canceled') {
        print('GOOGLE SIGN-IN CANCELED');
        return SignInStatus.CANCELED;
      }
    } catch (err) {
      print(err.error);
    }

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
