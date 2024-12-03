import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunitalk/features/contact/domain/usecases/add_contact_usecase.dart';
import 'package:tunitalk/features/contact/domain/usecases/fetch_contacts_usecase.dart';
import 'package:tunitalk/features/contact/presentation/bloc/contacts_event.dart';
import 'package:tunitalk/features/contact/presentation/bloc/contacts_state.dart';
import 'package:tunitalk/features/conversation/domain/usecases/check_or_create_conversation_use_case.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
 final FetchContactUseCase fetchContactUseCase;
 final AddContactUseCase addContactUseCase;
 final CheckOrCreateConversationUseCase checkOrCreateConversationUseCase;

 ContactsBloc({
   required this.fetchContactUseCase,
   required this.addContactUseCase,
   required this.checkOrCreateConversationUseCase
 }):
 super(ContactsInitial()){
   on<FetchContacts> (_onFetchContacts);
   on<AddContact> (_onAddContacts);
   on<CheckOrCreateConversation> (_onCheckOrCreateConversation);
 }

 Future<void> _onFetchContacts (FetchContacts event ,Emitter<ContactsState> emit )async {
   emit(ContactsLoading());
   try{
     final contacts = await fetchContactUseCase();
     emit(ContactsLoaded(contacts));
   }catch (error){
     emit(ContactsError('Failed to fetch contacts'));
   }
 }

 Future<void> _onAddContacts (AddContact event ,Emitter<ContactsState> emit )async {
   emit(ContactsLoading());
   try{
     await addContactUseCase(email: event.email);
     emit(ContactAdded());
     add(FetchContacts());
   }catch (error){
     emit(ContactsError('Failed to fetch contacts'));
   }
 }

 Future<void> _onCheckOrCreateConversation (CheckOrCreateConversation event ,Emitter<ContactsState> emit )async {
   try{
     emit(ContactsLoading());
     final conversationId = await checkOrCreateConversationUseCase(contactId: event.contactId);
     emit(ConversationReady(conversationId: conversationId, contactName: event.contactName));
   }catch (error){
     emit(ContactsError('Failed to start conversation'));
   }
 }

}