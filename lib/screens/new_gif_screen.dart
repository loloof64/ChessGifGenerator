import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewGifScreen extends StatefulWidget {
  const NewGifScreen({super.key});

  @override
  State<NewGifScreen> createState() => _NewGifScreenState();
}

class _NewGifScreenState extends State<NewGifScreen> {
  Future<void> _letUserEditGif() async {
    await Navigator.of(context).pushNamed("/edition");
  }

  Future<void> _letUserChoosePgn() async {
    await Navigator.of(context).pushNamed("/edition");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.pages_new_gif_title,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _letUserEditGif,
              child: Text(
                AppLocalizations.of(context)!
                    .pages_new_gif_buttons_manual_creation,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: _letUserChoosePgn,
              child: Text(
                AppLocalizations.of(context)!
                    .pages_new_gif_buttons_creation_from_pgn,
              ),
            )
          ],
        ),
      ),
    );
  }
}
