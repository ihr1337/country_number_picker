import 'package:flutter/services.dart';

bool validatePhoneNumber(String input) {
  final phoneExp = RegExp(r'^\+\d\d\d\d\d\d\d\d\d\d\d\d$');
  return phoneExp.hasMatch(input);
}

class PhoneNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    if (text.length > 3 && text.length < 7) {
      text = '(${text.substring(0, 3)}) ${text.substring(3)}';
    } else if (text.length >= 7) {
      text =
          '(${text.substring(0, 3)}) ${text.substring(3, 6)}-${text.substring(6)}';
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
