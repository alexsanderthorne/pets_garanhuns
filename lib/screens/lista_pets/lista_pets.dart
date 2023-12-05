import 'dart:async';

import 'package:flutter/material.dart';
import 'package:passaros_nordeste/screens/lista_pets/widget/card_pets.dart';
import 'package:firebase_database/firebase_database.dart';

class ListaPassaros extends StatelessWidget {
  const ListaPassaros({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> getDataFromFirebase() async {
    final DatabaseReference reference =
        FirebaseDatabase.instance.ref().child('pets');
    List<Map<String, dynamic>> dataList = [];

    try {
      DatabaseEvent event = await reference.once();
      DataSnapshot dataSnapshot = event.snapshot;

      if (dataSnapshot.value != null && dataSnapshot.value is Map) {
        (dataSnapshot.value as Map).forEach((key, value) {
          Map<String, dynamic> animalData = {
            "name": value["name"],
            "region": value["region"],
            "description": value["description"],
            "user": value["user"],
          };

          dataList.add(animalData);
        });
      }
    } catch (error) {
      print('Error fetching data from Firebase: $error');
    }

    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(165, 70, 2, 1),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Lista de Pets',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: getDataFromFirebase(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Erro: ${snapshot.error}'),
                    );
                  } else {
                    List<Map<String, dynamic>> dataList = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> animalData = dataList[index];
                        return CardImage(
                          animalData: animalData,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
