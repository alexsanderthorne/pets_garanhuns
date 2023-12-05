import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CardImage extends StatefulWidget {
  final Map<String, dynamic> animalData;
  final Future<void> Function() onDelete;

  const CardImage({
    Key? key,
    required this.animalData,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<CardImage> createState() => _CardImageState();
}

class _CardImageState extends State<CardImage> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.animalData["name"]),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16.0),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) async {
        await widget.onDelete(); // Chama a função de remoção
        setState(() {}); // Atualiza o estado para reconstruir o widget
      },
      child: InkWell(
        onTap: () {
          // Adicionar detalhes
        },
        child: Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Descrição: ${widget.animalData["description"] ?? ""}\n" +
                      "Nome: ${widget.animalData["name"] ?? ""}\n" +
                      "Região: ${widget.animalData["region"] ?? ""}",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
