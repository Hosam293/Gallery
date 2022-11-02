import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constant/color_manager.dart';
import '../../../view_model/cubits/gallery_cubit/gallery_cubit.dart';
import '../../../view_model/cubits/gallery_cubit/gallery_state.dart';
import '../../screens/gallery_screen.dart';
import '../core_component/custom_text.dart';

buildShowGeneralDialog(BuildContext context, GalleryCubit galleryCubit) async {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.transparent,
    pageBuilder: (context, __, ___) {

      return BlocConsumer<GalleryCubit, GalleryStates>(
          listener: (context, state) async {

            if (state is PhotoPickedSuccessState) {
              print('asjajsajjs');
              await galleryCubit.uploadImage(GalleryCubit.get(context).photoUser);
              print('asjajsajjs');

            }
            if (state is UploadImageSuccessState) {

              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) => GalleryScreen()),(route) => false,);
            }
            if(state is UploadImageErrorState)
            {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg.toString())));
            }
          }, builder: (context, state) {
        return Center(
          child: Container(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  width: double.infinity,
                  height: 353.h,
                  margin: EdgeInsets.symmetric(horizontal: 37.w),
                  padding: EdgeInsets.symmetric(horizontal: 85.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.4),
                    borderRadius: BorderRadius.circular(32.r),
                    border: Border.all(width: 2.w, color: Colors.white30),
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white60, Colors.white10]),
                  ),
                  child:(state is !UploadImageLoadingState)? Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: Container(
                          height: 68.h,
                          decoration: BoxDecoration(
                            color: ColorManager.galleryButtonColor,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 15.h, horizontal: 15.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/icons/gallery.png',
                                height: 33.h,
                                width: 32.w,
                              ),
                              CustomText(
                                text: 'Gallery',
                                fontSize: 27.sp,
                                color: ColorManager.black,
                              )
                            ],
                          ),
                        ),
                        onTap: () {

                          galleryCubit.getUserImage(source: ImageSource.gallery);
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          height: 68.h,
                          decoration: BoxDecoration(
                            color: ColorManager.cameraButtonColor,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 15.h, horizontal: 15.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/icons/camera.png',
                                height: 40.h,
                                width: 40.w,
                                fit: BoxFit.cover,
                              ),
                              CustomText(
                                text: 'Camera',
                                fontSize: 27.sp,
                                color: ColorManager.black,
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          GalleryCubit.get(context)
                              .getUserImage(source: ImageSource.camera);
                        },
                      ),
                    ],
                  ):Row(
                    children:
                    [
                      CustomText(text:'Uploading Image', fontSize: 15.sp,color: ColorManager.white,),
                      SizedBox(width: 5.w,),
                      const CircularProgressIndicator(
                        color: Colors.white60,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
    },
  );
}

