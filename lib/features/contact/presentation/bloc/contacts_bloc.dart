import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunitalk/features/contact/domain/usecases/add_contact_usecase.dart';
import 'package:tunitalk/features/contact/domain/usecases/fetch_contacts_usecase.dart';
import 'package:tunitalk/features/contact/presentation/bloc/contacts_event.dart';
import 'package:tunitalk/features/contact/presentation/bloc/contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
 final FetchContactUseCase fetchContactUseCase;
 final AddContactUseCase addContactUseCase;

 ContactsBloc({required this.fetchContactUseCase, required this.addContactUseCase}):
 super(ContactsInitial()){
   on<FetchContacts> (_onFetchContacts);
   on<AddContacts> (_onAddContacts);
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


 Future<void> _onAddContacts (AddContacts event ,Emitter<ContactsState> emit )async {
   emit(ContactsLoading());
   try{
     await addContactUseCase(email: event.email);
     emit(ContactAdded());
     add(FetchContacts());
   }catch (error){
     emit(ContactsError('Failed to fetch contacts'));
   }
 }


}