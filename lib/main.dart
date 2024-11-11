// ignore_for_file: prefer_const_constructors

import 'package:cipher_encryption/tabs/decode-page.dart';
import 'package:cipher_encryption/tabs/encode-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor:
        ColorScheme.fromSeed(seedColor: Colors.blue).surface,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Cipher Encryption'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.lock),
                text: 'Encrypt',
              ),
              Tab(
                icon: Icon(Icons.lock_open),
                text: 'Decrypt',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Tabs('Encrypt'),
            Tabs('Decrypt'),
          ],
        ),
      ),
    );
  }
}

class Tabs extends StatefulWidget {
  const Tabs(this.s, {super.key});

  final String s;

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: const [
          EncodePage(),
          DecodePage(),
        ],
      ),
    );
  }
}
