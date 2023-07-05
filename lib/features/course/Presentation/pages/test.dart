import 'package:flutter/material.dart';

class testpage extends StatelessWidget {
  const testpage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> data = [
      'Elemento 1',
      'Elemento 2',
      'Elemento 3',
      'Elemento 4',
      'Elemento 5',
      'Elemento 6',
      'Elemento 7',
      'Elemento 8',
      'Elemento 9',
    ];

    return MaterialApp(
      title: 'Círculos en Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Círculos en Flutter'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: GridView.builder(
            itemCount: data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Dos círculos por fila
            ),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  child: Text(data[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
