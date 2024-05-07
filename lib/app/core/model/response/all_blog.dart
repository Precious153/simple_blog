class AllBlogs {
  final List<AllBlogPost>? allBlogPosts;

  AllBlogs({
    this.allBlogPosts,
  });

  factory AllBlogs.fromJson(Map<String, dynamic> json) => AllBlogs(
    allBlogPosts: json["allBlogPosts"] == null ? [] : List<AllBlogPost>.from(json["allBlogPosts"]!.map((x) => AllBlogPost.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "allBlogPosts": allBlogPosts == null ? [] : List<dynamic>.from(allBlogPosts!.map((x) => x.toJson())),
  };
}

class AllBlogPost {
  final String? id;
  final String? title;
  final String? subTitle;
  final String? body;
  final DateTime? dateCreated;
  final bool? deleted;

  AllBlogPost({
    this.id,
    this.title,
    this.subTitle,
    this.body,
    this.dateCreated,
    this.deleted,
  });

  factory AllBlogPost.fromJson(Map<String, dynamic> json) => AllBlogPost(
    id: json["id"],
    title: json["title"],
    subTitle: json["subTitle"],
    body: json["body"],
    dateCreated: json["dateCreated"] == null ? null : DateTime.parse(json["dateCreated"]),
    deleted: json["deleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "subTitle": subTitle,
    "body": body,
    "dateCreated": dateCreated?.toIso8601String(),
    "deleted": deleted,
  };
}