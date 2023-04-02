import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'countries_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Country>> futureCountries;
  @override
  void initState() {
    super.initState();
    futureCountries = fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    final phoneNumberController = TextEditingController();

    final phoneNode = FocusNode();

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
                                          return Scaffold(
                                            body: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: SizedBox(
                                                height: double.maxFinite,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: const [
                                                        Text('Country code',
                                                            style: TextStyle(
                                                                fontSize: 32,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white)),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Flexible(
                                                        child: TextField(
                                                      style: const TextStyle(
                                                          color: Color(
                                                              0xff594C74)),
                                                      decoration:
                                                          InputDecoration(
                                                              prefixIcon:
                                                                  const Icon(
                                                                Icons.search,
                                                                color: Color(
                                                                    0xff594C74),
                                                              ),
                                                              counterText: '',
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide
                                                                        .none,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16.0),
                                                              ),
                                                              filled: true,
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xff7886B8)),
                                                              hintText:
                                                                  "Search",
                                                              fillColor: const Color(
                                                                      0xffF4F5FF)
                                                                  .withOpacity(
                                                                      0.4)),
                                                    )),
                                                    Expanded(
                                                      child: FutureBuilder(
                                                          future:
                                                              futureCountries,
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              return ListView
                                                                  .builder(
                                                                      itemCount: snapshot
                                                                          .data!
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return ListTile(
                                                                            title:
                                                                                Text(snapshot.data![index].name!),
                                                                            subtitle: Text(snapshot.data![index].idd!),
                                                                            leading: SizedBox(
                                                                              height: 30,
                                                                              width: 30,
                                                                              child: Image.network(snapshot.data![index].flag!),
                                                                            ));
                                                                      });
                                                            } else if (snapshot
                                                                .hasError) {
                                                              return Text(
                                                                  '${snapshot.error}');
                                                            }
                                                            return const CircularProgressIndicator();
                                                          }),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
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
