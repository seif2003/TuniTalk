import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunitalk/features/conversation/presentation/bloc/conversations_event.dart';
import 'package:tunitalk/features/conversation/presentation/bloc/conversations_state.dart';
import 'package:tunitalk/features/conversation/domain/usecases/fetch_conversations_use_case.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  final FetchConversationsUseCase fetchConversationsUseCase;

  ConversationsBloc({required this.fetchConversationsUseCase}) : super(ConversationsInitial()){
    on<FetchConversations>(_onFetchConversations);
  }

  Future<void> _onFetchConversations(FetchConversations event, Emitter<ConversationsState> emit) async {
    emit(ConversationsLoading());
    try{
      final conversations = await fetchConversationsUseCase();
      emit(ConversationsLoaded(conversations));
    } catch (error) {
      emit(ConversationsError('Failed to load conversations'));
    }
  }



}