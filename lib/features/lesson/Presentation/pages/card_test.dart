import 'package:flutter/material.dart';

class HorizontalScrollableCards extends StatefulWidget {
  @override
  _HorizontalScrollableCardsState createState() =>
      _HorizontalScrollableCardsState();
}

class _HorizontalScrollableCardsState extends State<HorizontalScrollableCards> {
  // Lista de elementos
  List<String> itemList = [
    'Tarjeta 1',
    'Tarjeta 2',
  ];

  // Índice actual
  int currentIndex = 0;

  // Controlador del PageView
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarjetas Desplazables'),
      ),
      body: Column(
        children: [
          // Lista horizontal
          SizedBox(
            height: 200, // Altura deseada para las tarjetas
            child: PageView.builder(
              controller: pageController,
              itemCount: itemList.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return buildCard(itemList[index]);
              },
            ),
          ),
          // Botones de navegación
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  if (currentIndex > 0) {
                    pageController.previousPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease);
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  if (currentIndex < itemList.length - 1) {
                    pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Método para construir una tarjeta
  Widget buildCard(String text) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: Text(text),
      ),
    );
  }
}
