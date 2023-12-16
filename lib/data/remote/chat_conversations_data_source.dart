

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/chat_conversations_model.dart';
import 'http_headers_global.dart';

abstract class ChatConversationsDataSource {
  Future<List<ChatConversationsModel>> getChatConversations();

}

class ChatConversationsDataSourceImplementation extends ChatConversationsDataSource {
  final _storage = const FlutterSecureStorage();
  final _endPoint = dotenv.env['API_ENDPOINT'];
  @override
  Future<List<ChatConversationsModel>> getChatConversations() async {
    final userToken = await _storage.read(key: 'USER_TOKEN');
    final req = await HttpHeadersGlobal.headerGetHttpWithToken(
        userToken, '$_endPoint/api/v1/chat_conversations');

    if (req.statusCode == 200) {
      final newsResponse = jsonDecode(req.body);
      final List<dynamic> listNews = newsResponse['data'];

      if (listNews.isNotEmpty) {
        final List<ChatConversationsModel> listNewsModel =
        listNews.map((e) => ChatConversationsModel.fromJson(e)).toList();
        return listNewsModel;
      } else {
        return [];
      }
    } else {
      throw Exception('Error al obtener los datos');
    }
  }
}