

import 'package:tunitalk/features/contact/data/datasources/contacts_remote_data_source.dart';
import 'package:tunitalk/features/contact/domain/entities/contact_entity.dart';
import 'package:tunitalk/features/contact/domain/repositories/contacts_repository.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  final ContactsRemoteDataSource remoteDataSource ;

  ContactsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> addContact({required String email}) async{
    return await remoteDataSource.addContact(email: email);
  }

  @override
  Future<List<ContactEntity>> fetchContacts() async{
    return await remoteDataSource.fetchContacts();
  }
  
}