import 'package:flutter/material.dart';
import 'package:flutter_graphql_demo/domain/entities/country_entity.dart';
import 'package:flutter_graphql_demo/domain/usecases/get_countries_usecase.dart';

class CountriesViewmodel extends ChangeNotifier {
  final GetCountriesUsecase getCountriesUsecase;

  CountriesViewmodel(this.getCountriesUsecase);

  List<CountryEntity> _countries = [];
  bool _isLoading = false;
  String? _error;

  List<CountryEntity> get countries => _countries;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCountries() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _countries = await getCountriesUsecase();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
