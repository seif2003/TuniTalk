import 'package:tunitalk/features/contact/domain/entities/contact_entity.dart';
import 'package:tunitalk/features/contact/domain/repositories/contacts_repository.dart';

class FetchContactUseCase {
  final ContactRepository contactRepository;

  FetchContactUseCase({required this.contactRepository});

  Future<List<ContactEntity>> call() async {
    return await contactRepository.fetchContacts();
  }


}