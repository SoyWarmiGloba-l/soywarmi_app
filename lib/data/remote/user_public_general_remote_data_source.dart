import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soywarmi_app/data/model/doctor_model.dart';
import 'package:soywarmi_app/data/remote/http_headers_global.dart';

import '../model/user_model.dart';

abstract class UserPublicGeneralRemoteDataSource {
  Future<dynamic> postUser(String body);
}

class UserPublicGeneralRemoteDataSourceImplementation extends UserPublicGeneralRemoteDataSource {
  final storage = const FlutterSecureStorage();
  final _endPoint = dotenv.env['API_ENDPOINT'];


  @override
  Future<dynamic> postUser(String body) async {
    final userToken = await storage.read(key: 'USER_TOKEN');

    final req = await HttpHeadersGlobal.headerPostHttpWithToken(userToken, '$_endPoint/api/auth/register',body);

    if (req.statusCode == 200) {
      final Map<String, dynamic> user = json.decode(req.body);

      final dynamic user_obtained = user['data'];


      if (user_obtained.isNotEmpty) {
        return user_obtained;
      } else {
        return null;
      }
    } else {
      throw Exception('Error al obtener los datos');
    }
  }

}


