import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:innovers_exam/models/item_model.dart';
import 'package:innovers_exam/utils/colors.dart';
import 'package:innovers_exam/utils/data.dart';
import 'package:innovers_exam/utils/styles.dart';
import 'package:innovers_exam/widgets/button.dart';
import 'package:innovers_exam/widgets/custom_radio.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc() : super(HomepageInitial());
  int valType = 0;
  int valItem = 0;
  String text = '';
  List<ItemModel> listItemModel = [];
  @override
  Stream<HomepageState> mapEventToState(HomepageEvent event) async* {
    if (event is OnImagePickerEvent) {
      final pickedFile = await event.imagePicker
          .getImage(source: ImageSource.camera, imageQuality: 50);
      var _image = File(pickedFile!.path);
      yield ImagePickedState(image: _image);
    } else if (event is OpenBottomDialog) {
      var a = await showModalBottomSheet<String>(
        context: event.context,
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
                children: event.listType
                    .map((e) => CustomRadioListTile<int>(
                          groupValue: valType,
                          onChanged: (int? value) {
                            valType = value!;
                            text = e.text;
                            print("New value $text");
                            Navigator.of(context).pop(text);
                          },
                          title: Text(e.text),
                          value: e.value,
                        ))
                    .toList()),
          );
        },
      );

      yield GetItemState(item: a!);
    } else if (event is AddPackageItemsEvent) {
      var a = await showModalBottomSheet<String>(
        context: event.context,
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
                children: event.listType
                    .map((e) => CustomRadioListTile<int>(
                          groupValue: valItem,
                          onChanged: (int? value) {
                            valItem = value!;
                            text = e.text;
                            print("New value $text");
                            Navigator.of(context).pop(text);
                          },
                          title: Text(e.text),
                          value: e.value,
                        ))
                    .toList()),
          );
        },
      );

      yield GetPackageItemsState(item: a!);
    } else if (event is AddNewItemEvent) {
      listItemModel.add(event.itemModel);
      yield AddNewItemState(listItemModel: listItemModel);
    } else if (event is DeleteItemEvent) {
      showDialog(
          context: event.context,
          builder: (context) {
            return Center(
              child: Wrap(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: Corners.smBorder,
                      color: AppColors.white,
                    ),
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.report_problem),
                        Text("Delete item ?"),
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustumButton(
                                    onPressed: () {
                                      event.listItems.remove(event.itemModel);
                                      Navigator.of(context).pop();
                                    },
                                    buttonText: 'Yes'),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: CustumButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    buttonText: 'No'),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          });

      yield DeletedItemState(listItemModel: event.listItems);
    }
  }
}
