import 'entities.dart';

final List<FeedItem> mockFeed = [
  Announcement(
    id: 101,
    title: 'Flutter Lab Update',
    message: 'This feed combines Post and Announcement models via a sealed class.',
    date: '2026-11-27',
  ),
  Post(
    id: 1,
    title: 'Everything is a Widget',
    body: 'In Flutter, UI is built entirely by composing widgets in a tree hierarchy.',
    author: Author(
      name: 'Eric Seidel',
      avatarUrl: 'https://ui-avatars.com/api/?name=Eric+Seidel',
      role: 'Flutter Co-founder',
    ),
  ),
  Post(
    id: 2,
    title: 'Stateful Hot Reload',
    body: 'Make code changes and see results instantly without losing the app state.',
    author: Author(
      name: 'Tim Sneath',
      avatarUrl: 'https://ui-avatars.com/api/?name=Tim+Sneath',
      role: 'Product Lead',
    ),
  ),
  Announcement(
    id: 102,
    title: 'Tip: Pattern Matching',
    message: 'Dart 3 switch expressions ensure every FeedItem subtype is handled.',
    date: '2026-11-26',
  ),
  Post(
    id: 3,
    title: 'State Management',
    body: 'Manage app state efficiently with tools like Provider, Riverpod, or BLoC.',
    author: Author(
      name: 'Remi Rousselet',
      avatarUrl: 'https://ui-avatars.com/api/?name=Remi+Rousselet',
      role: 'GDE Flutter',
    ),
  ),
  Post(
    id: 4,
    title: 'Single Codebase',
    body: 'Compile to native machine code for iOS, Android, Web, Windows, macOS, and Linux.',
    author: Author(
      name: 'Filip Hracek',
      avatarUrl: 'https://ui-avatars.com/api/?name=Filip+Hracek',
      role: 'Dev Advocate',
    ),
  ),
];
