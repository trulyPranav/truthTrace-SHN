import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:truthtrace/screens/chat.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "truth-Trace\nFind-the-Truth",
              style: TextStyle(fontFamily: 'PlayWrite',
              fontSize: 32),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, PageTransition(child: Chat(), type: PageTransitionType.fade),
                );
              },
              child: Text('Hehe'),
            )
          ],
        ),
      ),
    );
  }
}