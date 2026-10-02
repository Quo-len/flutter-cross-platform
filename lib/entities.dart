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
