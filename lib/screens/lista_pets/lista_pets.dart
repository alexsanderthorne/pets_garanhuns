import 'package:flutter/material.dart';
import 'package:passaros_nordeste/screens/lista_pets/widget/card_pets.dart';
import 'package:firebase_database/firebase_database.dart';

class ListaPassaros extends StatefulWidget {
  const ListaPassaros({Key? key}) : super(key: key);

  @override
  _ListaPassarosState createState() => _ListaPassarosState();
}

class _ListaPassarosState extends State<ListaPassaros> {
  late List<Map<String, dynamic>> dataList;

  @override
  void initState() {
    super.initState();
    getDataFromFirebase();
  }

  Future<void> getDataFromFirebase() async {
    final DatabaseReference reference =
        FirebaseDatabase.instance.ref().child('pets');
    dataList = [];

    try {
      DatabaseEvent event = await reference.once();
      DataSnapshot dataSnapshot = event.snapshot;

      if (dataSnapshot.value != null && dataSnapshot.value is Map) {
        (dataSnapshot.value as Map).forEach((key, value) {
          Map<String, dynamic> animalData = {
            "id": key,
            "description": value["description"],
            "name": value["name"],
            "region": value["region"],
            "user": {
              "name": value["name"],
              "city": value["city"],
            },
          };

          dataList.add(animalData);
        });
      }
    } catch (error) {
      print('Error fetching data from Firebase: $error');
    }

    setState(() {});
  }

  Future<void> deleteAnimal(String animalId) async {
    try {
      await FirebaseDatabase.instance
          .ref()
          .child('pets')
          .child(animalId)
          .remove();
      getDataFromFirebase();
    } catch (error) {
      print('Error deleting animal from Firebase: $error');
    }
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
        child: dataList.isEmpty
            ? _buildEmptyListWidget()
            : ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> animalData = dataList[index];
                  return CardImage(
                    animalData: animalData,
                    onDelete: () => deleteAnimal(animalData["id"]),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildEmptyListWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('asset/cute_dog.jpg',
              height: 200, width: 200), // Substitua pelo caminho do seu GIF
          const SizedBox(height: 16),
          Text(
            'Nenhum animal encontrado.',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
