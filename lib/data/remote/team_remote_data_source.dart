import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:soywarmi_app/data/model/member_model.dart';
import 'package:soywarmi_app/data/remote/http_headers_global.dart';

abstract class TeamRemoteDataSource {
  Future<List<MemberModel>> getTeams();
}

class TeamRemoteDataSourceImplementation extends TeamRemoteDataSource {
  final _storage = const FlutterSecureStorage();
  final _endPoint = dotenv.env['API_ENDPOINT'];

  @override
  Future<List<MemberModel>> getTeams() async {
    final userToken = await _storage.read(key: 'USER_TOKEN');
    final req = await HttpHeadersGlobal.headerGetHttpWithToken(
        userToken, '$_endPoint/api/v1/teams');

    if (req.statusCode == 200) {
      final teams = jsonDecode(req.body);
      final List<dynamic> listTeams = teams['data'];
      if (listTeams.isNotEmpty) {
        List<MemberModel> listTeamsModel =[];
        for(int i=0;i<listTeams.length;i++){
          for(int j=0;j<listTeams[i]["person"].length;j++){
            if (listTeams[i].containsKey("social_networks") && listTeams[i]["social_networks"]!=null) {
              listTeams[i]["person"][j]['twitter']=listTeams[i]["social_networks"]["twitter"]??"";
              listTeams[i]["person"][j]['facebook']=listTeams[i]["social_networks"]["facebook"]??"";
              listTeams[i]["person"][j]['instagram']=listTeams[i]["social_networks"]["instagram"]??"";
            }else{
              listTeams[i]["person"][j]['twitter']="";
              listTeams[i]["person"][j]['facebook']="";
              listTeams[i]["person"][j]['instagram']="";
            }
            listTeamsModel.add(MemberModel.fromJson(listTeams[i]["person"][j]));
          }
        }
        return listTeamsModel;
      } else {
        return [];
      }
    } else {
      throw Exception('Error al obtener los datos');
    }
  }
}
