// detalhes_animal.dart

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class DetalhesAnimal extends StatefulWidget {
  final Map<String, dynamic> animalData;

  const DetalhesAnimal({Key? key, required this.animalData}) : super(key: key);

  @override
  _DetalhesAnimalState createState() => _DetalhesAnimalState();
}

class _DetalhesAnimalState extends State<DetalhesAnimal> {
  late TextEditingController descricaoController;
  late TextEditingController nomeController;
  late TextEditingController regiaoController;

  @override
  void initState() {
    super.initState();
    descricaoController = TextEditingController(text: widget.animalData["description"]);
    nomeController = TextEditingController(text: widget.animalData["name"]);
    regiaoController = TextEditingController(text: widget.animalData["region"]);
  }

  void _atualizarAnimal() {
    // Atualize os dados do animal no Firebase usando o ID como identificador
    FirebaseDatabase.instance
        .ref()
        .child('pets')
        .child(widget.animalData["id"])
        .update({
      "description": descricaoController.text,
      "name": nomeController.text,
      "region": regiaoController.text,
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Animal atualizado com sucesso!'),
        ),
      );
    }).catchError((error) {
      print('Erro ao atualizar animal: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Animal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextFormField(
              controller: descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            TextFormField(
              controller: regiaoController,
              decoration: InputDecoration(labelText: 'Região'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _atualizarAnimal,
              child: Text('Atualizar Animal'),
            ),
          ],
        ),
      ),
    );
  }
}
