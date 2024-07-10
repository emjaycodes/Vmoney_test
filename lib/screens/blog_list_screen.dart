import 'package:blog_app_test/helper/helper_functions.dart';
import 'package:blog_app_test/screens/blog_details.dart';
import 'package:blog_app_test/screens/bookmark_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../models/blog_post_model.dart';
import '../provider/blog_provider.dart';
import '../widgets/blog_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/tab_view.dart';
import 'blog_edit_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
        body: Column(
          children: [
             SizedBox(
              height: 12,
            ),
            const SearchBarWidget(),
            SizedBox(
              height: 6,
            ),
            Expanded(
              child: const TabBarView(
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
