import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_mina_gallery/view/component/core_component/custom_button.dart';
import 'package:pro_mina_gallery/view/component/gallery_component/build_upload_dialog.dart';
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
    var galleryCubit = BlocProvider.of<GalleryCubit>(context);
    String user = CacheHelper.getData(key: 'user');

// starting screen with calling getGallery Images method to get images
    return BlocProvider(
      create: (context) => GalleryCubit()..getGalleryImage(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              // back ground image
              BackGroundImages(),
              Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: -200.sp,
                    top: 100.sp,
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
                      // User name And display image
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 27.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'Welcome\n$user',
                              fontSize: 32.sp,
                              color: ColorManager.black,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.w400,
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
                      // Log out  and upload image buttons
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 45.w),
                        child: Row(
                          children: [
                            //Log out button
                            Expanded(
                              child: GestureDetector(
                                child: GalleryActionButton(
                                  text: 'log out',
                                  image: 'assets/images/left.svg',
                                  gradient: ColorManager.logOutGradient,
                                  boxShadow: [ColorManager.logOutShadow],
                                ),
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
                              ),
                            ),
                            SizedBox(
                              width: 50.w,
                            ),
                            //upload button>>>>>>
                            Expanded(
                              child: GestureDetector(
                                child: GalleryActionButton(
                                  text: 'upload',
                                  image: 'assets/images/upLoad.svg',
                                  gradient: ColorManager.uploadGradient,
                                  boxShadow: [ColorManager.uploadShadow],
                                ),
                                onTap: () async {
                                  // gallery button and camera button in dialog
                                  await buildShowGeneralDialog(
                                      context, galleryCubit);
                                },
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
