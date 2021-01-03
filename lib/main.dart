import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BmiCalculator(),
    );
  }
}

class BmiCalculator extends StatefulWidget {
  BmiCalculator({Key key}) : super(key: key);

  @override
  _BmiCalculatorState createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  int currentindex = 0;
  String resultado = "0.00";

  TextEditingController alturaControl = TextEditingController();
  TextEditingController pesoControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Índice de Massa Corporal",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
            ),
          ),
          toolbarHeight: 70.0,
          elevation: 10.0,
          //backgroundColor: Colors.green,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                onPressed: () {})
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    radioButton("Homem", Colors.blue, 0),
                    radioButton("Mulher", Colors.pink, 1),
                  ],
                ),
                SizedBox(
                  height: 25.0,
                ),
                Text(
                  "ALTURA (cm): ",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  controller: alturaControl,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Digite sua altura aqui...",
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "PESO (kg): ",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  controller: pesoControl,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Digite seu peso aqui...",
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: double.infinity,
                  height: 60.0,
                  child: FlatButton(
                    onPressed: () {
                      double altura = double.parse(alturaControl.value.text);
                      double peso = double.parse(pesoControl.value.text);
                      calcularIMC(altura, peso);
                    },
                    color: Colors.blue,
                    child: Text(
                      "Calcular",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    "IMC = $resultado",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                /*Container(
                  width: double.infinity,
                  child: Text(
                    "$resultado",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calcularIMC(double altura, double peso) {
    altura = altura / 100;
    double resultadofinal = peso / (altura * altura);

    String imc = resultadofinal.toStringAsFixed(2) +
        "\nPeso ideal = " +
        calcularPesoIdeal(currentindex, altura).toStringAsFixed(2) +
        " kg";

    setState(() {
      resultado = imc;
    });
  }

  double calcularPesoIdeal(int genero, double altura) {
    double pesoideal = 0.0;

    switch (genero) {
      case 0:
        pesoideal = 72.7 * altura - 58;
        break;
      case 1:
        pesoideal = 62.1 * altura - 44.7;
        break;
    }
    return pesoideal;
  }

  void changeIndex(int index) {
    setState(() {
      currentindex = index;
    });
  }

  Widget radioButton(String value, Color color, int index) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0),
        height: 65.0,
        child: FlatButton(
          color: currentindex == index ? color : Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          onPressed: () {
            changeIndex(index);
          },
          child: Text(
            value,
            style: TextStyle(
              color: currentindex == index ? Colors.white : color,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
