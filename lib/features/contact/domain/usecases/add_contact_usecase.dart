import 'package:tunitalk/features/contact/domain/repositories/contacts_repository.dart';

class AddContactUseCase  {
  final ContactRepository contactRepository;

  AddContactUseCase({required this.contactRepository});

  Future<void> call({required String email}) async {
    return await contactRepository.addContact(email: email);
  }


}