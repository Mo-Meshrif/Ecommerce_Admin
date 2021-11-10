import '../../../../widgets/customText.dart';
import '../../../../widgets/customTextField.dart';
import 'package:flutter/material.dart';

class MessageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Map<String, String>> messages = [
      {'from': 'm', 'to': 'a', 'message': 'Hi'},
      {'from': 'a', 'to': 'm', 'message': 'Hi'},
    ];
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, i) => Column(
              crossAxisAlignment: messages[i]['from'] == 'm'
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Container(
                  constraints: BoxConstraints(
                    minWidth: 40,
                    maxWidth: (size.width - 350) * 0.5,
                  ),
                  child: Card(
                    color: messages[i]['from'] == 'm'
                        ? Colors.blue
                        : Colors.black38,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomRight: messages[i]['from'] == 'm'
                                ? Radius.circular(15)
                                : Radius.zero,
                            bottomLeft: messages[i]['from'] == 'a'
                                ? Radius.circular(15)
                                : Radius.zero)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        txt: messages[i]['message'],
                        maxLine: 20,
                        txtColor: Colors.white,
                        fSize: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                bodyColor: Colors.grey[200],
                onChanged: null,
                valid: null,
                hintTxt: 'Type your message',
                icon: null,
                suffix: Icon(Icons.emoji_emotions),
                shapeIsCircular: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Icon(Icons.send),
            )
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
