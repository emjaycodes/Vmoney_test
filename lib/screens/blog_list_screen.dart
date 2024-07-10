
import 'package:blog_app_test/screens/bookmark_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../provider/blog_provider.dart';

import '../widgets/search_bar.dart';

import 'home_screen.dart';

class BlogListScreen extends StatefulWidget {
  const BlogListScreen({super.key});

  @override
  State<BlogListScreen> createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  @override
  void initState() {
    Provider.of<BlogProvider>(context, listen: false).fetchBlogs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Blog'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Blog', icon: Icon(Icons.article)),
              Tab(text: 'Bookmarks', icon: Icon(Icons.bookmark)),
            ],
          ),
        ),
        body: const Column(
          children: [
             SizedBox(
              height: 12,
            ),
            SearchBarWidget(),
            SizedBox(
              height: 6,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  HomeScreen(),
                  BookmarkedScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
