import '/responsive.dart';
import '/core/viewModel/messageViewModel.dart';
import '/model/userModel.dart';
import '/../../../../widgets/customText.dart';
import '/../../../../widgets/customTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LowerBodyView extends StatefulWidget {
  final UserModel notMe;
  final UserModel me;
  LowerBodyView({required this.notMe, required this.me});

  @override
  State<LowerBodyView> createState() => _LowerBodyViewState();
}

class _LowerBodyViewState extends State<LowerBodyView> {
  TextEditingController _textController = new TextEditingController();
  @override
  void initState() {
    super.initState();

    _textController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Chats')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          List<DocumentSnapshot> messageSnap =
              snapshot.hasData ? (snapshot.data as QuerySnapshot).docs : [];
          List messages = messageSnap
              .where((element) => ((element['from'] == widget.me.id ||
                      element['to'] == widget.me.id) &&
                  (element['from'] == widget.notMe.id ||
                      element['to'] == widget.notMe.id)))
              .toList();
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                  reverse: true,
                  controller: ScrollController(),
                  itemCount: messages.length,
                  itemBuilder: (context, i) => Column(
                    crossAxisAlignment: messages[i]['from'] == widget.me.id
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      messages[i]['message'] != null
                          ? Container(
                              constraints: BoxConstraints(
                                minWidth: 40,
                                maxWidth: Responsive.isDesktop(context)
                                    ? (size.width - 350) * 0.5
                                    : size.width * 0.5,
                              ),
                              child: Card(
                                color: messages[i]['from'] == widget.me.id
                                    ? Colors.blue
                                    : Colors.black38,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                        bottomRight:
                                            messages[i]['from'] == widget.me.id
                                                ? Radius.circular(15)
                                                : Radius.zero,
                                        bottomLeft:
                                            messages[i]['to'] == widget.me.id
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
                            )
                          : Padding(padding: EdgeInsets.zero),
                      messages[i]['pic'] != null
                          ? Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Image.network(
                                messages[i]['pic'],
                                width: 80,
                                height: 80,
                              ),
                            )
                          : Padding(padding: EdgeInsets.zero),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      bodyColor: Colors.grey[200] as Color,
                      txtEditingController: _textController,
                      onChanged: (val) {
                        _textController.text = val;
                        _textController.value = TextEditingValue(
                            text: val,
                            selection: TextSelection(
                                baseOffset: val.length,
                                extentOffset: val.length));
                      },
                      valid: null,
                      hintTxt: 'Type your message',
                      icon: null,
                      shapeIsCircular: true,
                    ),
                  ),
                  GetBuilder<MessageViewModel>(
                    builder: (messageController) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: GestureDetector(
                          onTap: () {
                            if (_textController.text.isNotEmpty) {
                              widget.notMe.role == 'Customer'
                                  ? messageController.uploadMessage(
                                      createdAt: Timestamp.now(),
                                      vendorId: widget.me.id as String,
                                      customerId: widget.notMe.id as String,
                                      from: widget.me.id as String,
                                      to: widget.notMe.id as String,
                                      message: _textController.text,
                                      orderNumber:
                                          messageController.orderNumber == null
                                              ? messageSnap.first['orderNumber']
                                              : messageController.orderNumber,
                                    )
                                  : messageController.uploadMessage(
                                      createdAt: Timestamp.now(),
                                      vendorId: '',
                                      customerId: '',
                                      from: widget.me.id as String,
                                      to: widget.notMe.id as String,
                                      message: _textController.text,
                                    );
                              _textController.text = '';
                            }
                          },
                          child: Icon(
                            Icons.send,
                            color: _textController.text.isNotEmpty
                                ? Colors.blue[800]
                                : null,
                          )),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
            ],
          );
        });
  }
}
