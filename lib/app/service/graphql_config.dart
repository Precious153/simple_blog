import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';



class GraphqlConfig {
  static const url = 'https://uat-api.vmodel.app/graphql/';
  //static const url = 'https://cardio-api-osdx.onrender.com/graphql';
  static final httpLink = HttpLink(url);

  static GraphQLClient glClient() =>
      GraphQLClient(link: httpLink, cache: GraphQLCache(store: InMemoryStore()));

  static  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    ),
  );
}
