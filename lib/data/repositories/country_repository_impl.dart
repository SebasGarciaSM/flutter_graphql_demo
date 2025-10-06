import 'dart:convert';

import 'package:flutter_graphql_demo/data/models/country_model.dart';
import 'package:flutter_graphql_demo/data/services/graphql_service.dart';
import 'package:flutter_graphql_demo/domain/entities/country_entity.dart';
import 'package:flutter_graphql_demo/domain/repositories/country_repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CountryRepositoryImpl implements CountryRepository {
  final GraphQLClient client = GraphQLService.getClient();

  final String _query = r'''
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
  Future<List<CountryEntity>> getCountries() async {
    final result = await client.query(QueryOptions(document: gql(_query)));

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List data = result.data?['countries'] ?? [];
    return data.map((json) => CountryModel.fromJson(json)).toList();
  }
}
