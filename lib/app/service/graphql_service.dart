import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'graphql_config.dart';

class GraphqlService {
  final _client = GraphqlConfig.glClient();

  Future<QueryResult> query(
      {required String graphql, Map<String, dynamic>? variables}) async {
    try {
      final result = await _client.query(QueryOptions(
          document: gql(graphql),
          variables: variables ?? const {},
          fetchPolicy: FetchPolicy.noCache));
      return result;
    } on FormatException {
      throw const FormatException("Bad response format 👎");
    } catch (e) {
      rethrow;
    }
  }
  Future<QueryResult> mutate(
      {required String graphql,  Map<String, dynamic>? variables}) async {
    try {
      final result = await _client.mutate(MutationOptions(
          document: gql(graphql),
          variables: variables??{},
          fetchPolicy: FetchPolicy.noCache));
      return result;
    } on FormatException {
      throw const FormatException("Bad response format 👎");
    } catch (e) {
      rethrow;
    }
  }


}
