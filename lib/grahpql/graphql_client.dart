import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlService {
  static String baseUrl =  "https://uat-api.vmodel.app/graphql/";
  static HttpLink httpLink = HttpLink(GraphqlService.baseUrl);
  GraphqlService();



  static GraphQLClient clientQuery() =>  GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );


  static ValueNotifier<GraphQLClient> client = ValueNotifier(
    clientQuery()
  );

}
