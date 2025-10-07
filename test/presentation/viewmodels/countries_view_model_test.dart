import 'package:flutter_graphql_demo/domain/entities/country_entity.dart';
import 'package:flutter_graphql_demo/domain/usecases/get_countries_usecase.dart';
import 'package:flutter_graphql_demo/presentation/viewmodels/countries_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mocks.mocks.dart';

void main() {
  late MockCountryRepository mockCountryRepository;
  late GetCountriesUsecase getCountriesUsecase;
  late CountriesViewmodel viewModel;

  setUp(() {
    mockCountryRepository = MockCountryRepository();
    getCountriesUsecase = GetCountriesUsecase(mockCountryRepository);
    viewModel = CountriesViewmodel(getCountriesUsecase);
  });

  group('CountriesViewModel', () {
    test('must load the list of countries correctly', () async {
      // Arrange
      final countries = [
        CountryEntity(
          code: 'MX',
          name: 'Mexico',
          emoji: '🇲🇽',
          capital: 'CDMX',
          currency: 'MXN',
        ),
        CountryEntity(
          code: 'US',
          name: 'USA',
          emoji: '🇺🇸',
          capital: 'Washington',
          currency: 'USD',
        ),
      ];

      when(
        mockCountryRepository.getCountries(),
      ).thenAnswer((_) async => countries);

      // Act
      await viewModel.fetchCountries();

      // Assert
      expect(viewModel.isLoading, false);
      expect(viewModel.error, isNull);
      expect(viewModel.countries.length, 2);
      verify(mockCountryRepository.getCountries()).called(1);
    });

    test('must manage errors correctly', () async {
      // Arrange
      when(
        mockCountryRepository.getCountries(),
      ).thenThrow(Exception('Connection Error'));

      // Act
      await viewModel.fetchCountries();

      // Assert
      expect(viewModel.isLoading, false);
      expect(viewModel.error, isNotNull);
      expect(viewModel.countries, isEmpty);
      verify(mockCountryRepository.getCountries()).called(1);
    });
  });
}
