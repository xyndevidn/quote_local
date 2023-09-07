import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/asset_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final apiProvider = context.read<ApiProvider>();

    Future.microtask(() async => apiProvider.getQuotes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quote List App"),
      ),
      body: Consumer<ApiProvider>(
        builder: (context, value, child) {
          final state = value.quotesState;

          return state.map(
            loading: (value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            loaded: (value) {
              final quotes = value.data;
              return ListView.builder(
                itemCount: quotes.length,
                itemBuilder: (context, index) {
                  final quote = quotes[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            quote.en,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          Text(quote.author),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            error: (value) {
              final message = value.message;
              return Center(
                child: Text(message),
              );
            },
            initial: (value) {
              return const Center(
                child: Text("No data"),
              );
            },
          );
        },
      ),
    );
  }
}
