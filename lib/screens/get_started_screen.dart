import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../countries_model.dart';
import '../util/phone_number_validator_and_formatter.dart';
import 'modal_bottom_sheet_screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({
    super.key,
    required this.futureCountries,
    required this.phoneNode,
    required this.phoneNumberController,
  });

  final Future<List<Country>> futureCountries;
  final FocusNode phoneNode;
  final TextEditingController phoneNumberController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xff8EAAFB)),
        home: Builder(
          builder: (context) => Scaffold(
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
                          height: 600,
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              SizedBox(
                                  height: 60,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showCupertinoModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return ModalSheet(
                                              futureCountries: futureCountries);
                                        },
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xffF4F5FF)
                                          .withOpacity(0.4),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                    ),
                                    child: const Text(
                                      '+380',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff594C74)),
                                    ),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                  child: TextFormField(
                                autofocus: true,
                                validator: (value) =>
                                    validatePhoneNumber(value!)
                                        ? null
                                        : 'Insert your number',
                                focusNode: phoneNode,
                                maxLength: 14,
                                inputFormatters: [
                                  PhoneNumberTextInputFormatter()
                                ],
                                controller: phoneNumberController,
                                style:
                                    const TextStyle(color: Color(0xff594C74)),
                                decoration: InputDecoration(
                                    counterText: '',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    filled: true,
                                    hintStyle: const TextStyle(
                                        color: Color(0xff7886B8)),
                                    hintText: "(067) 123-1234",
                                    fillColor: const Color(0xffF4F5FF)
                                        .withOpacity(0.4)),
                              ))
                            ],
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
          ),
        ));
  }
}
