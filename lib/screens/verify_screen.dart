import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/primary_button.dart';
import 'package:chat_app/widgets/verify_screen/phrase_container.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key, required this.phrase});
  final String phrase;

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  List<String> selectedWords = [];

  void _onPhraseChanged(List<String> words) {
    setState(() {
      selectedWords = words;
    });
  }

  void _verifyPhrase() {
    final correctWords = widget.phrase.split(" ");

    if (selectedWords.length != correctWords.length) {
      _showError("Please complete the phrase");
      return;
    }

    final isCorrect = List.generate(
      correctWords.length,
      (i) => correctWords[i] == selectedWords[i],
    ).every((e) => e);

    if (isCorrect) {
      Navigator.pushNamed(context, "/verify-success");
    } else {
      _showError("Incorrect phrase order. Try again.");
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom + 16.0;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(32, 32, 32, 8),
                  child: Column(
                    children: [
                      const AppText(
                        "Verify Key Phrase",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSmallColor,
                      ),
                      const SizedBox(height: 20),

                      PhraseContainer(onChanged: _onPhraseChanged),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(32, 8, 32, bottomPadding),
              child: PrimaryButton(text: "Verify", onClick: _verifyPhrase),
            ),
          ],
        ),
      ),
    );
  }
}
