import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:truthtrace/screens/chat.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _serverConnected = false; // Flag to track server connection

  @override
  void initState() {
    super.initState();
    checkServerConnection();
  }

  Future<void> checkServerConnection() async {
    try {
      final response = await http.get(Uri.parse('https://truthtracebackend.onrender.com/'));

      if (response.statusCode == 405) {
        // Server is reachable
        setState(() {
          _serverConnected = true;
        });
        navigateToChatScreen();
      } else {
        // Server returned an error status code
        showServerNotConnectedDialog();
      }
    } catch (e) {
      // Error connecting to server
      showServerNotConnectedDialog();
    }
  }

  void showServerNotConnectedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Server Not Connected"),
        content: const Text("Please check your internet connection or try again later."),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void navigateToChatScreen() {
    if (_serverConnected) {
      Navigator.pushReplacement(
        context,
        PageTransition(type: PageTransitionType.bottomToTop, child:const Chat()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "truth-Trace\nFind-the-Truth",
              style: TextStyle(fontFamily: 'PlayWrite', fontSize: 32),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
