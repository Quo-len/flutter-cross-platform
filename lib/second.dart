import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'entities.dart';

import 'fetch_data.dart';

class MySecondApp extends StatefulWidget {
  const MySecondApp({super.key});

  @override
  State<MySecondApp> createState() => _MySecondAppState();
}

class _MySecondAppState extends State<MySecondApp> {
  late Future<List<GitTreeItem>> _treeFuture;
  @override
  void initState() {
    super.initState();
    _treeFuture = fetchRepoTree(
      'https://api.github.com/repos/Quo-len/flutter-cross-platform/git/trees/main?recursive=1',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: FutureBuilder<List<GitTreeItem>>(
                future: _treeFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Помилка: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Файлів не знайдено'));
                  }
                  final items = snapshot.data!;
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      if (item.isDirectory) {
                        return ListTile(
                          leading: const Icon(
                            Icons.folder,
                            color: Colors.amber,
                          ),
                          title: Text(item.path),
                          subtitle: Text(
                            'Папка | SHA: ${item.sha.substring(0, 7)}',
                          ),
                        );
                      }
                      return FileExpansionTile(item: item);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FileExpansionTile extends StatefulWidget {
  final GitTreeItem item;

  const FileExpansionTile({super.key, required this.item});

  @override
  State<FileExpansionTile> createState() => _FileExpansionTileState();
}

class _FileExpansionTileState extends State<FileExpansionTile> {
  Future<String>? _contentFuture;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.insert_drive_file, color: Colors.blueGrey),
      title: Text(widget.item.path),
      subtitle: Text(
        'Файл | SHA: ${widget.item.sha.substring(0, 7)}',
      ),
      onExpansionChanged: (isExpanded) {
        if (isExpanded && _contentFuture == null) {
          setState(() {
            _contentFuture = http.read(
              Uri.parse(
                'https://raw.githubusercontent.com/Quo-len/flutter-cross-platform/main/${widget.item.path}',
              ),
            );
          });
        }
      },
      children: [
        if (_contentFuture != null)
          FutureBuilder<String>(
            future: _contentFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.all(12),
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text('Помилка завантаження: ${snapshot.error}'),
                );
              }
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SelectableText(
                  snapshot.data ?? 'Порожній файл',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
