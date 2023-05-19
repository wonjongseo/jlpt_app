import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class NewApp extends StatelessWidget {
  const NewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      home: const NewHomeSceen(),
    );
  }
}

class NewHomeSceen extends StatelessWidget {
  const NewHomeSceen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text('Hello'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text('Hello'),
          ],
        ),
      ),
    );
  }
}
