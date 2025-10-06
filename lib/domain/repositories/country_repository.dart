import 'package:flutter_graphql_demo/domain/entities/country_entity.dart';

abstract class CountryRepository {
  Future<List<CountryEntity>> getCountries();
}
