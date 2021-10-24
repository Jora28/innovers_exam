part of 'homepage_bloc.dart';

abstract class HomepageEvent extends Equatable {
  const HomepageEvent();

  @override
  List<Object> get props => [];
}

class OnImagePickerEvent extends HomepageEvent {
  final ImagePicker imagePicker;

  OnImagePickerEvent({required this.imagePicker});
  @override
  List<Object> get props => [imagePicker];
}

class OpenBottomDialog extends HomepageEvent {
  final BuildContext context;
  final List<TranstationType> listType;

  OpenBottomDialog({required this.context, required this.listType});
  @override
  List<Object> get props => [context, listType];
}

class AddPackageItemsEvent extends HomepageEvent {
  final BuildContext context;
  final List<TranstationType> listType;

  AddPackageItemsEvent({required this.context, required this.listType});
  @override
  List<Object> get props => [context, listType];
}

class AddNewItemEvent extends HomepageEvent {
  final ItemModel itemModel;

  AddNewItemEvent({required this.itemModel});
  @override
  List<Object> get props => [itemModel];
}

class DeleteItemEvent extends HomepageEvent {
  final ItemModel itemModel;
  final List<ItemModel> listItems;
  final BuildContext context;

  DeleteItemEvent(
      {required this.itemModel,
      required this.listItems,
      required this.context});
  @override
  List<Object> get props => [itemModel];
}
