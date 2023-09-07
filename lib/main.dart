import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'provider/asset_provider.dart';
import 'service/asset_service.dart';

void main() {
  runApp(const QuoteListApp());
}

class QuoteListApp extends StatelessWidget {
  const QuoteListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApiProvider(
        AssetService(),
      ),
      child: MaterialApp(
        title: 'Quote List App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
