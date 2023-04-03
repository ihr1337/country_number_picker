import 'package:flutter/material.dart';

import '../countries_model.dart';

class ModalSheet extends StatelessWidget {
  const ModalSheet({
    super.key,
    required this.futureCountries,
  });

  final Future<List<Country>> futureCountries;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: double.maxFinite,
          child: Column(
            children: [
              Row(
                children: const [
                  Text('Country code',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
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
              )),
              Expanded(
                child: FutureBuilder(
                    future: futureCountries,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                  title: Text(snapshot.data![index].name!),
                                  subtitle: Text(snapshot.data![index].idd!),
                                  leading: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Image.network(
                                        snapshot.data![index].flag!),
                                  ));
                            });
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
