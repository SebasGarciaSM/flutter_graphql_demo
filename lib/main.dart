import 'package:flutter/material.dart';
import 'package:flutter_graphql_demo/data/repositories/country_repository_impl.dart';
import 'package:flutter_graphql_demo/domain/repositories/country_repository.dart';
import 'package:flutter_graphql_demo/domain/usecases/get_countries_usecase.dart';
import 'package:flutter_graphql_demo/presentation/pages/countries_page.dart';
import 'package:flutter_graphql_demo/presentation/viewmodels/countries_viewmodel.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initHiveForFlutter();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Repository (data)
        Provider<CountryRepositoryImpl>(create: (_) => CountryRepositoryImpl()),

        // UseCase (domain) depends on Repository
        Provider(
          create: (context) =>
              GetCountriesUsecase(context.read<CountryRepositoryImpl>()),
        ),

        // ViewModel (presentation) depends on UseCase
        ChangeNotifierProvider(
          create: (context) =>
              CountriesViewmodel(context.read<GetCountriesUsecase>()),
        ),
      ],
      child: MaterialApp(
        title: 'GraphQL Demo',
        home: const CountriesPage(),
      ),
    );
  }
}
