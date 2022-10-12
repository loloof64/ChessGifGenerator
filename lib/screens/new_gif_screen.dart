import 'package:flutter/material.dart';

class NewGifScreen extends StatelessWidget {
  const NewGifScreen({super.key});

  void _letUserEditGif() {}

  void _letUserChoosePgn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New gif'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _letUserEditGif,
              child: const Text('Enter the moves on chess board'),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: _letUserChoosePgn,
              child: const Text('Create from PGN file'),
            )
          ],
        ),
      ),
    );
  }
}
