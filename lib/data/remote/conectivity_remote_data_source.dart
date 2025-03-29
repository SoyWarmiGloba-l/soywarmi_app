import 'package:http/http.dart' as http;

abstract class ConnectivityRemoteDataSource {
  Future<bool> verifyConnectivity(String url);
}
class ConnectivityRemoteDataSourceImplementation implements ConnectivityRemoteDataSource{
  @override
  Future<bool> verifyConnectivity(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
  
}
