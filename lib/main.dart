import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share_plusのサンプル'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            shareButton(
              'テキストシェア',
              () {
                Share.share(
                  'テキストシェア',
                  subject: 'subject',
                );
              },
            ),
            shareButton(
              'テキストシェア(リンク付き)',
              () {
                Share.share(
                  'テキストシェア(リンク付き)\nhttps://pentagon.tokyo/',
                  subject: 'subject',
                );
              },
            ),
            shareButton(
              '単独画像シェア',
              () async {
                //画像のパス。今回はAssets内の画像を使用します
                const imagePath = 'assets/images/pentagon.png';

                //Assetsの画像を使用する際に必要となります
                final data = await rootBundle.load(imagePath);
                final buffer = data.buffer;
                final Uint8List uint8list =
                    buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

                //実際に共有します
                final xFile = XFile.fromData(
                  uint8list,
                  mimeType: 'image/png',
                );
                await Share.shareXFiles(
                  [xFile],
                  subject: 'subject',
                  text: 'text',
                );
              },
            ),
            shareButton(
              '複数画像シェア',
              () async {
                const imagePath = 'assets/images/pentagon.png';
                final data = await rootBundle.load(imagePath);
                final buffer = data.buffer;
                final xFile = XFile.fromData(
                  buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
                  name: 'flutter_logo.png',
                  mimeType: 'image/png',
                );
                await Share.shareXFiles(
                  [xFile, xFile, xFile],
                  subject: 'subject',
                  text: 'text',
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget shareButton(
    String text,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
