import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tunitalk/core/socket_service.dart';
import 'package:tunitalk/features/chat/domain/entities/message_entity.dart';
import 'package:tunitalk/features/chat/domain/usecases/fetch_messages_use_case.dart';
import 'package:tunitalk/features/chat/presentation/bloc/chat_event.dart';
import 'package:tunitalk/features/chat/presentation/bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FetchMessageUseCase fetchMessageUseCase;
  final SocketService socketService = SocketService();
  final List<MessageEntity> _messages = [];
  final _storage = FlutterSecureStorage();

  ChatBloc({required this.fetchMessageUseCase}) : super(ChatLoadingState()) {
    on<LoadMessagesEvent>(_onLoadMessages);
    on<SendMessageEvent>(_onSendMessages);
    on<ReceiverMessageEvent>(_onReceiverMessages);
  }

  Future<void> _onLoadMessages(LoadMessagesEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoadingState());
    try {
      // Ensure socket is initialized
      if (!socketService.isConnected) {
        await socketService.initSocket();
      }

      final messages = await fetchMessageUseCase(event.conversationId);
      _messages.clear();
      _messages.addAll(messages);
      emit(ChatLoadedState(List.from(_messages)));

      // Remove previous listeners to prevent duplicates
      socketService.socket.off('newMessage');
      socketService.socket.on('newMessage', (data) {
        print("step1 -receive : $data");
        add(ReceiverMessageEvent(data));
      });

      socketService.socket.emit('joinConversation', event.conversationId);
    } catch (error) {
      print('Error in _onLoadMessages: $error');
      emit(ChatErrorState('$error Failed to load messages'));
    }
  }

  Future<void> _onSendMessages(SendMessageEvent event, Emitter<ChatState> emit) async {
    try {
      String userId = await _storage.read(key: 'userId') ?? '';
      print('userId : $userId');

      final newMessage = {
        'conversationId': event.conversationId,
        'content': event.content,
        'senderId': userId,
      };

      // Ensure socket is connected before sending
      if (!socketService.isConnected) {
        await socketService.initSocket();
      }

      socketService.socket.emit('sendMessage', newMessage);
    } catch (error) {
      print('Error sending message: $error');
    }
  }

  Future<void> _onReceiverMessages(ReceiverMessageEvent event, Emitter<ChatState> emit) async {
    try {
      print("step2 -receive event called");
      print(event.message);

      final message = MessageEntity(
          id: event.message['id'],
          conversationId: event.message['conversation_id'],
          senderId: event.message['sender_id'],
          content: event.message['content'],
          createdAt: event.message['created_at']
      );

      _messages.add(message);
      emit(ChatLoadedState(List.from(_messages)));
    } catch (error) {
      print('Error in _onReceiverMessages: $error');
    }
  }
}