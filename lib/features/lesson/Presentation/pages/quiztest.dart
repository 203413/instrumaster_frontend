import 'package:flutter/material.dart';

class quiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Selección de incisos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SelectionScreen(),
    );
  }
}

class Exercise {
  final String title;
  final List<String> options;

  Exercise({required this.title, required this.options});
}

class SelectionScreen extends StatefulWidget {
  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  List<Exercise> exercises = [
    Exercise(
      title: 'Ejercicio 1',
      options: ['Opción 1111', 'Opción 2', 'Opción 3', 'Opción 4'],
    ),
    Exercise(
      title: 'Ejercicio 2',
      options: ['Opción A', 'Opción B', 'Opción C', 'Opción D'],
    ),
    Exercise(
      title: 'Ejercicio 3',
      options: ['Opción X', 'Opción Y', 'Opción Z', 'Opción W'],
    ),
    Exercise(
      title: 'Ejercicio 4',
      options: ['Opción sd', 'Opción sd', 'Opción 12', 'Opción W'],
    ),
  ];

  late List<String> selectedOptions =
      []; // Lista para almacenar las opciones seleccionadas

  void printSelectedOption(String selectedOption) {
    print(selectedOption);
  }

  @override
  void initState() {
    super.initState();
    selectedOptions = List<String>.filled(exercises.length,
        ''); // Inicializar la lista de opciones seleccionadas con valores nulos
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selección de incisos'),
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          Exercise exercise = exercises[index];
          String selectedOption = selectedOptions[
              index]; // Obtener la opción seleccionada correspondiente al ejercicio

          return Column(
            children: [
              ListTile(
                title: Text(exercise.title),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: exercise.options.length,
                itemBuilder: (context, optionIndex) {
                  String option = exercise.options[optionIndex];
                  return RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOptions[index] =
                            value!; // Actualizar la opción seleccionada en la lista correspondiente al ejercicio
                      });
                    },
                  );
                },
              ),
              ElevatedButton(
                child: Text('Enviar respuesta'),
                onPressed: () {
                  String selectedOption = selectedOptions[
                      index]; // Obtener la opción seleccionada correspondiente al ejercicio
                  if (selectedOption != null) {
                    printSelectedOption(selectedOption);
                  }
                },
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}
