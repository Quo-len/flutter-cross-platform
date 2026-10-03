import 'package:flutter/material.dart';

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
                      return ListTile(
                        leading: Icon(
                          item.isDirectory
                              ? Icons.folder
                              : Icons.insert_drive_file,
                          color: item.isDirectory
                              ? Colors.amber
                              : Colors.blueGrey,
                        ),
                        title: Text(item.path),
                        subtitle: Text(
                          'Тип: ${item.type} | SHA: ${item.sha.substring(0, 7)}',
                        ),
                      );
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
