import 'package:tunitalk/features/contact/domain/entities/contact_entity.dart';

abstract class ContactsRepository {
  Future <List<ContactEntity>> fetchContacts();
  Future <void> addContact({required String email});
}