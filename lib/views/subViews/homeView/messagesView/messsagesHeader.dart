import '../../../../widgets/customText.dart';
import '../../../../widgets/customTextField.dart';
import 'package:flutter/material.dart';

class MessagesHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: CustomTextField(
                  bodyColor: Colors.grey[200],
                  onChanged: null,
                  valid: null,
                  hintTxt: 'Search Messanger',
                  icon: null,
                  prefix: Icon(Icons.search),
                  shapeIsCircular: true,
                ),
              ),
              SizedBox(width: 10),
              CircleAvatar(child: Icon(Icons.post_add))
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              controller: ScrollController(),
              itemCount: 9,
              itemBuilder: (context, i) {
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  horizontalTitleGap: 8,
                  leading: CircleAvatar(
                    radius: 30,
                  ),
                  title: CustomText(
                    txt: 'Meshrif',
                  ),
                  subtitle: CustomText(
                    txt: 'Hi',
                    txtColor: Colors.grey,
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomText(
                        txt: '2021',
                        fSize: 17,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: CircleAvatar(
                          radius: 6,
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
