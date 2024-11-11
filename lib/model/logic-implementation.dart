class CipherHandler {
  static String cipherLogic({
    required String text,
    required String alphabet,
    required String shift,
  }) {
    int castShift = int.tryParse(shift) ?? 0;

    List<String> shiftedLetters = [];
    for (var i = 0; i < text.length; i++) {
      String currentChar = text[i];

      // Check if the character is in the alphabet (ignores spaces and punctuation)
      if (alphabet.contains(currentChar)) {
        int originalIndex =
            alphabet.indexOf(currentChar); // current char = "a", index = 0
        int shiftedIndex =
            (originalIndex + castShift) % alphabet.length; // 0 + -5 = -5

        // Handle negative shifts by adjusting the index to be positive
        if (shiftedIndex < 0) {
          shiftedIndex +=
              alphabet.length; // -5 + 26 = 21, the 21 is the index of "v"
        }

        shiftedLetters.add(alphabet[shiftedIndex]); // shiftedLetters = [v]
      } else {
        // If character is not in alphabet, add it as-is (e.g., spaces)
        shiftedLetters.add(currentChar); // shiftedLetters = [v, " "]
      }
    }

    // Combine the shifted letters into the final encoded string
    return shiftedLetters.join();
  }
}
