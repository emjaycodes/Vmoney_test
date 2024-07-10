import 'package:blog_app_test/helper/helper_functions.dart';
import 'package:blog_app_test/provider/blog_provider.dart';
import 'package:blog_app_test/screens/blog_details.dart';
import 'package:blog_app_test/screens/blog_edit_screen.dart';
import 'package:blog_app_test/widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<BlogProvider>(builder: (context, data, child) {
                final blogs =
                    Provider.of<BlogProvider>(context, listen: false).blogList;
                if (blogs.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "You don't have any Blog post",
                          textAlign: TextAlign.center,
                          // style: primaryTextStyle(),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  reverse: true,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: blogs.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final blog = blogs[index];
                    String firstCharacter = blog.id.isNotEmpty ? blog.id[1] : '';

                    return BlogPostCard(
                      blogPost: blog,
                      readTime: '$firstCharacter min read',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BlogDetailScreen(blog: blog, index: index ),
                          ),
                        );
                      },
                      deleteFunction: (ctx) {
                        Provider.of<BlogProvider>(context, listen: false)
                            .deleteBlog(id: blog.id);
                        Provider.of<BlogProvider>(context, listen: false)
                            .fetchBlogs();
                      },
                      editFunction: (ctx) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BlogEditScreen(blog: blog),
                          ),
                          
                        );
                      }, imageUrl:  HelperFunctions.getRandomImageUrl(index),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BlogEditScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
     