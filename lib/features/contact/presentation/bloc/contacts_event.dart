abstract class ContactsEvent {}

class FetchContacts extends ContactsEvent {}

class AddContacts extends ContactsEvent {
  final String email;

  AddContacts(this.email);
}