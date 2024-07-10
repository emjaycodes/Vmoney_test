import 'package:blog_app_test/models/blog_post_model.dart';
import 'package:blog_app_test/provider/blog_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BlogPostCard extends StatelessWidget {
  final String readTime;
  final String imageUrl;
  final BlogPost blogPost;
  final VoidCallback onTap;
  Function(BuildContext)? deleteFunction;
  Function(BuildContext)? editFunction;


  BlogPostCard(
      {super.key,
      required this.readTime,
      required this.imageUrl,
      required this.onTap,
      required this.blogPost,
      required this.deleteFunction,
      required this.editFunction

      });

  @override
  Widget build(BuildContext context) {
    String formatDate(String date) {
      DateTime parsedDate = DateTime.parse(date);
      DateFormat formatter = DateFormat('MMM d');
      return formatter.format(parsedDate);
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: onTap,
          child: Slidable(
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: deleteFunction,
                  icon: Icons.delete,
                  backgroundColor: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                SlidableAction(
                  onPressed: editFunction,
                  icon: Icons.edit,
                  backgroundColor: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.network(
                    imageUrl,
                    width:140,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                 SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        blogPost.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text('${formatDate(blogPost.dateCreated)} • $readTime'),
                    ],
                  ),
                ),
               IconButton(
                padding: EdgeInsets.zero,
                      icon: Icon(
                        Provider.of<BlogProvider>(context).bookmarkedBlogPosts.contains(blogPost)
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                      ),
                      onPressed: () {
                        Provider.of<BlogProvider>(context, listen: false).toggleBookmark(blogPost);
                      },
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
