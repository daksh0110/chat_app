import 'package:chat_app/modal/phrase.dart';
import 'package:word_generator/word_generator.dart';

final wordGenerator = WordGenerator();
List<String> nouns = wordGenerator.randomNouns(16);

final List<Phrase> phrases = nouns.asMap().entries.map((entry) {
  final index = entry.key;
  final noun = entry.value;

  return Phrase(id: index, text: noun);
}).toList();
