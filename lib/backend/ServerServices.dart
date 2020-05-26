import 'package:http/http.dart' as http;

enum ServerPoint { ACCESSTOKEN, MSGSEND }

class ServerServices {
  static Map<ServerPoint, String> serverPoints = {
    ServerPoint.ACCESSTOKEN: "http://appy-birthday.herokuapp.com/acstkn",
    ServerPoint.MSGSEND: "http://appy-birthday.herokuapp.com/msgsend",
  };

  static void doSend(String text, String name) async {
    var response = await http.post(serverPoints[ServerPoint.MSGSEND], body: {'name': name, 'message': text});
  }
}
