class CipherHandler {
  final String text;
  final String alphabet;
  final String shift;
  final bool isEncode;

  CipherHandler({
    required this.text,
    required this.alphabet,
    required this.shift,
    required this.isEncode,
  });

  String implementCipher() {
    int castShift = int.tryParse(shift) ?? 0;
    List<String> shiftedLetters = [];

    for (var i = 0; i < text.length; i++) {
      String currentChar = text[i]; // o

      if (alphabet.contains(currentChar)) {
        int originalIndex = alphabet.indexOf(currentChar); // o = 14
        int shiftedIndex = isEncode
            ? (originalIndex + castShift) % alphabet.length
            : (originalIndex - castShift) %
                alphabet.length; // o(14) - (7) = h(7)

        if (shiftedIndex < 0) {
          shiftedIndex += alphabet.length;
        }

        shiftedLetters.add(alphabet[shiftedIndex]);
      } else {
        shiftedLetters.add(currentChar);
      }
    }

    return shiftedLetters.join();
  }
}


