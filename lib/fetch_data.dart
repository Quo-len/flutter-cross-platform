import 'dart:convert';

import 'entities.dart';

import 'package:http/http.dart' as http;

Future<List<GitTreeItem>> fetchRepoTree(String repoUrl) async {
  final response = await http.get(
    Uri.parse(repoUrl),
    headers: {
      'Accept': 'application/vnd.github.v3+json',
      'User-Agent': 'FlutterApp',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final repoTree = GitTreeResponse.fromJson(data);
    return repoTree.tree;
  } else {
    throw Exception('Failed to load repo tree: ${response.statusCode}');
  }
}
