import 'package:flutter/material.dart';
// import 'package:firebase_database.dart';

class CardImage extends StatefulWidget {
  final Map<String, dynamic> animalData;

  const CardImage({Key? key, required this.animalData}) : super(key: key);

  @override
  State<CardImage> createState() => _CardImageState();
}

class _CardImageState extends State<CardImage> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Adicionar detalhes
      },
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(widget.animalData["name"] ?? ""),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(widget.animalData["description"] ?? ""),
            ),
          ],
        ),
      ),
    );
  }
}
