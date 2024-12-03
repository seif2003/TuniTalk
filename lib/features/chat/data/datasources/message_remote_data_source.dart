import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tunitalk/features/chat/data/models/message_model.dart';
import 'package:tunitalk/features/chat/domain/entities/message_entity.dart';
import 'package:http/http.dart' as http;
class MessageRemoteDataSource {
  final String baseUrl = 'https://tunitalk.seifd.me';
  final _storage = FlutterSecureStorage();

  Future<List<MessageEntity>> fetchMessages (String conversationId) async {
    String token =  await _storage.read(key: 'token') ?? '';
    final response = await http.get(
      Uri.parse('$baseUrl/messages/$conversationId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        }
    );
    if (response.statusCode == 200){
      List data= jsonDecode(response.body);
      return data.map((json)=> MessageModel.fromJson(json)).toList();
    }
    else{
      throw Exception('failed to fetch messges');
    }
  }
}