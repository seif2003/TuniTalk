import 'dart:convert';

import 'package:tunitalk/features/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {

  MessageModel ({
    required String id,
    required String conversationId,
    required String senderId,
    required String content,
    required String createdAt,
}): super(
      id: id,
      content: content,
      conversationId: conversationId,
      senderId: senderId ,
      createdAt: createdAt
    );

  factory MessageModel.fromJson (Map<String,dynamic> json){
    return MessageModel(
    id: json['id'],
    conversationId: json['conversation_id'],
    senderId: json['sender_id'],
    content: json['content'],
    createdAt: json['created_at']
    );
  }
}