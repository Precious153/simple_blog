 import '../graphql_service.dart';

class HomeDatasource {
   final _service = GraphqlService();
   Future<dynamic> createBlog(
       {required String title,
         required String subtitle,
         required String body,
       }) async {
     const graphql = """mutation Mutation(\$body: String!, \$subTitle: String!, \$title: String!) {
  createBlog(body: \$body, subTitle: \$subTitle, title: \$title) {
    success
    blogPost {
      id
      title
      subTitle
      body
      dateCreated
      deleted
    }
  }
}
""";
     final variables = {
         "body": body,
         "subTitle": subtitle,
         "title": title,

     };
     try {
       final result =
       await _service.mutate(graphql: graphql, variables: variables);
       return result;
     } catch (e) {
       rethrow;
     }
   }
   Future<dynamic> updateBlog(
       {required String title,
         required String subtitle,
         required String body,
         required String bodyId,
       }) async {
     const graphql = """mutation UpdateBlog(\$blogId: String!, \$body: String, \$subTitle: String, \$title: String) {
  updateBlog(blogId: \$blogId, body: \$body, subTitle: \$subTitle, title: \$title) {
    success
    blogPost {
      id
      title
      subTitle
      body
      dateCreated
      deleted
    }
  }
}
""";
     final variables = {
       "body": body,
       "subTitle": subtitle,
       "title": title,
       "blogId": bodyId,
     };
     try {
       final result =
       await _service.mutate(graphql: graphql, variables: variables);
       return result;
     } catch (e) {
       rethrow;
     }
   }

   Future<dynamic> deleteBlog(
       {required String blogId,}) async {
     const graphql = """mutation DeleteAccount(\$blogId: String!) {
  deleteBlog(blogId: \$blogId) {
    success
  }
}
""";
     final variables = {
       "blogId": blogId,
     };
     try {
       final result =
       await _service.mutate(graphql: graphql, variables: variables);
       return result;
     } catch (e) {
       rethrow;
     }
   }
 }