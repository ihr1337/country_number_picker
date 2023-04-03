import 'package:flutter/material.dart' hide ModalBottomSheetRoute;

import 'countries_model.dart';
import 'screens/get_started_screen.dart';

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

    return GetStartedScreen(
        futureCountries: futureCountries,
        phoneNode: phoneNode,
        phoneNumberController: phoneNumberController);
  }
}
