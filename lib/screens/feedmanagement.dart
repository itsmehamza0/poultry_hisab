import 'package:flutter/material.dart';

class FeedManagementScreen extends StatelessWidget {
  const FeedManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FeedManagementScreen")),
      body: Center(child: Text("Feed Screen")),
    );
  }
}
