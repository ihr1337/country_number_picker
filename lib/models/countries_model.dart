import 'dart:convert';
import 'package:http/http.dart' as http;

class Country {
  String? name;
  List<String>? suffixes;
  String? flag;
  String? root;

  Country(
      {required this.name,
      required this.suffixes,
      required this.flag,
      required this.root});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'],
      suffixes: json['idd'] != null
          ? List<String>.from(json['idd']['suffixes'])
          : null,
      flag: json['flags'] != null ? json['flags']['png'] : null,
      root: json['idd'] != null ? json['idd']['root'] : null,
    );
  }
}

List<Country> parseCountries(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Country>((json) => Country.fromJson(json)).toList();
}

String url = 'https://restcountries.com/v3.1/all?fields=name,flags,idd';

Future<List<Country>> fetchCountries() async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return parseCountries(response.body);
  } else {
    throw Exception('Failed to fetch countries');
  }
}
