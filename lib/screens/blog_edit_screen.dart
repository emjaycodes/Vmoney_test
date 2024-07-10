import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../models/blog_post_model.dart';
import '../provider/blog_provider.dart';

class BlogEditScreen extends StatefulWidget {
  final BlogPost? blog;

  const BlogEditScreen({Key? key, this.blog}) : super(key: key);

  @override
  _BlogEditScreenState createState() => _BlogEditScreenState();
}

class _BlogEditScreenState extends State<BlogEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _bodyController;
  late TextEditingController _subtitleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.blog?.title ?? '');
    _bodyController = TextEditingController(text: widget.blog?.body ?? '');
    _subtitleController =
        TextEditingController(text: widget.blog?.subTitle ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final blogProvider = Provider.of<BlogProvider>(context, listen: false);
      final id = widget.blog?.id.toString();
      final title = _titleController.text;
      final body = _bodyController.text;
      final subtitle = _subtitleController.text;

      if (widget.blog == null) {
        // Create new blog post
        // final newBlog = BlogPost(
        //   id: DateTime.now().toString(), // generate a new id or use a proper method
        //   title: title,
        //   body: body,
        //   subTitle: subtitle, dateCreated: DateTime.now().toString()
        // );
        blogProvider.addBlog(title: title, subTitle: subtitle, body: body) .then((value) {
          Provider.of<BlogProvider>(context, listen: false).fetchBlogs();
          Navigator.pop(context);
        });
      } else {
        // Update existing blog post
        // final updatedBlog = widget.blog!.copyWith(
        //   title: title,
        //   body: body,
        //   subtitle: subtitle,
        // );
        blogProvider
            .updateBlog(
                blogId: id!, title: title, subTitle: subtitle, body: body)
            .then((value) {
          Provider.of<BlogProvider>(context, listen: false).fetchBlogs();
          Navigator.pop(context);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.blog != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Blog Post' : 'Create Blog Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: 550.h,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _subtitleController,
                    decoration: const InputDecoration(labelText: 'Subtitle'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a subtitle';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _bodyController,
                    decoration: const InputDecoration(labelText: 'Body'),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a body';
                      }
                      return null;
                    },
                  ),
                  Spacer(),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(isEditing ? 'Update' : 'Create'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
