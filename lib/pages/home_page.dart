import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:innovers_exam/utils/colors.dart';
import 'package:innovers_exam/utils/data.dart';
import 'package:innovers_exam/utils/styles.dart';
import 'package:innovers_exam/widgets/button.dart';
import 'package:innovers_exam/widgets/clicable_widgets.dart';
import 'package:innovers_exam/widgets/contact_list.dart';
import 'package:innovers_exam/widgets/custom_radio.dart';
import 'package:innovers_exam/widgets/icons/picer_icons.dart';
import 'package:innovers_exam/widgets/input.dart';
import 'package:innovers_exam/widgets/open_dialog_container.dart';
import 'package:innovers_exam/widgets/swiched_button.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey receiverInputGlobalKey = GlobalKey();
  GlobalKey descriptionInputGlobalKey = GlobalKey();

  final LayerLink layerLink = LayerLink();
  final FocusNode focusNode = FocusNode();
  final _formState = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _itemTitleController = TextEditingController();

  TextEditingController _itemDesController = TextEditingController();

  TextEditingController _fromController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  TextEditingController _receiversNameController = TextEditingController();

  TextEditingController _startDateController = TextEditingController();
  TextEditingController _dueToController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  OverlayEntry? overlayEntry;
  int val = 0;
  String _selectTranstationType = 'TranstationType';
  String _itemTitle = 'Item title';

  File? _image;
  ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        showOverlay(receiverInputGlobalKey);
      } else {
        print('hide');
        hideOverLay();
        _onSave();
      }
    });
    super.initState();
  }

  void hideOverLay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  showOverlay(GlobalKey globalKey) {
    final overlay = Overlay.of(context);
    final renderBox = globalKey.currentContext?.findRenderObject() as RenderBox;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        right: 24,
        child: CompositedTransformFollower(
          offset: Offset(0, renderBox.size.height - 10),
          link: layerLink,
          showWhenUnlinked: false,
          child: ContactList(
            onTap: (name) {
              _receiversNameController.text = name;
              print('hide');
              hideOverLay();
              focusNode.unfocus();
            },
            size: renderBox.size,
          ),
        ),
      ),
    );
    overlay?.insert(overlayEntry!);
  }

  dynamic _onSave() async {
    if (!_formState.currentState!.validate()) {
      return;
    }
    _formState.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        focusNode.unfocus();
      },
      child: Scaffold(
        body: body(),
      ),
    );
  }

  Widget body() {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 50, 24, 12),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Form(
          key: _formState,
          child: Column(
            children: [
              _titleForm(),
              SwichedButton(
                title: "Time period",
                controllerDueTo: _dueToController,
                controllerRange: _startDateController,
                textFildVisibility: true,
                buttonText1: 'Due to',
                buttonText2: 'Range',
              ),
              _packageItemsForm(),
              _bottomForm()
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleForm() {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: AppColors.grey, width: 1.5))),
      child: Column(
        children: [
          CustumInput(
            textInputFormatter: MaskTextInputFormatter(mask: ''),
            limit: 64,
            controller: _titleController,
            hintText: 'Title',
            onSaved: (String? newValue) {},
            suffixIcon: Text(
              '64',
              style: Theme.of(context).textTheme.headline1,
            ),
            validator: (String? value) =>
                value!.isEmpty ? "Receiver's Name is required" : null,
          ),
          CustumInput(
            textInputFormatter: MaskTextInputFormatter(mask: ''),
            controller: _fromController,
            hintText: 'Form:',
            onSaved: (String? newValue) {},
            suffixIcon: Icon(
              Icons.place,
              color: AppColors.black,
            ),
            validator: (String? value) {},
          ),
          CustumInput(
            textInputFormatter: MaskTextInputFormatter(mask: ''),
            controller: _destinationController,
            hintText: 'Destination:',
            onSaved: (String? newValue) {},
            suffixIcon: Icon(
              Icons.place,
              color: AppColors.black,
            ),
            validator: (String? value) {},
          ),
          OpenDialogContainer(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Column(
                        children: ExamData.listTranstationType
                            .map((e) => CustomRadioListTile<int>(
                                  groupValue: val,
                                  onChanged: (int? value) {
                                    setState(() {
                                      val = value!;
                                      _selectTranstationType = e.text;
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  title: Text(e.text),
                                  value: e.value,
                                ))
                            .toList()),
                  );
                },
              );
            },
            icon: Picer.picker,
            text: _selectTranstationType,
          ),
          CompositedTransformTarget(
            link: layerLink,
            child: CustumInput(
              textInputFormatter: MaskTextInputFormatter(mask: ''),

              focusNode: focusNode,
              globalKey: receiverInputGlobalKey,
              hintText: "Receiver's Name",
              prefixIcon: Icon(
                Icons.account_circle,
                size: 30,
                color: Color(0xFF8E8E93),
              ),
              // onChanged: (str) {
              //   showOverlay(receiverInputGlobalKey);
              // },
              onSaved: (String? newValue) {},
              // validator: (String? value) =>
              //     value!.isEmpty ? "Receiver's Name is required" : null,
              controller: _receiversNameController,
              validator: (String? value) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _packageItemsForm() {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: AppColors.grey, width: 1.5))),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 24, top: 24),
            child: Text(
              "Package Items (0)",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          OpenDialogContainer(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Column(
                        children: ExamData.listItemTitle
                            .map((e) => CustomRadioListTile<int>(
                                  groupValue: val,
                                  onChanged: (int? value) {
                                    setState(() {
                                      val = value!;
                                      _itemTitle = e.text;
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  title: Text(e.text),
                                  value: e.value,
                                ))
                            .toList()),
                  );
                },
              );
            },
            icon: Picer.picker,
            text: _itemTitle,
          ),
          CustumInput(
            textInputFormatter: MaskTextInputFormatter(mask: ''),
            limit: 64,
            controller: _itemTitleController,
            hintText: 'Item title',
            onSaved: (String? newValue) {},
            suffixIcon: Text(
              '64',
              style: Theme.of(context).textTheme.headline1,
            ),
            validator: (String? value) =>
                value!.isEmpty ? "Receiver's Name is required" : null,
          ),
          Row(
            children: [
              Expanded(
                child: CustumInput(
                  textInputType: TextInputType.number,
                  textInputFormatter: MaskTextInputFormatter(mask: ""),
                  controller: _weightController,
                  hintText: 'Weight',
                  suffixIcon: Text(
                    'kg',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  onSaved: (String? newValue) {},
                  validator: (String? value) {},
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: CustumInput(
                  textInputType: TextInputType.number,
                  textInputFormatter: MaskTextInputFormatter(mask: ""),
                  controller: _priceController,
                  hintText: 'Price',
                  suffixIcon: Text(
                    'USD',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  onSaved: (String? newValue) {},
                  validator: (String? value) {},
                ),
              ),
            ],
          ),
          CustumInput(
            maxLines: 5,
            textInputFormatter: MaskTextInputFormatter(mask: ''),
            limit: 300,
            controller: _itemDesController,
            hintText: 'Title',
            onSaved: (String? newValue) {},
            suffixIcon: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              width: 15,
              child: Text(
                '300',
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            validator: (String? value) =>
                value!.isEmpty ? "Receiver's Name is required" : null,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _itemimage(),
                Clickable(
                  onPressed: () {
                    _showImagePicker(context);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.grey,
                          border: Border.all(color: AppColors.greyDark),
                          borderRadius: Corners.smBorder),
                      width: 80,
                      height: 80,
                      child: Center(
                          child: Icon(
                        Icons.add,
                        size: 35,
                        color: _image == null
                            ? AppColors.greyDark
                            : AppColors.blue,
                      ))),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _bottomForm() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 24),
          padding: EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: AppColors.grey, width: 1.5))),
          child: CustumButton(
            buttonText: 'New Item',
            onPressed: () {},
          ),
        ),
        SwichedButton(
          title: "Reword",
          controllerDueTo: _dueToController,
          controllerRange: _startDateController,
          textFildVisibility: false,
          buttonText1: 'Bidding',
          buttonText2: 'Fixed',
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: CustumInput(
            controller: _amountController,
            hintText: 'Amount',
            onSaved: (String? newValue) {},
            textInputFormatter: MaskTextInputFormatter(mask: ''),
            validator: (String? value) {},
            suffixIcon: Text(
              'USD',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 24),
          child: CustumButton(
            buttonText: 'Create request',
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  _imgFromCamera(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {}
    });
  }

  _imgFromGallery(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source, imageQuality: 50);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  void _showImagePicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery(ImageSource.gallery);
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      _imgFromCamera(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _itemimage() {
    return GestureDetector(
      onTap: () {
        _showImagePicker(context);
      },
      child: Container(
        margin: EdgeInsets.only(right: 15),
        child: _image != null
            ? ClipRRect(
                borderRadius: Corners.smBorder,
                child: Image.file(
                  _image!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    color: AppColors.grey,
                    border: Border.all(color: AppColors.greyDark),
                    borderRadius: Corners.smBorder),
                width: 80,
                height: 80,
                child: Center(
                    child: Icon(
                  Icons.photo_camera,
                  color: AppColors.black,
                ))),
      ),
    );
  }
}
