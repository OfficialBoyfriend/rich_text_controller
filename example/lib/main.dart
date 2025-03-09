import 'package:flutter/material.dart';

import 'package:rich_text_controller/rich_text_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RichTextExample(),
    );
  }
}

class RichTextExample extends StatefulWidget {
  const RichTextExample({super.key});

  @override
  State<RichTextExample> createState() => _RichTextExampleState();
}

class _RichTextExampleState extends State<RichTextExample> {
  // Define your target matches
  final targetMatches = [
    MatchTargetItem(
      allowInlineMatching: true,
      deleteOnBack: true,
      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
      regex: RegExp(r'#[a-zA-Z0-9_]+'),
    ),
    MatchTargetItem(
      allowInlineMatching: true,
      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      regex: RegExp(r'@[a-zA-Z0-9_]+'),
      onTap: (match) => debugPrint('Tapped: $match'),
      onCursorAtEnd: (match) => debugPrint('Cursor at end of: $match'),
    ),
  ];

  final _textEditController = TextEditingController();

  @override
  void dispose() {
    _textEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RichTextController Example')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: RichTextController(
                targetMatches: targetMatches,
                onMatch: (matches) {
                  debugPrint('Matched: $matches');
                },
              ),
              onChanged: (value) {
                if (!value.endsWith('@')) return;
                debugPrint('Cursor at end of: @');
              },
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Start typing...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
