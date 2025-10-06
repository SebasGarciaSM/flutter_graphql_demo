import 'package:flutter/material.dart';
import 'package:flutter_graphql_demo/data/repositories/country_repository_impl.dart';
import 'package:flutter_graphql_demo/domain/usecases/get_countries_usecase.dart';
import 'package:flutter_graphql_demo/presentation/pages/countries_page.dart';
import 'package:flutter_graphql_demo/presentation/viewmodels/countries_viewmodel.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initHiveForFlutter();

  final repo = CountryRepositoryImpl();
  final useCase = GetCountriesUsecase(repo);
  final vm = CountriesViewmodel(useCase);

  runApp(MainApp(viewmodel: vm));
}

class MainApp extends StatelessWidget {
  final CountriesViewmodel viewmodel;
  const MainApp({super.key, required this.viewmodel});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => viewmodel),
      ],
      child: MaterialApp(
        title: 'GraphQL Demo',
        home: const CountriesPage(),
      ),
    );
  }
}
