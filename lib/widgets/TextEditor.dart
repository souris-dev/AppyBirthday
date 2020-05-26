import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TextEditor extends StatefulWidget {
  TextEditor({Key key}) : super(key: key);

  @override
  TextEditorState createState() => TextEditorState();
}

class TextEditorState extends State<TextEditor> {
  final FocusNode seedTextFocusNode = FocusNode();
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    seedTextFocusNode.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        seedTextFocusNode.requestFocus();
      },
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: textController,
                  focusNode: seedTextFocusNode,
                  style: TextStyle(
                    fontFamily: 'ChelseaMarket',
                    fontSize: 18,
                    color: Color.fromRGBO(58, 0, 175, 1),
                    letterSpacing: 1.2,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Tap on this text to type',
                    hintStyle: TextStyle(
                      fontFamily: 'ChelseaMarket',
                      fontSize: 18,
                      color: Color.fromRGBO(233, 229, 242, 1),
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  cursorColor: Color.fromRGBO(233, 229, 242, 1),
                  maxLines: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
