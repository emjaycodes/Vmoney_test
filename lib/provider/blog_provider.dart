import 'package:blog_app_test/grahpql/graphql_client.dart';
import 'package:blog_app_test/grahpql/mutations.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/blog_post_model.dart';

class BlogProvider extends ChangeNotifier {
  final GraphqlService graphqlService = GraphqlService();
  GraphQLClient client = GraphqlService.clientQuery();

  List<BlogPost> _blogList = [];
  List<BlogPost> _filteredBlogList = [];
  List<BlogPost> _bookmarkedBlogPosts = [];




  BlogProvider();

  List<BlogPost> get blogList => _blogList;
  List<BlogPost> get filteredBlogList => _filteredBlogList;
  List<BlogPost> get bookmarkedBlogPosts => _bookmarkedBlogPosts;

  // Fetch all blogs
  Future<List<BlogPost>> fetchBlogs() async {
    const String query = """
      query fetchAllBlogs {
        allBlogPosts {
          id
          title
          subTitle
          body
          dateCreated
        }
      }
    """;

    try {
      final QueryOptions options =
          QueryOptions(document: gql(query), fetchPolicy: FetchPolicy.noCache);

      final QueryResult result = await client.query(options);

      if (result.hasException) {
        notifyListeners();
        throw Exception(result.exception!);
      }

      List? res = result.data?['allBlogPosts'];

      if (res == null || res.isEmpty) {
        print('whatsupppp');
        return [];
      }

      List<BlogPost> posts =
          res.map((posts) => BlogPost.fromJson(posts)).toList();
      notifyListeners();
      _blogList = posts;
      // print("blogs" + _blogList[0].title);
      _filteredBlogList = List.from(_blogList);
      return blogList;
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  // Add a new blog
  Future<bool> addBlog(
      {required String title,
      required String subTitle,
      required String body}) async {
    print('add blog');
    const String mutation = createBlogPost;
    try {
      final MutationOptions options = MutationOptions(
        document: gql(mutation),
        variables: {
          "title": title,
          "subTitle": subTitle,
          "body": body,
        },
        fetchPolicy: FetchPolicy.noCache,
      );

      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        notifyListeners();
        throw Exception(result.exception);
      } else {
        notifyListeners();
        return true;
      }
    } catch (e) {
      print(e.toString());
      if (e is GraphQLError) {
        print(e.message.toString());
      } else {
        print("Something went wrong ");
      }
      return false;
    }
  }

  // Update an existing blog
  Future<void> updateBlog(
      {required String blogId,
      required String title,
      required String subTitle,
      required String body}) async {
    const String mutation = updateBlogPost;

    try {
      final MutationOptions options = MutationOptions(
        document: gql(mutation),
        variables: {
          'blogId': blogId,
          'title': title,
          'subTitle': subTitle,
          'body': body,
        },
        fetchPolicy: FetchPolicy.noCache,
      );

      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        notifyListeners();
        throw result.exception!;
      }
      print("Success");
      notifyListeners();
    } catch (e) {
      if (e is GraphQLError) {
        print(e.message.toString());
      } else {
        print("Something went wrong ");
      }
      print(e.toString());
    }
  }

  // Delete a blog
  Future<bool> deleteBlog({required String id}) async {
    const String mutation = deleteBlogPost;

    try {
      final MutationOptions options = MutationOptions(
        document: gql(mutation),
        variables: {
          'blogId': id,
        },
      );

      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        notifyListeners();
        throw Exception(result.exception!);
      } else {
        notifyListeners();
        return true;
      }

      // _blogList.removeWhere((blog) => blog.id == int.parse(id));
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
   // Search functionality
  void searchBlogs(String query) {
    if (query.isEmpty) {
      _filteredBlogList = List.from(_blogList);
    } else {
      _filteredBlogList = _blogList
          .where((blog) =>
              blog.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }


  // Bookmark functionality
  void toggleBookmark(BlogPost blogPost) {
    if (_bookmarkedBlogPosts.contains(blogPost)) {
      _bookmarkedBlogPosts.remove(blogPost);
    } else {
      _bookmarkedBlogPosts.add(blogPost);
    }
    notifyListeners();
  }



  
}
