const String fetchAllBlogs = """
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

const String getBlog = """
query getBlog(\$blogId: String!) {
  blogPost(blogId: \$blogId) {
    id
    title
    subTitle
    body
    dateCreated
  }
}
""";
