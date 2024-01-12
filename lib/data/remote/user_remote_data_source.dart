
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/user_model.dart';
import 'http_headers_global.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();
}

class UserRemoteDataSourceImplementation extends UserRemoteDataSource {
  final _storage = const FlutterSecureStorage();
  final _endPoint = dotenv.env['API_ENDPOINT'];

  @override
  Future<List<UserModel>> getUsers() async {
    final userToken = await _storage.read(key: 'USER_TOKEN');
    final req = await HttpHeadersGlobal.headerGetHttpWithToken(
        userToken, '$_endPoint/api/v1/get_users');

    if (req.statusCode == 200) {
      final Map<String, dynamic> users = json.decode(req.body);
      final List<dynamic> listUsers = users['data'];
      if (listUsers.isNotEmpty) {
        final List<UserModel> listTeamsModel =
        listUsers.map((e) => UserModel.fromJson(e)).toList();
        return listTeamsModel;
      } else {
        return [];
      }
    } else {
      throw Exception('Error al obtener los datos');
    }
  }
}
