import 'package:flutter/material.dart';
import 'package:flutter_graphql_demo/presentation/viewmodels/countries_viewmodel.dart';
import 'package:provider/provider.dart';

class CountriesPage extends StatelessWidget {
  const CountriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CountriesViewmodel>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Countries (GraphQL)"),
      ),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : vm.error != null
          ? Center(
              child: Text("Error: ${vm.error}"),
            )
          : ListView.builder(
              itemCount: vm.countries.length,
              itemBuilder: (context, index) {
                final c = vm.countries[index];
                return ListTile(
                  leading: Text(c.emoji),
                  title: Text(c.name),
                  subtitle: Text(
                    'Capital: ${c.capital} • Currency: ${c.currency}',
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: vm.fetchCountries,
        child: const Icon(Icons.download),
      ),
    );
  }
}
