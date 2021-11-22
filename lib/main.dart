import 'package:flutter/material.dart';

void main() => runApp(const Home());

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Informe seus dados';

  void _resetForm() {
    weightController.text = '';
    heightController.text = '';

    setState(() {
      _infoText = 'Informe seus dados';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);
    if(imc < 18.5) {
      setState(() => _infoText = 'Abaixo do peso ${imc.toStringAsPrecision(4)}');
    } else if(imc >= 18.5 && imc <= 24.9) {
      setState(() => _infoText = 'Peso ideal ${imc.toStringAsPrecision(4)}');
    } else if(imc >= 25 && imc <= 29.9) {
      setState(() => _infoText = 'Sobrepeso ${imc.toStringAsPrecision(4)}');
    } else if(imc >= 30 && imc <= 39.9) {
      setState(() => _infoText = 'Obeso ${imc.toStringAsPrecision(4)}');
    } else if(imc >= 40) {
      setState(() => _infoText = 'Muito obeso ${imc.toStringAsPrecision(4)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora de IMC'),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _resetForm,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.person_outline,
                  size: 120.0,
                  color: Colors.green,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: weightController,
                  validator:(value) {
                    if(value!.isEmpty) {
                      return 'Insira seu peso!';
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Peso (KG)',
                    labelStyle: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 25.0,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: heightController,
                  validator:(value) {
                    if(value!.isEmpty) {
                      return 'Insira sua altura!';
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Altura (CM)',
                    labelStyle: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 25.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: SizedBox(
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          _calculate();
                        }
                      },
                      child: const Text(
                        'Calcular',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                      ),
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 25.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
