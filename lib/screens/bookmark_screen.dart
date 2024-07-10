import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helper/helper_functions.dart';
import '../provider/blog_provider.dart';
import '../widgets/blog_card.dart';
import 'blog_details.dart';
import 'blog_edit_screen.dart';

class BookmarkedScreen extends StatelessWidget {
  const BookmarkedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookmarkedBlogs =
        Provider.of<BlogProvider>(context).bookmarkedBlogPosts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked Blogs'),
      ),
      body: ListView.builder(
        itemCount: bookmarkedBlogs.length,
        itemBuilder: (context, index) {
          final blog = bookmarkedBlogs[index];
          return BlogPostCard(
            blogPost: blog,
            readTime: '8 min read',
            imageUrl: HelperFunctions.getRandomImageUrl(index),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlogDetailScreen(
                    blog: blog,
                    index: index,
                  ),
                ),
              );
            },
            deleteFunction: (ctx) {
              Provider.of<BlogProvider>(context, listen: false)
                  .deleteBlog(id: blog.id);
              Provider.of<BlogProvider>(context, listen: false).fetchBlogs();
            },
            editFunction: (ctx) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlogEditScreen(blog: blog),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
