import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tunitalk/features/conversation/data/models/conversation_model.dart';
import 'package:http/http.dart' as http;

class ConversationsRemoteDataSource {
  final String baseUrl = 'https://tunitalk.seifd.me';
  final _storage = FlutterSecureStorage();

  Future<List<ConversationModel>> fetchConversations() async {
    String token = await _storage.read(key: 'token') ?? '';

    final response = await http.get(
      Uri.parse('$baseUrl/conversations'),
      headers: {
        'Authorization': 'Bearer $token',
      }
    );

    if(response.statusCode == 200){
      List data = jsonDecode(response.body);
      return data.map((json) => ConversationModel.fromJson(json)).toList();
    } else {
      throw Exception('Faild to fetch conversation');
    }

  }

  Future<String> checkOrCreateConversation({required String contactId}) async {
    String token = await _storage.read(key: 'token') ?? '';

    final response = await http.post(
        Uri.parse('$baseUrl/conversations/check-or-create'),
        body: jsonEncode({
          'contactId':contactId
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }
    );
    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return data['conversationId'];
    } else {
      throw Exception('Faild to fetch conversation');
    }

  }

}