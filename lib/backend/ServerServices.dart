import 'package:appy_birthday/backend/SharedPrefsManager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum ServerPoint { ACCESSTOKEN, MSGSEND }
enum AccessCheck { HIGH, LOW, INVALID_OR_ERROR }
enum Food { PIZZA, CF, DOSA }

class ServerServices {
  static Map<ServerPoint, String> serverPoints = {
    ServerPoint.ACCESSTOKEN: "http://appy-birthday.herokuapp.com/acstkn",
    ServerPoint.MSGSEND: "http://appy-birthday.herokuapp.com/messenger",
  };

  static Map<Food, String> serverPointsFood = {
    Food.PIZZA: "http://appy-birthday.herokuapp.com/getpizza.jpg",
    Food.CF: "http://appy-birthday.herokuapp.com/getcoffeetea.jpg",
    Food.DOSA: "http://appy-birthday.herokuapp.com/getdosa.jpg",
  };

  static Future<AccessCheck> checkAccessToken(String token) async {
    try {
      http.Response resp = await http.post(serverPoints[ServerPoint.ACCESSTOKEN], body: {'accesstoken': token});

      if (resp.statusCode == 200) {
        if (json.decode(resp.body)['authorized'] == 'true') {
          Fluttertoast.showToast(msg: 'You got in!', textColor: Colors.white, backgroundColor: Colors.blue[700]);
          if (json.decode(resp.body)['level'] == '0') {
            await SharedPrefsManager.setAccessLevel(AccessCheck.HIGH);
            return AccessCheck.HIGH;
          } else {
            await SharedPrefsManager.setAccessLevel(AccessCheck.LOW);
            return AccessCheck.LOW;
          }
        } else {
          Fluttertoast.showToast(msg: 'Invalid pass!', textColor: Colors.white, backgroundColor: Colors.pink[700]);
          await SharedPrefsManager.setAccessLevel(AccessCheck.LOW);
          return AccessCheck.INVALID_OR_ERROR;
        }
      } else {
        Fluttertoast.showToast(msg: 'Server error!', textColor: Colors.white, backgroundColor: Colors.blue[700]);
        await SharedPrefsManager.setAccessLevel(AccessCheck.INVALID_OR_ERROR);
        return AccessCheck.INVALID_OR_ERROR;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Couldn't authorize pass!", textColor: Colors.white, backgroundColor: Colors.blue[700]);
      await SharedPrefsManager.setAccessLevel(AccessCheck.INVALID_OR_ERROR);
      return AccessCheck.INVALID_OR_ERROR;
    }
  }

  static void doSend(String text, String name) async {
    try {
      http.Response response = await http.post(serverPoints[ServerPoint.MSGSEND], body: {'name': name, 'message': text});

      if (response.statusCode == 200 && response.body == 'OK') {
        Fluttertoast.showToast(msg: 'Your message was sent', textColor: Colors.white, backgroundColor: Colors.blue[700]);
      } else {
        Fluttertoast.showToast(
            msg: 'Your message could not be sent', textColor: Colors.white, backgroundColor: Colors.pink[700]);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Your message could not be sent', textColor: Colors.white, backgroundColor: Colors.pink[700]);
    }
  }
}
