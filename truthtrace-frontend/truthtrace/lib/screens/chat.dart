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

  Widget _buildMessage(String text) {
    return ListTile(
      title: Text(text),
    );
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
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: _handleCheckAnotherFact,
        child: const Text('Check Another Fact'),
      ),
    );
  }
}
