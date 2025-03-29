import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soywarmi_app/data/model/publication_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:math';
import 'package:faker/faker.dart';

import 'http_headers_global.dart';

abstract class PublicationRemoteDataSource {
  Future<List<PublicationModel>> getPublications();
  Future<List<PublicationModel>> getRecentPublications();
  Future<PublicationModel> getPublication(int id);
  Future<void> createPublication(PublicationModel publication);
  Future<void> updatePublication(PublicationModel publication);
  Future<void> deletePublication(int id);
}

class PublicationRemoteDaraSourceImplementation
    extends PublicationRemoteDataSource {
  final _storage = const FlutterSecureStorage();
  final _endPoint = dotenv.env['API_ENDPOINT'];

  @override
  Future<void> createPublication(PublicationModel publication) {
    // TODO: implement createPublication
    throw UnimplementedError();
  }

  @override
  Future<void> deletePublication(int id) {
    // TODO: implement deletePublication
    throw UnimplementedError();
  }

  @override
  Future<PublicationModel> getPublication(int id) async {
    final userToken = await _storage.read(key: 'USER_TOKEN');
    final req = await HttpHeadersGlobal.headerGetHttpWithToken(
        userToken, '$_endPoint/api/v1/publications/$id');

    if (req.statusCode == 200) {
      final publicationsResponse = jsonDecode(req.body);
      final publication = publicationsResponse['data'];
      return PublicationModel.fromJson(publication);
    } else {
      throw Exception('Error al obtener los datos');
    }
  }
  @override
  Future<List<PublicationModel>> getRecentPublications() async {
    final userToken = await _storage.read(key: 'USER_TOKEN');
    final req = await HttpHeadersGlobal.headerGetHttpWithToken(
        userToken, '$_endPoint/api/v1/recent_publications');

    if (req.statusCode == 200) {
      final publicationsResponse = jsonDecode(req.body);
      final List<dynamic> listPublications = publicationsResponse['data'];

      if (listPublications.isNotEmpty) {
        final List<PublicationModel> listPublicationsModel =
        listPublications.map((e) => PublicationModel.fromJson(e)).toList();
        return listPublicationsModel;
      } else {
        return [];
      }
    } else {
      throw Exception('Error al obtener los datos');
    }
  }
  @override
  Future<List<PublicationModel>> getPublications() async {
    final userToken = await _storage.read(key: 'USER_TOKEN');
    final req = await HttpHeadersGlobal.headerGetHttpWithToken(
        userToken, '$_endPoint/api/v1/publications');

    if (req.statusCode == 200) {
      final publicationsResponse = jsonDecode(req.body);
      final List<dynamic> listPublications = publicationsResponse['data'];

      if (listPublications.isNotEmpty) {
        final List<PublicationModel> listPublicationsModel =
        listPublications.map((e) => PublicationModel.fromJson(e)).toList();
        return listPublicationsModel;
      } else {
        return [];
      }
    } else {
      throw Exception('Error al obtener los datos');
    }
  }

  @override
  Future<void> updatePublication(PublicationModel publication) {
    // TODO: implement updatePublication
    throw UnimplementedError();
  }
}
