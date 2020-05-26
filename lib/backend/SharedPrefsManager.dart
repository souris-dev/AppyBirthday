import 'package:appy_birthday/backend/ServerServices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/SignInPageAvatarButton.dart';
import 'SignInServices.dart';

class SharedPrefsManager {
  static SharedPreferences _sharedPreferences;

  static void loadSharedPrefs() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static void initSharedPrefFields() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    if (_sharedPreferences.getKeys().length < 6) {
      // first start it seems
      _sharedPreferences.setString('gender', 'Male');
      _sharedPreferences.setString('name', 'Nanashi');
      _sharedPreferences.setBool('loggedIn', false);
      _sharedPreferences.setString('accessToken', '');
      _sharedPreferences.setInt('level', -1);
      _sharedPreferences.setBool('unlockedCat', false);
    }
  }

  static void resetPrefs() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString('gender', 'Male');
    _sharedPreferences.setString('name', 'Nanashi');
    _sharedPreferences.setBool('loggedIn', false);
    _sharedPreferences.setString('accessToken', '');
    _sharedPreferences.setInt('level', -1);
    if (await SignInServices.isGoogleSignedIn) {
      SignInServices.doGoogleSignOut();
    }
  }

  static Future<void> setLoggedIn(bool val) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setBool('loggedIn', val);
  }

  static Future<bool> isLoggedIn() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getBool('loggedIn');
  }

  static Future<Avatar> getGenderAvatar() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    Map<String, Avatar> avatarMap = {
      'Male': Avatar.MALE,
      'Female': Avatar.FEMALE,
      'Cat': Avatar.CAT,
    };
    return avatarMap[_sharedPreferences.getString('gender')];
  }

  static Future<void> setGender(Avatar avatar) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    Map<Avatar, String> genderMap = {
      Avatar.MALE: 'Male',
      Avatar.FEMALE: 'Female',
      Avatar.CAT: 'Cat',
    };
    _sharedPreferences.setString('gender', genderMap[avatar]);
  }

  static Future<void> setName(String name) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString('name', name);
  }

  static Future<String> getName() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getString('name');
  }

  static Future<void> setAccessToken(String aTok) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString('accessToken', aTok);
  }

  static Future<String> getAccessToken() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getString('accessToken');
  }

  static Future<void> setUnlockedCat(bool value) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setBool('unlockedCat', value);
  }

  static Future<bool> getUnlockedCat() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getBool('unlockedCat');
  }

  static Future<void> setAccessLevel(AccessCheck level) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    int lvl = -1;

    if (level == AccessCheck.HIGH) {
      lvl = 0;
    } else if (level == AccessCheck.LOW) {
      lvl = 1;
    } else {
      lvl = -1;
    }

    _sharedPreferences.setInt('level', lvl);
  }

  static Future<AccessCheck> getAccessLevel() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    int lvl = _sharedPreferences.getInt('level');

    if (lvl == 0) {
      return AccessCheck.HIGH;
    } else if (lvl == 1) {
      return AccessCheck.LOW;
    } else {
      return AccessCheck.INVALID_OR_ERROR;
    }
  }
}
