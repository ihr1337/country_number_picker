import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final phoneNumberController = TextEditingController();

    final codeNode = FocusNode();
    final phoneNode = FocusNode();

    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xff8EAAFB)),
        home: Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        child: Row(
                          children: const [
                            Text(
                              'Get Started',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 400,
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 80,
                              child: TextField(
                                  focusNode: codeNode,
                                  onTap: () {},
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      filled: true,
                                      hintStyle: const TextStyle(
                                          color: Color(0xff7886B8)),
                                      hintText: "code",
                                      fillColor: const Color(0xffF4F5FF)
                                          .withOpacity(0.4))),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                                child: TextFormField(
                              validator: (value) => validatePhoneNumber(value!)
                                  ? null
                                  : 'Insert your number',
                              focusNode: phoneNode,
                              maxLength: 14,
                              inputFormatters: [
                                PhoneNumberTextInputFormatter()
                              ],
                              controller: phoneNumberController,
                              decoration: InputDecoration(
                                  counterText: '',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  filled: true,
                                  hintStyle:
                                      const TextStyle(color: Color(0xff7886B8)),
                                  hintText: "(067) 123-1234",
                                  fillColor:
                                      const Color(0xffF4F5FF).withOpacity(0.4)),
                            ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        width: double.maxFinite,
                        child: Row(
                          children: const [],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              backgroundColor: const Color(0xffFFFFFF),
              child: const Icon(
                Icons.arrow_forward,
                color: Color(0xff594C74),
              )),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ));
  }
}

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
