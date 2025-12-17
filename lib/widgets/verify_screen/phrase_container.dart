import 'package:chat_app/data/phraseData.dart'; // provides `phrases` list of Phrase
import 'package:chat_app/modal/phrase.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/verify_screen/phrase_box.dart';
import 'package:flutter/material.dart';

class PhraseContainer extends StatefulWidget {
  const PhraseContainer({super.key, required this.onChanged});
  final void Function(List<String>) onChanged;
  @override
  State<PhraseContainer> createState() => _PhraseContainerState();
}

class _PhraseContainerState extends State<PhraseContainer> {
  late List<Phrase> availablePhrases;

  final List<Phrase> phrasesInTheBox = [];

  @override
  void initState() {
    super.initState();
    availablePhrases = List<Phrase>.from(phrases);
    availablePhrases.shuffle();
  }

  void _addToBox(Phrase p) {
    setState(() {
      availablePhrases.removeWhere((x) => x.id == p.id);
      phrasesInTheBox.add(p);
    });
    _notify();
  }

  void _removeFromBox(Phrase p) {
    setState(() {
      phrasesInTheBox.removeWhere((x) => x.id == p.id);
      availablePhrases.add(p);
    });
    _notify();
  }

  void _notify() {
    widget.onChanged(phrasesInTheBox.map((p) => p.text).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          "YOUR KEY PHRASE",
          color: AppColors.textSmallColor,
          fontSize: 12,
        ),
        const SizedBox(height: 5),
        Container(
          constraints: BoxConstraints(minHeight: 200),
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.inputBoxColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: phrasesInTheBox.isEmpty
                ? const Align(
                    alignment: Alignment.topLeft,
                    child: AppText(
                      "Tap words below to add them here",
                      color: AppColors.placeholderTextColor,
                    ),
                  )
                : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: phrasesInTheBox.asMap().entries.map((entry) {
                      final index = entry.key;
                      final phrase = entry.value;
                      return InkWell(
                        onTap: () => _removeFromBox(phrase),
                        child: PhraseBox(
                          phrase: phrase,
                          showNumber: true,
                          index: (index + 1).toString(),
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ),

        const SizedBox(height: 40),

        Center(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: availablePhrases.map((phrase) {
              return InkWell(
                onTap: () => _addToBox(phrase),
                child: PhraseBox(phrase: phrase),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
