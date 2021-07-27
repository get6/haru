import 'package:flutter/material.dart';

class AboutDetail extends StatelessWidget {
  final VoidCallback onFlip;
  final String bgImage;
  final String myImage;
  final String myName;
  final String myFuture;
  final String myEmail;
  final String myWords;
  const AboutDetail({
    Key? key,
    required this.bgImage,
    required this.myImage,
    required this.myName,
    required this.myFuture,
    required this.myEmail,
    required this.myWords,
    required this.onFlip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const wordStyle = TextStyle(
      color: Colors.black54,
      fontSize: 14,
      letterSpacing: 0.2,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(bgImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: Container(
                  alignment: const Alignment(.0, 2.5),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(myImage),
                    radius: 60,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 70),
            Text(
              myName,
              style: const TextStyle(
                fontSize: 26,
                color: Colors.blueGrey,
                letterSpacing: 2,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Seoul, Korea",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black45,
                letterSpacing: 2,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              myFuture,
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.black45,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(width: 5),
            Text(
              myEmail,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black45,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 24.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(myWords, style: wordStyle),
                const Text('감사합니다.', style: wordStyle)
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: onFlip,
                    icon: const Icon(Icons.flip),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
