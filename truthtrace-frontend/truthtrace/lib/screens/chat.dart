import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _messages = []; // List to store chat messages
  bool _showInputField = true;

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _messages.insert(0, text); // Insert new message at the beginning of the list
      _showInputField = false; // Hide input field after message submission
    });
<<<<<<< Updated upstream
=======

    _sendMessageToServer(text);
  }

  void _sendMessageToServer(String text) async {
    try {
      final response = await http.post(
        Uri.parse('https://truthtracebackend.onrender.com/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"user_input": text}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Extract accuracy percentage
        String output = responseData['output'];
        RegExp regex = RegExp(r'(\d+)%');
        Iterable<Match> matches = regex.allMatches(output);
        String accuracyPercentage = matches.isNotEmpty ? matches.first.group(1) ?? '0' : '0';

        // Format sources list
        List<String> sources = List.from(responseData['source']);
        String sourcesFormatted = sources.map((source) => '- $source').join('\n');

        // Split the output into multiple messages
        List<String> messages = output.split('\n\n').reversed.toList();

        setState(() {
          // Insert accuracy message
          if (accuracyPercentage == '0') {
            _messages.insert(0, {"message": 'The information provided may not be accurate. Kindly re-verify it yourself', "type": "truthTrace"});
          } else {
            _messages.insert(0, {"message": 'The information you\'ve provided seems to be $accuracyPercentage% accurate', "type": "truthTrace"});
          }
          // Insert summary messages from the server response in reversed order
          for (String message in messages) {
            _messages.insert(0, {"message": message.trim(), "type": "truthTrace"});
          }

          // Insert sources message
          _messages.insert(0, {"message": 'Sources:\n$sourcesFormatted', "type": "truthTrace"});

        });
      } else {
        throw Exception('Failed to load response');
      }
    } catch (e) {
      print('Error sending message: $e');
      // Handle error here
    }
>>>>>>> Stashed changes
  }


  void _handleCheckAnotherFact() {
    setState(() {
      _showInputField = true; // Show input field when "Check Another Fact" is pressed
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          centerTitle: true,
          title: const Text("truthTrace"),
          titleTextStyle: const TextStyle(fontFamily: 'PlayWrite', fontSize: 25),
        ),
        body: Column(
          children: <Widget>[
            // Widget to display chat messages
            Flexible(
              child: ListView.builder(
                reverse: true, // To start list from the bottom
                itemCount: _messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildMessage(_messages[index]);
                },
              ),
            ),
            // Divider between message list and input field
            const Divider(height: 1.0),
            // Conditional rendering of input field and "Check Another Fact" button
            _showInputField ? _buildTextComposer() : _buildCheckAnotherFactButton(),
          ],
        ),
      ),
    );
  }

<<<<<<< Updated upstream
  Widget _buildMessage(String text) {
    return ListTile(
      title: Text(text),
    );
=======
  Widget _buildMessage(Map<String, dynamic> messageData) {
    String type = messageData['type'];
    String message = messageData['message'];

    if (type == 'Me') {
      return ListTile(
        title: Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const Icon(Icons.person),
        dense: true,
      );
    } else if (type == 'truthTrace') {
      return ListTile(
        title: Text(message),
        trailing: const Icon(Icons.computer),
        dense: true,
      );
    } else {
      return const SizedBox.shrink(); // Return empty widget if type is unknown
    }
>>>>>>> Stashed changes
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).primaryColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckAnotherFactButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ElevatedButton(
        onPressed: _handleCheckAnotherFact,
        //style: ,
        child: const Text('Check Another Fact'),
      ),
    );
  }
}
