import '../../../model/login_model.dart';

abstract class GalleryStates {}

class GalleryInitialState extends GalleryStates {}
class GalleryLoadingState extends GalleryStates {}
class GallerySuccessState extends GalleryStates {}
class GalleryErrorState extends GalleryStates
{
  final String msg;

  GalleryErrorState(this.msg);
}



class PhotoPickedSuccessState extends GalleryStates {}

class PhotoPickedErrorState extends GalleryStates {}

class MriUploadStart extends GalleryStates {}
class UploadImageLoadingState extends GalleryStates {}
class UploadImageSuccessState extends GalleryStates
{

}

class UploadImageErrorState extends GalleryStates
{
  final String msg;

  UploadImageErrorState(this.msg);
}

