import 'package:tunitalk/features/contact/domain/entities/contact_entity.dart';

abstract class ContactRepository {
  Future <List<ContactEntity>> fetchContacts();
  Future <void> addContact({required String email});
}