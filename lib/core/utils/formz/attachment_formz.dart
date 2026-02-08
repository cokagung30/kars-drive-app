import 'package:formz/formz.dart';

enum AttachmentValidationError { required }

class AttachmentFormz extends FormzInput<String, AttachmentValidationError> {
  const AttachmentFormz.dirty({String value = ''}) : super.dirty(value);

  const AttachmentFormz.pure({String value = ''}) : super.pure(value);

  @override
  AttachmentValidationError? validator(String value) {
    if (value.isEmpty) return AttachmentValidationError.required;

    return null;
  }
}

extension AttachmentFormzX on AttachmentFormz {
  String? get errorMessage {
    if (displayError == AttachmentValidationError.required) {
      return 'Gambar tidak boleh kosong!';
    }

    return null;
  }
}
