// ignore_for_file: prefer_const_constructors

import 'package:cipher_encryption/components/footer.dart';
import 'package:cipher_encryption/components/input-fileds.dart';
import 'package:flutter/material.dart';

class EncodePage extends StatefulWidget {
  const EncodePage({super.key});

  @override
  State<EncodePage> createState() => _EncodePageState();
}

class _EncodePageState extends State<EncodePage> {
  final TextEditingController getPlainTextController = TextEditingController();
  final TextEditingController getAlphabetController = TextEditingController();
  final TextEditingController getShiftController = TextEditingController();
  String encodeResult = '';

  @override
  void dispose() {
    getPlainTextController.dispose();
    getAlphabetController.dispose();
    getShiftController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            inputField(
              controller: getPlainTextController,
              icon: Icons.description,
              labelText: 'Plain Text',
              showAlphabet: false,
            ),
            SizedBox(height: 30),
            inputField(
              controller: getAlphabetController,
              icon: Icons.abc,
              labelText: 'Alphabet',
              showAlphabet: true,
            ),
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
                      "Encode",
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
      encodeResult = implementCipherLogic(
        plainText: getPlainTextController.text,
        alphabet: getAlphabetController.text,
        shift: getShiftController.text,
      );
      _showModalBottomSheet(context, cipherResult: encodeResult);
    });
  }

  String implementCipherLogic({
    required String plainText,
    required String alphabet,
    required String shift,
  }) {
    int castShift = int.tryParse(shift) ?? 0;

    List<String> shiftedLetters = [];
    for (var i = 0; i < plainText.length; i++) {
      int shiftedIndex =
          ((alphabet.indexOf(plainText[i]) + castShift) % alphabet.length);
      shiftedLetters.add(alphabet[shiftedIndex]);
    }
    return encodeResult = shiftedLetters.join();
  }
}

void _showModalBottomSheet(BuildContext context,
    {required String cipherResult}) {
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
                  'Encoded Text',
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
                        cipherResult,
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
