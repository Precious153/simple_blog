import 'package:graphql_flutter/graphql_flutter.dart';

class ErrorException implements Exception{
  ErrorException.exception(OperationException exception){
    if(exception.linkException != null){
      // message = 'Network Error';
      message = exception.linkException!.originalException.toString();
    } else {
      message = exception.graphqlErrors[0].message;
    }
  }
  static String message = '';

  @override
  String toString() => message;
}