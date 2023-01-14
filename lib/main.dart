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
            ElevatedButton(
              child: const Text('テキストシェア'),
              onPressed: () {
                const defaultText = 'デフォルトテキスト';
                const url = 'https://pentagon.tokyo/';

                Share.share(
                  '$defaultText \n $url',
                  subject: 'subject',
                );
              },
            ),
            ElevatedButton(
              child: const Text('画像シェア'),
              onPressed: () async {
                //画像のパス。今回はAssets内の画像を使用します
                const imagePath = 'assets/images/pentagon.png';

                //画像のパスを元に、最終的にunit8list型の変数を作ります
                final ByteData data = await rootBundle.load(imagePath);
                final ByteBuffer buffer = data.buffer;
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
