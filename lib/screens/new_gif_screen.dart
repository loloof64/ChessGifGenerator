import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewGifScreen extends StatelessWidget {
  const NewGifScreen({super.key});

  void _letUserEditGif() {}

  void _letUserChoosePgn() {}

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
