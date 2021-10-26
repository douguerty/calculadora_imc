import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Home(),
      ),
    );

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Informe seus dados!';

  void _resetFields() {
    weightController.text = '';
    heightController.text = '';
    setState(() {
      _infoText = 'Informe seus dados!';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    double peso = double.parse(weightController.text);
    double altura = double.parse(heightController.text) / 100;
    double imc = peso / (altura * altura);
    String info;

    if (imc <= 16.9) {
      info = 'Muito abaixo do peso';
    } else if (imc <= 18.4) {
      info = 'Abaixo do peso';
    } else if (imc <= 24.9) {
      info = 'Peso normal';
    } else if (imc <= 29.9) {
      info = 'Acima do peso';
    } else if (imc <= 34.9) {
      info = 'Obesidade grau I';
    } else if (imc <= 40.0) {
      info = 'Obesidade grau II';
    } else {
      info = 'Obesidade grau III';
    }

    setState(() {
      _infoText = '$info (${imc.toStringAsPrecision(4)})';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora IMC'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          actions: [
            IconButton(onPressed: _resetFields, icon: Icon(Icons.refresh))
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.person_outline,
                    size: 120.0, color: Colors.deepPurpleAccent),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Peso (kg)',
                      labelStyle: TextStyle(color: Colors.deepPurple)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.deepPurple, fontSize: 20.0),
                  controller: weightController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe seu peso!';
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Altura (cm)',
                      labelStyle: TextStyle(color: Colors.deepPurple)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.deepPurple, fontSize: 20.0),
                  controller: heightController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe seu peso!';
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _calculate();
                        }
                      },
                      child: Text(
                        'Calcular',
                        style: TextStyle(fontSize: 25.0),
                      ),
                      style:
                          ElevatedButton.styleFrom(primary: Colors.deepPurple),
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.deepPurple, fontSize: 25.0),
                )
              ],
            ),
          ),
        ));
  }
}
