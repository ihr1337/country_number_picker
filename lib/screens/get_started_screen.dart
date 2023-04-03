import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../models/countries_model.dart';
import '../util/phone_number_formatter.dart';
import 'modal_bottom_sheet_screen.dart';

class GetStartedScreen extends StatefulWidget {
  GetStartedScreen({
    super.key,
    required this.futureCountries,
  });

  late final Future<List<Country>> futureCountries;

  final phoneNode = FocusNode();

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  String countryCode = '+380';

  String countryFlag = 'https://flagcdn.com/w320/ua.png';

  bool _isTextFieldFilled = false;
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xff8EAAFB)),
        home: Builder(
          builder: (context) => Scaffold(
            resizeToAvoidBottomInset: false,
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
                              child: Row(children: [
                                SizedBox(
                                    height: 60,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        Map<String, dynamic>? result =
                                            await showCupertinoModalBottomSheet(
                                          context: context,
                                          builder: (context) => ModalSheet(
                                            futureCountries:
                                                widget.futureCountries,
                                          ),
                                        );
                                        if (result != null) {
                                          String idd = result['idd'];
                                          String flag = result['flag'];
                                          setState(() {
                                            countryCode = idd;
                                            countryFlag = flag;
                                          });
                                        } else {
                                          // do nothing
                                        }
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
                                      child: Row(
                                        children: [
                                          Image.network(
                                            countryFlag,
                                            height: 20,
                                            width: 20,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            countryCode,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff594C74)),
                                          ),
                                        ],
                                      ),
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                    child: TextFormField(
                                  controller: _phoneNumberController,
                                  autofocus: true,
                                  focusNode: widget.phoneNode,
                                  maxLength: 14,
                                  inputFormatters: [
                                    PhoneNumberTextInputFormatter()
                                  ],
                                  style:
                                      const TextStyle(color: Color(0xff594C74)),
                                  decoration: InputDecoration(
                                      counterText: '',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      filled: true,
                                      hintStyle: const TextStyle(
                                          color: Color(0xff7886B8)),
                                      hintText: "(067) 123-1234",
                                      fillColor: const Color(0xffF4F5FF)
                                          .withOpacity(0.4)),
                                ))
                              ]))
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
