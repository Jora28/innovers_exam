part of 'homepage_bloc.dart';

abstract class HomepageState extends Equatable {
  const HomepageState();

  @override
  List<Object> get props => [];
}

class HomepageInitial extends HomepageState {}

class ImagePickedState extends HomepageState {
  final File? image;

  ImagePickedState({required this.image});
  @override
  List<Object> get props => [image!];
}

class GetItemState extends HomepageState {
  final String item;

  GetItemState({required this.item});
  @override
  List<Object> get props => [item];
}

class GetPackageItemsState extends HomepageState {
  final String item;

  GetPackageItemsState({required this.item});
  @override
  List<Object> get props => [item];
}

class AddNewItemState extends HomepageState {
  final List<ItemModel> listItemModel;

  AddNewItemState({required this.listItemModel});
  @override
  List<Object> get props => [listItemModel];
}

class DeletedItemState extends HomepageState {
  final List<ItemModel> listItemModel;

  DeletedItemState({required this.listItemModel});
  @override
  List<Object> get props => [listItemModel];
}
