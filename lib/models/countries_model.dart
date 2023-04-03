import 'dart:convert';
import 'package:http/http.dart' as http;

class Country {
  String? name;
  String? idd;
  String? flag;

  Country({required this.name, required this.idd, required this.flag});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'],
      idd: json['idd'] != null ? json['idd']['root'] : 'null',
      flag: json['flags'] != null ? json['flags']['png'] : 'null',
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
