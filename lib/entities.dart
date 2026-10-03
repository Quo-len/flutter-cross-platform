class Author {
  final String name;
  final String avatarUrl;
  final String role;

  Author({required this.name, required this.avatarUrl, required this.role});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      "name": this.name,
      "avatarUrl": this.avatarUrl,
      "role": this.role,
    };
    return data;
  }
}

class Post {
  final int id;
  final String title;
  final String body;
  final Author author;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.author,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      author: Author.fromJson(json['author'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      "author": this.author.toJson(),
      "id": this.id,
      "title": this.title,
      "body": this.body,
    };
    return data;
  }
}

class GitTreeItem {
  final String path;
  final String mode;
  final String type;
  final String sha;
  final String url;
  final int? size;

  GitTreeItem({
    required this.path,
    required this.mode,
    required this.type,
    required this.sha,
    required this.url,
    this.size,
  });

  factory GitTreeItem.fromJson(Map<String, dynamic> json) {
    return GitTreeItem(
      path: json['path'] as String,
      mode: json['mode'] as String,
      type: json['type'] as String,
      sha: json['sha'] as String,
      url: json['url'] as String,
      size: json['size'] as int?,
    );
  }

  bool get isDirectory => type == 'tree';
}

class GitTreeResponse {
  final String sha;
  final String url;
  final List<GitTreeItem> tree;

  GitTreeResponse({required this.sha, required this.url, required this.tree});

  factory GitTreeResponse.fromJson(Map<String, dynamic> json) {
    var rawList = json['tree'] as List<dynamic>? ?? [];
    List<GitTreeItem> items = rawList
        .map((item) => GitTreeItem.fromJson(item as Map<String, dynamic>))
        .toList();

    return GitTreeResponse(
      sha: json['sha'] as String,
      url: json['url'] as String,
      tree: items,
    );
  }
}
