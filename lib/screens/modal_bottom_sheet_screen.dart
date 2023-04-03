import 'package:flutter/material.dart';

import '../models/countries_model.dart';

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
  List<Country> _countries = [];
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    widget.futureCountries.then((countries) {
      setState(() {
        _countries = countries;
      });
    });
  }

  List<Country> _getFilteredCountries() {
    if (_searchText.isEmpty) {
      return _countries;
    } else {
      return _countries
          .where((country) =>
              country.name!.toLowerCase().contains(_searchText.toLowerCase()) ||
              country.idd!.toLowerCase().contains(_searchText.toLowerCase()))
          .toList();
    }
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
                      const Text('Country code',
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Ink(
                          decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6.0))),
                              color: Colors.amber),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 15,
                              color: Color(0xffF4F5FF),
                            ),
                            color: const Color(0xff594C74).withOpacity(0.4),
                            splashRadius: 10,
                            tooltip: 'Close',
                            focusColor: const Color(0xffF4F5FF),
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ]),
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
                      _searchText = value;
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
                              itemCount: _getFilteredCountries().length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: 50,
                                  child: ListTile(
                                      onTap: () {},
                                      title: Row(children: [
                                        Text(
                                          _getFilteredCountries()[index].idd!,
                                          style: const TextStyle(
                                              color: Color(0xff594C74)),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: Text(
                                            _getFilteredCountries()[index]
                                                .name!,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ]),
                                      leading: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Image.network(
                                            _getFilteredCountries()[index]
                                                .flag!),
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
