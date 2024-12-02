import 'package:tunitalk/features/chat/domain/entities/message_entity.dart';

abstract class MessageRepository {
  Future <List<MessageEntity>> fetchMessages (String conversationId);
  Future <void> sendMessage (MessageEntity message);
}