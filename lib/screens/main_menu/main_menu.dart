import 'package:flutter/material.dart';
import 'package:passaros_nordeste/constants.dart';
import 'package:passaros_nordeste/screens/main_menu/widgets/main_menu_card.dart';
import 'package:passaros_nordeste/screens/main_menu/widgets/main_menu_search.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PetStop'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                        'asset/cat2.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Nome do App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Versão 1.0.0',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Lista de Pets'),
              onTap: () {
                Navigator.pushNamed(context, '/lista_pets');
              },
            ),
            ListTile(
              title: Text('Cadastrar Animal'),
              onTap: () {
                Navigator.pushNamed(context, '/cadastrar_passaro');
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(paddingL),
            child: Column(
              children: const [
                MainMenuSearch(),
                SizedBox(
                  height: 25,
                ),
                MainMenuCard(
                  image: 'asset/cat_and_dof2.jpg',
                  text: 'Acessar lista completa dos Pets',
                  rota: '/lista_pets',
                ),
                SizedBox(
                  height: 25,
                ),
                MainMenuCard(
                  image: 'asset/cute_dog.jpg',
                  text: 'Cadastrar um Animal para adoção',
                  rota: '/cadastrar_passaro',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
