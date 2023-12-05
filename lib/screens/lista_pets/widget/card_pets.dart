import 'package:flutter/material.dart';
import 'package:passaros_nordeste/screens/passaros_detalhe/DetalhesAnimal.dart';

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
        await widget.onDelete();
        _showDeleteSnackbar();
      },
      child: InkWell(
        onTap: () {
          // Navegar para a tela de detalhes editáveis ao clicar no card
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DetalhesAnimal(animalData: widget.animalData),
            ),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
      ),
    );
  }

  void _showDeleteSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Animal removido com sucesso!'),
      ),
    );
  }
}
