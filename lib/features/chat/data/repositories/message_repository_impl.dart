import 'package:tunitalk/features/chat/data/datasources/message_remote_data_source.dart';
import 'package:tunitalk/features/chat/domain/entities/message_entity.dart';
import 'package:tunitalk/features/chat/domain/repository/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository{

  final MessageRemoteDataSource remoteDataSource;

  MessageRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MessageEntity>> fetchMessages(String conversationId) async{
    return await remoteDataSource.fetchMessages(conversationId);
  }

  @override
  Future<void> sendMessage(MessageEntity message) {
    throw UnimplementedError();
  }
}