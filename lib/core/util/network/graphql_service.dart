import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../../data/base/BaseResponse.dart';
import 'parser.dart';


@singleton
class GraphQLService {
  GraphQLService() {
    final link = HttpLink('https://test.lechoix.com/graphql');
    _graphQLClient = GraphQLClient(link: link, cache: GraphQLCache());
  }

  late final GraphQLClient _graphQLClient;

  Future<BaseResponse<T>> performQuery<T>(
    String query, {
    required Map<String, dynamic> variables,
  }) async {
    // try {
      final options = QueryOptions(
        document: gql(query),
        variables: variables,
      
      );

      final result = await _graphQLClient.query(options);
      log("graphql query => ${result.data}");
      if (result.hasException) {
        final errorCode =
            result.context.entry<HttpLinkResponseContext>()?.statusCode ?? 0;
        return parseResponse<T>(result.data);
        // Failure(
        //   error: APIException(result.exception.toString(), errorCode, ''),
        // );
      } else {
        return parseResponse<T>(result.data);
        // return Success(data: result.data);
      }
  
    // on Exception catch (_, e) {
    
    //  return parseResponse<T>(e as Map<String, dynamic>?);
    //   // return Failure(error: APIException(e.toString(), 0, ''));
    // }
  }

  Future<QueryResult> performMutation(
    String query, {
    required Map<String, dynamic> variables,
  }) async {
    final options = MutationOptions(document: gql(query), variables: variables);
    final result = await _graphQLClient.mutate(options);
    log(result.toString());
    return result;
  }

   BaseResponse<T> parseResponse<T>(Map<String, dynamic>? response) {
    BaseResponse<T> baseResponse = BaseResponse();

    if (response == null || response["data"] == null) return baseResponse;
    baseResponse.message = response["message"];
    if (T == dynamic) {
      baseResponse.data = null;
    } else {
      baseResponse.data = Parser.parse<T>(response["data"]);
    }

    return baseResponse;
  }
}
