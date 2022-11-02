class GalleryModel {
  String? status;
  Data? data;
  String? message;

  GalleryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class Data {
  List<String>? images;

  Data.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
  }
}
