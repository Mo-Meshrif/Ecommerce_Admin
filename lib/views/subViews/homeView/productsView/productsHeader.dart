import '/const.dart';
import '/widgets/customElevatedButton.dart';
import '/widgets/customPopupMenu.dart';
import '/widgets/customText.dart';
import '/widgets/customTextField.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ProductsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, List<String>> sizes = {
      'clothes': ['S', 'M', 'L', 'XL'],
      'shoes': ['4.5', '5', '6.5', '7']
    };
    return SingleChildScrollView(
      controller: ScrollController(),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CustomText(
              txt: 'Add New Product',
              fSize: 18,
            ),
          ),
          SizedBox(height: 15),
          Center(
            child: DottedBorder(
              padding: EdgeInsets.all(15),
              borderType: BorderType.Circle,
              color: Colors.grey[350],
              strokeWidth: 1,
              child: Icon(
                Icons.upload,
                size: 40,
              ),
            ),
          ),
          SizedBox(height: 15),
          CustomText(txt: 'Category Name'),
          SizedBox(height: 10),
          CustomPopupMenu(
            title: 'Select Category',
            items: [],
          ),
          SizedBox(height: 15),
          CustomText(
            txt: 'Sub-Category Name',
          ),
          SizedBox(height: 10),
          CustomPopupMenu(
            title: 'Select Sub-Category',
            items: [],
          ),
          SizedBox(height: 15),
          CustomText(txt: 'Product Season'),
          SizedBox(height: 10),
          CustomPopupMenu(
            title: 'Select Product Season',
            items: ['Summer', 'Winter'],
          ),
          SizedBox(height: 15),
          CustomText(txt: 'Product Name'),
          SizedBox(height: 10),
          CustomTextField(
              height: 25,
              shapeIsCircular: true,
              bodyColor: Colors.grey[350],
              onChanged: null,
              valid: null,
              hintTxt: 'Enter Product Name',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
              icon: null),
          SizedBox(height: 15),
          CustomText(txt: 'Trending ?!'),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: () => null, child: CustomText(txt: 'Yes')),
              TextButton(onPressed: () => null, child: CustomText(txt: 'No'))
            ],
          ),
          SizedBox(height: 15),
          CustomText(txt: 'Select Color(s)'),
          SizedBox(height: 10),
          LimitedBox(
            maxHeight: 100,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 50,
              ),
              itemCount: 6,
              itemBuilder: (ctx, i) => i != 5
                  ? ChoiceChip(
                      label: CircleAvatar(
                          backgroundColor: priColor,
                          radius: 15,
                          child: CircleAvatar(
                              backgroundColor: Colors.red, radius: 12)),
                      selectedColor: swatchColor,
                      disabledColor: swatchColor,
                      selected: true,
                      onSelected: (selected) => null,
                    )
                  : Icon(Icons.add),
            ),
          ),
          SizedBox(height: 15),
          CustomText(txt: 'Brand Name'),
          SizedBox(height: 10),
          CustomTextField(
              height: 25,
              shapeIsCircular: true,
              bodyColor: Colors.grey[350],
              onChanged: null,
              valid: null,
              hintTxt: 'Enter Brand Name',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
              icon: null),
          SizedBox(height: 15),
          CustomText(txt: 'Material Type'),
          SizedBox(height: 10),
          CustomTextField(
              height: 25,
              shapeIsCircular: true,
              bodyColor: Colors.grey[350],
              onChanged: null,
              valid: null,
              hintTxt: 'Enter Material Type',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
              icon: null),
          SizedBox(height: 15),
          CustomText(txt: 'Product Condition'),
          SizedBox(height: 10),
          CustomTextField(
              height: 25,
              shapeIsCircular: true,
              bodyColor: Colors.grey[350],
              onChanged: null,
              valid: null,
              hintTxt: 'Enter Product Condition',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
              icon: null),
          SizedBox(height: 15),
          CustomText(txt: 'Product Sku'),
          SizedBox(height: 10),
          CustomTextField(
              height: 25,
              shapeIsCircular: true,
              bodyColor: Colors.grey[350],
              onChanged: null,
              valid: null,
              hintTxt: 'Enter Product Sku',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
              icon: null),
          SizedBox(height: 15),
          CustomText(txt: 'Product Price (\$)'),
          SizedBox(height: 10),
          CustomTextField(
              height: 25,
              shapeIsCircular: true,
              bodyColor: Colors.grey[350],
              onChanged: null,
              valid: null,
              hintTxt: 'Enter Product Price',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
              icon: null),
          SizedBox(height: 15),
          CustomText(txt: 'Select size(s)'),
          SizedBox(height: 10),
          LimitedBox(
            maxHeight: 100,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 50,
                ),
                itemCount: sizes['shoes'].length,
                itemBuilder: (ctx, i) => CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      title: CustomText(
                        txt: sizes['shoes'][i],
                      ),
                      value: false,
                      onChanged: (value) => null,
                    )),
          ),
          Divider(
            color: Colors.grey,
            thickness: 0.5,
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomElevatedButton(
                buttonColor: swatchColor,
                onpress: () => null,
                title: 'Discard',
              ),
              CustomElevatedButton(
                buttonColor: priColor,
                onpress: () => null,
                title: 'Add',
                titleColor: swatchColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}