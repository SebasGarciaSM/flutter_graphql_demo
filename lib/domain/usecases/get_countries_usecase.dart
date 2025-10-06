import 'package:flutter_graphql_demo/domain/entities/country_entity.dart';
import 'package:flutter_graphql_demo/domain/repositories/country_repository.dart';

class GetCountriesUsecase {
  final CountryRepository repository;

  GetCountriesUsecase(this.repository);

  Future<List<CountryEntity>> call() async {
    return await repository.getCountries();
  }
}
