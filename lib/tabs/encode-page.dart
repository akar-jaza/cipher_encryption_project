import 'package:cipher_encryption/components/footer.dart';
import 'package:cipher_encryption/components/input-fileds.dart';
import 'package:cipher_encryption/model/cipher_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            const SizedBox(height: 30),
            inputField(
              controller: getAlphabetController,
              icon: Icons.abc,
              labelText: 'Alphabet',
              showAlphabet: true,
            ),
            const SizedBox(height: 30),
            inputField(
              controller: getShiftController,
              icon: Icons.swap_vert,
              labelText: 'Shift',
              inputTypeIsNumber: true,
            ),
            const SizedBox(height: 30),
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
                    child: const Text(
                      "Encode",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            footer()
          ],
        ),
      ),
    );
  }

  void encodeText(BuildContext context) {
    CipherHandler cipherHandler = CipherHandler(
      text: getPlainTextController.text,
      alphabet: getAlphabetController.text,
      shift: getShiftController.text,
      isEncode: true,
    );
    return setState(() {
      encodeResult = cipherHandler.implementCipher();
      _showModalBottomSheet(context, cipherResult: encodeResult);
    });
  }
}

void _showModalBottomSheet(BuildContext context,
    {required String cipherResult}) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
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
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          cipherResult,
                          style: TextStyle(
                            fontSize: 50,
                            color: ColorScheme.fromSeed(seedColor: Colors.blue)
                                .primary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        IconButton(
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: cipherResult));
                          },
                          icon: const Icon(Icons.copy),
                          iconSize: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
