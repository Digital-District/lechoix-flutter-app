import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lechoix/cache/user_cache.dart';
import 'package:lechoix/core/util/network/graphql_service.dart';
import 'package:lechoix/core/util/network/network_manager.dart';

abstract class BaseRepo {
  late CancelToken cancelToken;
  late NetworkManager networkManager;
  late GraphQLService graphQLService;
  UserCache userCache = UserCache.instance;

  BaseRepo() {
    cancelToken = CancelToken();
    networkManager = NetworkManager(cancelToken: cancelToken);
    graphQLService =GraphQLService();
        final httpLink = HttpLink("https://test.lechoix.com/graphql");
     _client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
      // 
      // You have two other caching options. 
      // But for my example I won't be using caching.
      //
      // cache: GraphQLCache(store: HiveStore()),
      // cache: GraphQLCache(store: InMemoryStore()),
      //
      defaultPolicies: DefaultPolicies(query: Policies(fetch: FetchPolicy.networkOnly)),
    );
      _clientNotifier = ValueNotifier(_client);
    // BaseService();
  }
late GraphQLClient _client;
  late ValueNotifier<GraphQLClient> _clientNotifier;

  final bool _renewingToken = false;

  GraphQLClient get client => _client;

  ValueNotifier<GraphQLClient> get clientNotifier => _clientNotifier;

  // BaseService() {
  //   // final authLink = AuthLink(getToken: _getToken);
  //   final httpLink = HttpLink("https://test.lechoix.com/graphql");

  //   /// The order of the links in the array matters!
  //   /// authLink, 
  //   final link = Link.from([ httpLink]);

  //   _client = GraphQLClient(
  //     link: link,
  //     cache: GraphQLCache(),
  //     // 
  //     // You have two other caching options. 
  //     // But for my example I won't be using caching.
  //     //
  //     // cache: GraphQLCache(store: HiveStore()),
  //     // cache: GraphQLCache(store: InMemoryStore()),
  //     //
  //     defaultPolicies: DefaultPolicies(query: Policies(fetch: FetchPolicy.networkOnly)),
  //   );

  //   _clientNotifier = ValueNotifier(_client);
  // }
  void dispose() {
    cancelToken.cancel();
  }
}
