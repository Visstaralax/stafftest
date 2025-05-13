import 'package:connectivity_plus/connectivity_plus.dart';

class CheckInternet{
  static Future<bool> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult == ConnectivityResult.none;
  }
}