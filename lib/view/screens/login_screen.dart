import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pro_mina_gallery/view/screens/gallery_screen.dart';
import 'package:pro_mina_gallery/view_model/database/local/cache_helper.dart';

import '../../constant/color_manager.dart';
import '../../view_model/cubits/auth_cubit/auth_cubit.dart';
import '../../view_model/cubits/auth_cubit/auth_state.dart';
import '../component/core_component/custom_button.dart';
import '../component/core_component/custom_text.dart';
import '../component/core_component/custom_text_form_filed.dart';
import '../component/core_component/custom_toast.dart';
import '../component/core_component/grouped_images.dart';

class LoginScreen extends StatelessWidget {
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var authCubit = BlocProvider.of<AuthCubit>(context,listen: true);
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                  bottom: 0,
                  top: 0,
                  right: 0,
                  child: Image.asset('assets/images/pink.png')),
              Positioned(
                  bottom: 0,
                  left: -80,
                  child: Image.asset('assets/images/Ellipse 1627.png')),
              Positioned(left: 0,
                  right: 0,
                  bottom: -80,

                  child: Image.asset('assets/images/Ellipse 1629.png',fit: BoxFit.cover,height: 300,width: 400.w)),
              Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: -100.sp,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          SvgPicture.asset('assets/images/circles.svg',
                              alignment: Alignment.topLeft),
                          Image.asset(
                              'assets/images/love_photography.png',
                              alignment: Alignment.topLeft),
                        ],
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 350.h,
                      ),
                      CustomText(
                        text: 'My\nGallery',
                        fontSize: 50.sp,
                        color: ColorManager.black,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          GroupedImage(),
                          Container(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onDoubleTapDown: (_) {
                                // ispressed=true
                              },
                              onTapUp: (_) {
                                // ispressed=false
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25.r),
                                child: BackdropFilter(
                                  filter:
                                  ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                  child: Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 42.w),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 31.w),
                                    decoration: BoxDecoration(
                                      color: ColorManager.white.withOpacity(.3),
                                      borderRadius:
                                      BorderRadius.circular(32.r),
                                      border: Border.all(
                                          width: 2.w, color: Colors.white30),
                                      gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.white60,
                                            Colors.white10
                                          ]),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 48.h),
                                        CustomText(
                                          text: 'LOG IN',
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.black,
                                        ),
                                        SizedBox(height: 38.h),
                                        CustomAuthFormField(
                                          title: 'User Name',
                                          controller: userNameController,
                                          type: TextInputType.emailAddress,
                                          autovalidateMode:
                                          AutovalidateMode.disabled,
                                          validator: (value) {
                                            if (value!.trim().isEmpty ||
                                                value == ' ') {
                                              return 'This field is required';
                                            }
                                            if (!RegExp(
                                                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                                .hasMatch(value)) {
                                              return 'Please enter a valid email address';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(
                                          height: 38.h,
                                        ),
                                        // password form with validation
                                        CustomAuthFormField(
                                          title: 'Password',
                                          controller: passwordController,
                                          type: TextInputType.visiblePassword,
                                          autovalidateMode:
                                          AutovalidateMode.disabled,
                                          obscureText:
                                          authCubit.isPasswordLogin,
                                          validator: (value) {
                                            if (value!.trim().isEmpty ||
                                                value == ' ') {
                                              return 'This field is required';
                                            }


                                            if (value.length > 32) {
                                              return 'Password Must be between 2 and 32 characters';
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          height: 38.h,
                                        ),
                                        BlocConsumer<AuthCubit, AuthStates>(
                                          listener: (context, state) {
                                            if (state is LoginSuccessState) {
                                              buildShowToast(
                                                  msg: 'Login Success');
                                              CacheHelper.saveData(key: 'accessToken', value: state.loginModel.token).then((value)
                                              {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GalleryScreen()));
                                              });
                                            }
                                            if (state is LoginErrorState) {
                                              buildShowToast(
                                                  msg: state.msg.toString());
                                            }
                                          },
                                          builder: (context, state) {
                                            return ConditionalBuilder(
                                              condition:
                                              state is! LoginLoadingState,
                                              builder: (context) => Container(
                                                width: double.infinity,
                                                height: 60.h,
                                                child: CustomButton(
                                                  buttonColor:
                                                  ColorManager.submitButtonColor,
                                                  widget: CustomText(
                                                    text: 'SUBMIT',
                                                    fontSize: 18.sp,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: ColorManager.white,
                                                  ),
                                                  onPressed: () {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      authCubit.userLogin(
                                                          userName:
                                                          userNameController
                                                              .text,
                                                          password:
                                                          passwordController
                                                              .text);
                                                    }
                                                  },
                                                  borderRadius: 10.r,
                                                ),
                                              ),
                                              fallback: (context) =>
                                              const Center(
                                                  child:
                                                  CircularProgressIndicator(
                                                    color: Colors.white10,
                                                  )),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 48.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
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

