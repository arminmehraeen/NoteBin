import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionService {
  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) ;
  }
}
