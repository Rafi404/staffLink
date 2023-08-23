import '../app_constants/app_constants.dart';

/// Field validation function
String? fieldValidator(value) {
  if (value == null || value.trim().isEmpty) {
    return fieldRequiredMessage;
  }
  return null;
}
