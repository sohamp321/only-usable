import 'dart:convert';
import 'dart:io';

void main() async {
  final untranslatedFile = File('../../lib/l10n/untranslated.json');
  if (!await untranslatedFile.exists()) {
    print('No untranslated messages file found.');
    exit(0);
  }

  final untranslatedMessages = jsonDecode(await untranslatedFile.readAsString());
  if (untranslatedMessages.isEmpty) {
    print('No untranslated messages found.');
    exit(0);
  }

  print('Untranslated messages found:');
  untranslatedMessages.forEach((locale, messages) {
    print('$locale: ${messages.join(', ')}');
  });

  exit(1);
}
