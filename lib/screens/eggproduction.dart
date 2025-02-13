import 'package:flutter/material.dart';

class EggProductionScreen extends StatelessWidget {
  const EggProductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("EggProductionScreen")),
      body: Center(child: Text("Egg Production ")),
    );
  }
}
