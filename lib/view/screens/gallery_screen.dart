import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_mina_gallery/view/component/core_component/custom_button.dart';
import 'package:pro_mina_gallery/view_model/cubits/gallery_cubit/gallery_cubit.dart';
import 'package:pro_mina_gallery/view_model/cubits/gallery_cubit/gallery_state.dart';

import '../../constant/color_manager.dart';
import '../../view_model/cubits/auth_cubit/auth_cubit.dart';
import '../../view_model/database/local/cache_helper.dart';
import '../component/core_component/background_images.dart';
import '../component/core_component/custom_text.dart';
import '../component/core_component/custom_text_form_filed.dart';
import '../component/core_component/grouped_images.dart';
import '../component/gallery_component/gallery_action_button.dart';
import 'login_screen.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authCubit = BlocProvider.of<AuthCubit>(context, listen: true);

    return BlocProvider(
      create: (context) => GalleryCubit()..getGalleryImage(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              BackGroundImages(),
              Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: -100.sp,
                    top: 10.sp,
                    child: SvgPicture.asset(
                      'assets/images/circles.svg',
                    ),
                  ),
                  GroupedImage(),
                ],
              ),
              Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/frame.png',
                    color: ColorManager.white.withOpacity(.4),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 35.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 27.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text:
                                  'Welcome\n${authCubit.loginModel!.user!.name.toString()}',
                              fontSize: 32.sp,
                              color: ColorManager.black,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.w600,
                            ),
                            CircleAvatar(
                              radius: 33.r,
                              backgroundImage: const AssetImage(
                                  'assets/images/displayimage.png'),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 44.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 45.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  CacheHelper.removeData(key: 'accessToken');
                                  authCubit.loginModel = null;
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                    (route) => false,
                                  );
                                },
                                child: GalleryActionButton(
                                  text: 'log out',
                                  image: 'assets/images/left.svg',
                                  gradient: ColorManager.logOutGradient,
                                  boxShadow: [ColorManager.logOutShadow],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 50.w,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showGeneralDialog(
                                    context: context,
                                    barrierLabel: "Barrier",
                                    barrierDismissible: true,
                                    barrierColor: Colors.transparent,
                                    pageBuilder: (_, __, ___) {
                                      return BlocConsumer<GalleryCubit,
                                              GalleryStates>(
                                          listener: (context, state) {
                                        if (state is PhotoPickedSuccessState) {
                                          GalleryCubit.get(context).uploadImage(
                                              GalleryCubit.get(context)
                                                  .photoUser);
                                        }
                                        if (state is UploadImageSuccessState) {

                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      GalleryScreen()));
                                        }
                                      }, builder: (context, state) {
                                        return Center(
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  25.r),
                                              child: BackdropFilter(
                                                filter:
                                                ImageFilter.blur(
                                                    sigmaX: 10,
                                                    sigmaY: 10),
                                                child: Container(
                                                  width:
                                                  double.infinity,
                                                  height: 353.h,
                                                  margin: EdgeInsets
                                                      .symmetric(
                                                      horizontal:
                                                      37.w),
                                                  padding: EdgeInsets
                                                      .symmetric(
                                                      horizontal:
                                                      85.w),
                                                  decoration:
                                                  BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(
                                                        .4),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        32.r),
                                                    border: Border.all(
                                                        width: 2.w,
                                                        color: Colors
                                                            .white30),
                                                    gradient: const LinearGradient(
                                                        begin: Alignment
                                                            .topLeft,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        colors: [
                                                          Colors
                                                              .white60,
                                                          Colors.white10
                                                        ]),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                    MainAxisSize
                                                        .min,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context).pop();

                                                          GalleryCubit.get(
                                                              context)
                                                              .getUserImage(
                                                              source:
                                                              ImageSource.gallery);
                                                        },
                                                        child:
                                                        Container(
                                                          height: 68.h,
                                                          decoration:
                                                          BoxDecoration(
                                                            color: ColorManager
                                                                .galleryButtonColor,
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                20.r),
                                                          ),
                                                          padding: EdgeInsets.symmetric(
                                                              vertical:
                                                              15.h,
                                                              horizontal:
                                                              15.w),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: [
                                                              Image
                                                                  .asset(
                                                                'assets/icons/gallery.png',
                                                                height:
                                                                33.h,
                                                                width:
                                                                32.w,
                                                              ),
                                                              CustomText(
                                                                text:
                                                                'Gallery',
                                                                fontSize:
                                                                27.sp,
                                                                color: ColorManager
                                                                    .black,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context).pop();
                                                          GalleryCubit.get(
                                                              context)
                                                              .getUserImage(
                                                              source:
                                                              ImageSource.camera);
                                                        },
                                                        child:
                                                        Container(
                                                          height: 68.h,
                                                          decoration:
                                                          BoxDecoration(
                                                            color: ColorManager
                                                                .cameraButtonColor,
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                20.r),
                                                          ),
                                                          padding: EdgeInsets.symmetric(
                                                              vertical:
                                                              15.h,
                                                              horizontal:
                                                              15.w),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: [
                                                              Image
                                                                  .asset(
                                                                'assets/icons/camera.png',
                                                                height:
                                                                40.h,
                                                                width:
                                                                40.w,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                              CustomText(
                                                                text:
                                                                'Camera',
                                                                fontSize:
                                                                27.sp,
                                                                color: ColorManager
                                                                    .black,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
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
                                },
                                child: GalleryActionButton(
                                  text: 'upload',
                                  image: 'assets/images/upLoad.svg',
                                  gradient: ColorManager.uploadGradient,
                                  boxShadow: [ColorManager.uploadShadow],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<GalleryCubit, GalleryStates>(
                        builder: (context, state) {
                          var galleryCubit =
                              BlocProvider.of<GalleryCubit>(context);
                          return ConditionalBuilder(
                              condition: state is! GalleryLoadingState,
                              builder: (context) => Expanded(
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: galleryCubit
                                          .galleryModel!.data!.images!.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 24.h,
                                        crossAxisSpacing: 24.w,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 34.h, horizontal: 28.w),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                          ),
                                          elevation: 7,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Container(
                                            height: 108.h,
                                            width: 108.w,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        galleryCubit
                                                            .galleryModel!
                                                            .data!
                                                            .images![index]
                                                            .toString()))),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                              fallback: (context) =>
                                  const LinearProgressIndicator(
                                    color: Colors.white60,
                                  ));
                        },
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
