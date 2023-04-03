import '../models/countries_model.dart';

List<Country> countriesNewList = [];
String searchText = '';

List<Country> getFilteredCountries() {
  if (searchText.isEmpty) {
    return countriesNewList;
  } else {
    return countriesNewList
        .where((country) =>
            country.name!.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }
}
