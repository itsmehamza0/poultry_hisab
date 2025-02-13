import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'applications/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PoultryHisab());
}
