import 'package:flutter_test/flutter_test.dart';
import 'package:corp_devices/common/extensions/extensions.dart';

void main() {
  test(
    'Normalize will remove diacritics from word',
    () {
      final diacriticsWord = 'žežuliška';
      final nonDiacriticsWord = 'zezuliska';
      expect(diacriticsWord.normalize(), nonDiacriticsWord);
    },
  );

  test(
    'Normalize will let the word be if not diacritics used',
    () {
      final diacriticsWord = 'car';
      final nonDiacriticsWord = 'car';
      expect(diacriticsWord.normalize(), nonDiacriticsWord);
    },
  );

  test(
    'Normalize will let the word be if special character used',
    () {
      final diacriticsWord = '@car';
      final nonDiacriticsWord = '@car';
      expect(diacriticsWord.normalize(), nonDiacriticsWord);
    },
  );
}
