import 'customText.dart';
import 'package:flutter/material.dart';

class DeleteAlert extends StatelessWidget {
  final bool isLoading;
  final String title, messageContent;
  final void Function() agree, notAgree;

  DeleteAlert({
    required this.isLoading,
    required this.title,
    required this.messageContent,
    required this.agree,
    required this.notAgree,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: CustomText(
        txt: title,
      ),
      content: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  txt: messageContent,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton.icon(
                      onPressed: agree,
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      label: CustomText(
                        txt: 'Yes',
                      ),
                    ),
                    TextButton.icon(
                      onPressed: notAgree,
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      label: CustomText(
                        txt: 'No',
                      ),
                    ),
                  ],
                )
              ],
            ),
      contentPadding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
    );
  }
}
