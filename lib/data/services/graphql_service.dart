import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  static final HttpLink _httpLink = HttpLink(
    'https://countries.trevorblades.com/',
  );

  static final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: _httpLink,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  static GraphQLClient getClient() => client.value;
}
