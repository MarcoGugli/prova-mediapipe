import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const platform = MethodChannel('com.example.nome_app/channel');

  Future<void> callNativeMethod() async {
    try {
      final String result =
          await platform.invokeMethod('metodoNativo', {"param": "esempio"});
      print("Risultato da Kotlin: $result");
    } on PlatformException catch (e) {
      print("Errore: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Flutter con Kotlin")),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              callNativeMethod();
            },
            child: Text("Chiama metodo nativo"),
          ),
        ),
      ),
    );
  }
}
