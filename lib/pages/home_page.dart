import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:innovers_exam/models/item_model.dart';
import 'package:innovers_exam/pages/bloc/homepage_bloc.dart';
import 'package:innovers_exam/utils/behavior.dart';
import 'package:innovers_exam/utils/colors.dart';
import 'package:innovers_exam/utils/data.dart';
import 'package:innovers_exam/utils/styles.dart';
import 'package:innovers_exam/widgets/button.dart';
import 'package:innovers_exam/widgets/clicable_widgets.dart';
import 'package:innovers_exam/widgets/contact_list.dart';
import 'package:innovers_exam/widgets/custom_radio.dart';
import 'package:innovers_exam/widgets/icons/picer_icons.dart';
import 'package:innovers_exam/widgets/input.dart';
import 'package:innovers_exam/widgets/location_list.dart';
import 'package:innovers_exam/widgets/open_dialog_container.dart';
import 'package:innovers_exam/widgets/package_item.dart';
import 'package:innovers_exam/widgets/swiched_button.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey receiverInputGlobalKey = GlobalKey();
  // GlobalKey descriptionInputGlobalKey = GlobalKey();

  GlobalKey destinationGlobalKey = GlobalKey();
  GlobalKey fromGlobalKey = GlobalKey();

  final LayerLink layerLink = LayerLink();
  final LayerLink layerLinkFrom = LayerLink();
  final LayerLink layerLinkDestination = LayerLink();

  final FocusNode focusNodeReceviers = FocusNode();
  final FocusNode focusNodeFrom = FocusNode();
  final FocusNode focusNodeDestination = FocusNode();

  final _formTitleState = GlobalKey<FormState>();
  final _formPaCkageItemsState = GlobalKey<FormState>();

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
  String _selectTranstationType = 'Transtation Type';
  String _itemTitle = 'Item title';

  int currentLenghtTitle = 0;
  int currentLenghtItemTitle = 0;
  int currentLenghtItemDescription = 0;

  late HomepageBloc homepageBloc;

  String? avatar;

  File? _image;
  ImagePicker _picker = ImagePicker();
  List<ItemModel> listItems = [];
  @override
  void initState() {
    focusNodeReceviers.addListener(() {
      if (focusNodeReceviers.hasFocus) {
        showOverlay(
          layerLink: layerLink,
          globalKey: receiverInputGlobalKey,
          overlayWidget: ContactList(
            onTap: (model) {
              _receiversNameController.text = model.name;
              avatar = model.avatar;
              print('hide');
              hideOverLay();
              focusNodeReceviers.unfocus();
              _onSaveTitle();
            },
            width: MediaQuery.of(context).size.width,
          ),
        );
      } else {
        hideOverLay();
        // _onSave();
      }
    });

    focusNodeFrom.addListener(() {
      if (focusNodeFrom.hasFocus) {
        showOverlay(
          layerLink: layerLinkFrom,
          globalKey: fromGlobalKey,
          overlayWidget: LocationList(
            listLocations: ExamData.listLocations,
            onTap: (name) {
              _fromController.text = name;
              print('hide');
              hideOverLay();
              focusNodeFrom.unfocus();
            },
            width: MediaQuery.of(context).size.width,
          ),
        );
      } else {
        hideOverLay();
        // _onSave();
      }
    });

    focusNodeDestination.addListener(() {
      if (focusNodeDestination.hasFocus) {
        showOverlay(
          layerLink: layerLinkDestination,
          globalKey: destinationGlobalKey,
          overlayWidget: LocationList(
            listLocations: ExamData.listLocations,
            onTap: (name) {
              _destinationController.text = name;
              print('hide');
              hideOverLay();
              focusNodeDestination.unfocus();
            },
            width: MediaQuery.of(context).size.width,
          ),
        );
      } else {
        hideOverLay();
        // _onSave();
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    homepageBloc = BlocProvider.of<HomepageBloc>(context);
    super.didChangeDependencies();
  }

 
  void hideOverLay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  showOverlay(
      {required GlobalKey globalKey,
      required Widget overlayWidget,
      required LayerLink layerLink}) {
    final overlay = Overlay.of(context);
    final renderBox = globalKey.currentContext?.findRenderObject() as RenderBox;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        right: 24,
        left: 24,
        child: CompositedTransformFollower(
            offset: Offset(0, renderBox.size.height - 10),
            link: layerLink,
            showWhenUnlinked: false,
            child: overlayWidget),
      ),
    );
    overlay?.insert(overlayEntry!);
  }

  dynamic _onSaveTitle() async {
    if (!_formTitleState.currentState!.validate()) {
      return;
    }

    _formTitleState.currentState?.save();
  }

  dynamic _onSavePaCkageItems() async {
    if (!_formPaCkageItemsState.currentState!.validate()) {
      return;
    }

    _formPaCkageItemsState.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        focusNodeReceviers.unfocus();
        focusNodeFrom.unfocus();
        focusNodeDestination.unfocus();
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
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formTitleState,
                child: _titleForm(),
              ),
              SwichedButton(
                title: "Time period",
                controllerDueTo: _dueToController,
                controllerRange: _startDateController,
                textFildVisibility: true,
                buttonText1: 'Due to',
                buttonText2: 'Range',
              ),
              Form(
                key: _formPaCkageItemsState,
                child: _packageItemsForm(),
              ),
              _bottomForm()
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleForm() {
    return BlocBuilder<HomepageBloc, HomepageState>(
      builder: (context, state) {
        if (state is GetItemState) {
          _selectTranstationType = state.item;
        }
        return Container(
          margin: EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: AppColors.grey, width: 1.5))),
          child: Column(
            children: [
              CustumInput(
                textInputFormatter: MaskTextInputFormatter(mask: ''),
                limit: 64,
                controller: _titleController,
                hintText: 'Title',
                onSaved: (String? newValue) {},
                suffixIcon: Text(
                  currentLenghtTitle == 0
                      ? '64'
                      : '${currentLenghtTitle.toString()}',
                  style: Theme.of(context).textTheme.headline1,
                ),
                onChanged: (String value) {
                  setState(() {
                    currentLenghtTitle = value.length;
                  });
                },
                validator: (String? value) =>
                    value!.isEmpty ? "Title required" : null,
              ),
              CompositedTransformTarget(
                link: layerLinkFrom,
                child: CustumInput(
                  textInputFormatter: MaskTextInputFormatter(mask: ''),
                  controller: _fromController,
                  globalKey: fromGlobalKey,
                  hintText: 'Form:',
                  focusNode: focusNodeFrom,
                  onSaved: (String? newValue) {},
                  suffixIcon: Icon(
                    Icons.place,
                    color: AppColors.black,
                  ),
                  validator: (String? value) =>
                      value!.isEmpty ? "Form: required" : null,
                ),
              ),
              CompositedTransformTarget(
                link: layerLinkDestination,
                child: CustumInput(
                  globalKey: destinationGlobalKey,
                  textInputFormatter: MaskTextInputFormatter(mask: ''),
                  controller: _destinationController,
                  focusNode: focusNodeDestination,
                  hintText: 'Destination:',
                  onSaved: (String? newValue) {},
                  suffixIcon: Icon(
                    Icons.place,
                    color: AppColors.black,
                  ),
                  validator: (String? value) =>
                      value!.isEmpty ? "Destination: required" : null,
                ),
              ),
              OpenDialogContainer(
                onTap: () {
                  homepageBloc.add(OpenBottomDialog(
                    context: context,
                    listType: ExamData.listTranstationType,
                  ));
                },
                icon: Icons.menu,
                text: _selectTranstationType,
              ),
              CompositedTransformTarget(
                link: layerLink,
                child: CustumInput(
                  textInputFormatter: MaskTextInputFormatter(mask: ''),
                  focusNode: focusNodeReceviers,
                  globalKey: receiverInputGlobalKey,
                  hintText: "Receiver's Name",
                  prefixIcon: avatar == null
                      ? Icon(
                          Icons.account_circle,
                          size: 30,
                          color: Color(0xFF8E8E93),
                        )
                      : Container(
                          padding: EdgeInsets.all(5),
                          child: CircleAvatar(
                              radius: 18,
                              backgroundImage: AssetImage(
                                avatar!,
                              ),
                              backgroundColor: Colors.transparent),
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
      },
    );
  }

  Widget _packageItemsForm() {
    return BlocBuilder<HomepageBloc, HomepageState>(
      builder: (context, state) {
        if (state is GetPackageItemsState) {
          _itemTitle = state.item;
        } else if (state is ImagePickedState) {
          _image = state.image;
        } else if (state is AddNewItemState) {
          listItems = state.listItemModel;
        } else if (state is DeletedItemState) {
          listItems = state.listItemModel;
        }
        return Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 24, top: 24),
                child: Text(
                  "Package Items (${listItems.length})",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Wrap(
                children: [
                  Column(
                      children: listItems
                          .map(
                            (item) => PackageItem(
                              count: item.count,
                              description: item.description,
                              file: item.file,
                              itemName: item.itemName,
                              weight: item.weight,
                              onPressed: () {
                                homepageBloc.add(DeleteItemEvent(
                                    itemModel: item,
                                    listItems: listItems,
                                    context: context));
                              },
                            ),
                          )
                          .toList()),
                ],
              ),
              OpenDialogContainer(
                onTap: () {
                  homepageBloc.add(AddPackageItemsEvent(
                      context: context, listType: ExamData.listItemTitle));
                },
                icon: Icons.menu,
                text: _itemTitle,
              ),
              CustumInput(
                textInputFormatter: MaskTextInputFormatter(mask: ''),
                limit: 64,
                controller: _itemTitleController,
                hintText: 'Item title',
                onSaved: (String? newValue) {},
                suffixIcon: Text(
                  currentLenghtItemTitle == 0
                      ? '64'
                      : '${currentLenghtItemTitle.toString()}',
                  style: Theme.of(context).textTheme.headline1,
                ),
                validator: (String? value) =>
                    value!.isEmpty ? "Receiver's Name is required" : null,
                onChanged: (String value) {
                  setState(() {
                    currentLenghtItemTitle = value.length;
                  });
                },
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
                    currentLenghtItemDescription == 0
                        ? '300'
                        : '${currentLenghtItemDescription.toString()}',
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                onChanged: (String value) {
                  setState(() {
                    currentLenghtItemDescription = value.length;
                  });
                },
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
                        homepageBloc
                            .add(OnImagePickerEvent(imagePicker: _picker));
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
              ),
              Container(
                margin: EdgeInsets.only(top: 12, bottom: 12),
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(color: AppColors.grey, width: 1.5),
                  bottom: BorderSide(color: AppColors.grey, width: 1.5),
                )),
                child: CustumButton(
                  buttonText: 'New Item',
                  onPressed: _image == null
                      ? null
                      : () {
                          _onSavePaCkageItems();
                          homepageBloc.add(AddNewItemEvent(
                              itemModel: ItemModel(
                                  count: '1',
                                  description: _itemDesController.text,
                                  file: _image!,
                                  itemName: _itemTitleController.text,
                                  weight: _weightController.text)));
                          _itemDesController.clear();
                          _weightController.clear();
                          _priceController.clear();
                          _titleController.clear();
                          _itemTitleController.clear();
                          _image = null;
                          currentLenghtItemTitle = 0;
                          currentLenghtItemDescription = 0;
                        },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _bottomForm() {
    return Column(
      children: [
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
            textInputType: TextInputType.number,
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
            onPressed: _amountController.value.text.isEmpty
                ? null
                : () {
                    currentLenghtTitle = 0;
                  },
          ),
        ),
      ],
    );
  }

  Widget _itemimage() {
    return GestureDetector(
      onTap: () {
        homepageBloc.add(OnImagePickerEvent(imagePicker: _picker));
      },
      child: BlocBuilder<HomepageBloc, HomepageState>(
        builder: (context, state) {
          if (state is ImagePickedState) {
            _image = state.image;
          }
          return Container(
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
          );
        },
      ),
    );
  }
}
