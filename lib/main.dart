import 'package:flutter/material.dart';

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
                            Flexible(
                                child: TextField(
                              controller: phoneNumberController,
                              decoration: InputDecoration(
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
              child: const Icon(Icons.arrow_forward)),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ));
  }
}
