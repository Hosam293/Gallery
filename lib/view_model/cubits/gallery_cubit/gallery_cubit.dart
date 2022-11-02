import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/gallery_model.dart';
import '../../../model/login_model.dart';
import '../../../model/upload_image.dart';
import '../../database/local/cache_helper.dart';
import '../../database/network/dio_exceptions.dart';
import '../../database/network/dio_helper.dart';
import '../../database/network/end_points.dart';
import 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryStates> {
  GalleryCubit() : super(GalleryInitialState());

  static GalleryCubit get(context) => BlocProvider.of<GalleryCubit>(context);

  String token = CacheHelper.getData(key: 'accessToken') ?? '';
  GalleryModel? galleryModel;
  UploadImageModel? uploadImageModel;

  Future<void> getGalleryImage() async {
    emit(GalleryLoadingState());
    await DioHelper.getData(url: gallery, token: token).then((value) {
      galleryModel = GalleryModel.fromJson(value.data);

      emit(GallerySuccessState());
    }).catchError((onError) {
      if (onError is DioError) {
        emit(GalleryErrorState(
            onError is DioError ? onError.response!.data['message'] : 'Error'));
      }
    });
  }

  var photoUser;
  var picker = ImagePicker();

  Future<void> getUserImage({required ImageSource source}) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      photoUser = File(pickedFile.path);

      emit(PhotoPickedSuccessState());
    } else {
      emit(PhotoPickedErrorState());
    }
  }

  // UploadImageModel? uploadImageModel;

  Future<void> uploadImage(File file) async {
    print('loading');
    String fileName = file.path.split('/').last;
    FormData data = FormData.fromMap({
      "img": await MultipartFile.fromFile(file.path,
          filename: fileName, contentType: MediaType("image", "png")),
    });
    Dio dio = new Dio();
    dio.options.headers = dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token ?? ''}',
    };
    print('data');
emit(UploadImageLoadingState());
   await dio
        .post(
      'https://technichal.prominaagency.com/api/upload',
      data: data,
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    )
        .then((value) {


      emit(UploadImageSuccessState());
    }).catchError((error) {
      if (error is DioError) {

        emit(UploadImageErrorState(
            error is DioError ? error.response!.data['message'] : 'Error'));
      }

    });
  }
}
