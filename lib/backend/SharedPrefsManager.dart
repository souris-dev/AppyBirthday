import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/SignInPageAvatarButton.dart';
import 'SignInServices.dart';

class SharedPrefsManager {
  static SharedPreferences _sharedPreferences;

  static void loadSharedPrefs() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static void resetPrefs() async {
    _sharedPreferences.reload();
    _sharedPreferences.setString('gender', 'Male');
    _sharedPreferences.setString('name', 'Nanashi');
    _sharedPreferences.setBool('loggedIn', false);
    if (await SignInServices.isGoogleSignedIn) {
      SignInServices.doGoogleSignOut();
    }
  }

  static void setLoggedIn(bool val) async {
    _sharedPreferences.reload();
    _sharedPreferences.setBool('loggedIn', val);
  }

  static Future<Avatar> getGenderAvatar() async {
    _sharedPreferences.reload();
    Map<String, Avatar> avatarMap = {
      'Male': Avatar.MALE,
      'Female': Avatar.FEMALE,
      'Cat': Avatar.CAT,
    };
    return avatarMap[_sharedPreferences.getString('gender')];
  }

  static void setGender(Avatar avatar) async {
    _sharedPreferences.reload();
    Map<Avatar, String> genderMap = {
      Avatar.MALE: 'Male',
      Avatar.FEMALE: 'Female',
      Avatar.CAT: 'Cat',
    };
    _sharedPreferences.setString('gender', genderMap[avatar]);
  }

  static void setName(String name) async {
    _sharedPreferences.reload();
    _sharedPreferences.setString('name', name);
  }

  static Future<String> getName() async {
    _sharedPreferences.reload();
    return _sharedPreferences.getString('name');
  }
}
