

class UploadImageModel {
  String? status;
  Data? data;
  String? message;

  UploadImageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class Data {
  List<dynamic>? images;

  Data.fromJson(Map<String, dynamic> json) {
    images = json['images'];
  }
}
