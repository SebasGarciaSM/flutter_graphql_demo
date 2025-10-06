import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CountriesPage extends StatelessWidget {
  const CountriesPage({super.key});

  final String query = r'''
    query GetCountries {
      countries {
        code
        name
        emoji
        capital
        currency
        languages {
          code
          name
        }
      }
    }
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Countries (GraphQL)"),
      ),
      body: Query(
        options: QueryOptions(document: gql(query)),
        builder:
            (
              QueryResult result, {
              VoidCallback? refetch,
              FetchMore? fetchMore,
            }) {
              if (result.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (result.hasException) {
                return Center(
                  child: Text(result.exception.toString()),
                );
              }

              final List countries = result.data?['countries'] ?? [];

              return ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final c = countries[index];
                  return ListTile(
                    leading: Text(c['emoji'] ?? ''),
                    title: Text(c['name'] ?? ''),
                    subtitle: Text(
                      'Capital: ${c['capital'] ?? '-'} • Currency: ${c['currency'] ?? '—'}',
                    ),
                  );
                },
              );
            },
      ),
    );
  }
}
