import 'package:shared_preferences/shared_preferences.dart';

class LocalHelper {
  static SharedPreferences? prfes;
  static init() async {
    prfes = await SharedPreferences.getInstance();
  }
}
