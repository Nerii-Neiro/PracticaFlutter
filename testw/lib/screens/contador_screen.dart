import 'package:flutter/material.dart';

class ContadorScreen extends StatefulWidget {
  const ContadorScreen({super.key}); 
  @override
  State<ContadorScreen>createState()=>_ContadorScreenState();
}

class _ContadorScreenState extends State<ContadorScreen>{

var contador = 0;

@override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "App de TAP",
          style: TextStyle(color: Color.fromARGB(255, 243, 241, 241)),
          ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "Valor del Contador: $contador",
          style:
           TextStyle(fontSize: 25,color: Color.fromARGB(255, 80, 115, 211)),)
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.ads_click),
        onPressed: (){
          contador++;
          //ACTUALIZAR EL CONTADOR EN TIEMPO DE VIDA
          setState(() {
            
          });
        }
        ),
    );
  }
}