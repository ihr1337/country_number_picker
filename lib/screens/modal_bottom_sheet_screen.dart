import 'package:flutter/material.dart';

import '../models/countries_model.dart';
import '../util/get_filtered_countries.dart';

class ModalSheet extends StatefulWidget {
  const ModalSheet({
    super.key,
    required this.futureCountries,
  });

  final Future<List<Country>> futureCountries;

  @override
  State<ModalSheet> createState() => _ModalSheetState();
}

class _ModalSheetState extends State<ModalSheet> {
  @override
  void initState() {
    super.initState();
    widget.futureCountries.then((countries) {
      setState(() {
        countriesNewList = countries;
      });
    });
  }

  void _selectItem(String idd, String flag, String? suffix) {
    Navigator.pop(context, {'idd': idd, 'flag': flag, 'suffix': suffix});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: double.maxFinite,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Country code',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Align(
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0xffF4F5FF).withOpacity(0.4),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 15,
                            color: Color(0xff594C74),
                          ),
                          splashRadius: 10,
                          tooltip: 'Close',
                          focusColor: const Color(0xffF4F5FF),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(4),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Flexible(
                    child: TextField(
                  style: const TextStyle(color: Color(0xff594C74)),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xff594C74),
                      ),
                      counterText: '',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      filled: true,
                      hintStyle: const TextStyle(color: Color(0xff7886B8)),
                      hintText: "Search",
                      fillColor: const Color(0xffF4F5FF).withOpacity(0.4)),
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                )),
                Expanded(
                  flex: 13,
                  child: FutureBuilder(
                      future: widget.futureCountries,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: getFilteredCountries().length,
                              itemBuilder: (context, index) {
                                final country = getFilteredCountries()[index];
                                final idd = country.suffixes?.isNotEmpty == true
                                    ? '${country.root!}${country.suffixes![0]}'
                                    : '';
                                return SizedBox(
                                  height: 50,
                                  child: ListTile(
                                      onTap: () {
                                        _selectItem(
                                          idd.isNotEmpty == true
                                              ? idd
                                              : 'no code',
                                          country.flag!,
                                          country.suffixes?.isNotEmpty == true
                                              ? country.suffixes![0]
                                              : 'no suffix',
                                        );
                                      },
                                      title: Row(children: [
                                        Text(
                                          idd,
                                          style: const TextStyle(
                                              color: Color(0xff594C74)),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: Text(
                                            country.name!,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ]),
                                      leading: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Image.network(country.flag!),
                                      )),
                                );
                              });
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return const SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator());
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
