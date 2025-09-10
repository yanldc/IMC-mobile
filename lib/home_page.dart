import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _pesoController = TextEditingController();
  TextEditingController _alturaController = TextEditingController();
  String _resultado = 'Informe seus dados';
  IconData _icone = Icons.calculate;

  void _calcular() {
    double? peso = double.tryParse(_pesoController.text);
    double? altura = double.tryParse(_alturaController.text);

    if (peso == null || altura == null || peso <= 0 || altura <= 0) {
      setState(() {
        _resultado = 'Digite valores válidos!';
        _icone = Icons.error;
      });
      return;
    }

    double alturaMetros = altura / 100;
    double imc = peso / (alturaMetros * alturaMetros);

    setState(() {
      if (imc < 18.5) {
        _resultado = 'Abaixo do peso';
        _icone = Icons.trending_down;
      } else if (imc >= 18.5 && imc <= 24.9) {
        _resultado = 'Peso ideal (parabéns)';
        _icone = Icons.favorite;
      } else if (imc >= 25.0 && imc <= 29.9) {
        _resultado = 'Levemente acima do peso';
        _icone = Icons.trending_up;
      } else if (imc >= 30.0 && imc <= 34.9) {
        _resultado = 'Obesidade grau I';
        _icone = Icons.warning;
      } else if (imc >= 35.0 && imc <= 39.9) {
        _resultado = 'Obesidade grau II (severa)';
        _icone = Icons.dangerous;
      } else {
        _resultado = 'Obesidade III (mórbida)';
        _icone = Icons.local_hospital;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Calculadora de IMC',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 200,
            child: Image.asset('images/imc.png'),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
              controller: _pesoController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Peso (kg)',
                labelStyle: TextStyle(color: Colors.green),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
              controller: _alturaController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Altura (cm)',
                labelStyle: TextStyle(color: Colors.green),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            height: 50,
            width: 200,
            child: ElevatedButton(
              child: const Text(
                'Calcular',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: _calcular,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(_icone, color: Colors.green, size: 30),
                SizedBox(width: 10),
                Flexible(
                  child: Text(
                    _resultado,
                    style: TextStyle(color: Colors.green, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
