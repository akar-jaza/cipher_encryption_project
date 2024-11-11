// ignore_for_file: prefer_const_constructors

import 'package:cipher_encryption/components/footer.dart';
import 'package:cipher_encryption/components/input-fileds.dart';
import 'package:flutter/material.dart';

class DecodePage extends StatefulWidget {
  const DecodePage({super.key});

  @override
  State<DecodePage> createState() => _DecodePageState();
}

class _DecodePageState extends State<DecodePage> {
  final TextEditingController getPlainTextController = TextEditingController();
  final TextEditingController getAlphabetController = TextEditingController();
  final TextEditingController getShiftController = TextEditingController();
  String cipherResult = '';

  @override
  Widget build(BuildContext context) {
    void dispose() {
      getPlainTextController.dispose();
      getAlphabetController.dispose();
      getShiftController.dispose();
      super.dispose();
    }

    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            inputField(
              controller: getPlainTextController,
              icon: Icons.question_mark,
              labelText: 'Cipher Text',
            ),
            SizedBox(height: 30),
            inputField(
                controller: getAlphabetController,
                icon: Icons.abc,
                labelText: 'Alphabet',
                showAlphabet: true),
            SizedBox(height: 30),
            inputField(
              controller: getShiftController,
              icon: Icons.swap_vert,
              labelText: 'Shift',
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      encodeText(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        ColorScheme.fromSeed(seedColor: Colors.blue).primary,
                      ),
                      foregroundColor: WidgetStateProperty.all(
                        ColorScheme.fromSeed(seedColor: Colors.blue).onPrimary,
                      ),
                    ),
                    child: Text(
                      "Decode",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            footer()
          ],
        ),
      ),
    );
  }

  void encodeText(BuildContext context) {
    return setState(() {
      cipherResult = decodCipherLogic(
        encodedText: getPlainTextController.text,
        alphabet: getAlphabetController.text,
        shift: getShiftController.text,
      );
      _showModalBottomSheet(context, result: cipherResult);
    });
  }

  String decodCipherLogic({
    required String encodedText,
    required String alphabet,
    required String shift,
  }) {
    int castShift = int.tryParse(shift) ?? 0;

    List<String> shiftedLetters = [];
    for (var i = 0; i < encodedText.length; i++) {
      int shiftedIndex =
          ((alphabet.indexOf(encodedText[i]) - castShift) % alphabet.length);
      shiftedLetters.add(alphabet[shiftedIndex]);
    }
    return cipherResult = shiftedLetters.join();
  }
}

void _showModalBottomSheet(BuildContext context, {required String result}) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  'Decoded Text',
                  style: TextStyle(
                    fontSize: 25,
                    color: ColorScheme.fromSeed(seedColor: Colors.blue)
                        .onPrimaryContainer,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        result,
                        style: TextStyle(
                          fontSize: 50,
                          color: ColorScheme.fromSeed(seedColor: Colors.blue)
                              .primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
