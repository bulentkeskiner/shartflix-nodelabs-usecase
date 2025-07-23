import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shartflix/core/app/app_permission.dart';
import 'package:shartflix/core/components/app_ink_well.dart';
import 'package:shartflix/core/components/button/primary_button.dart';
import 'package:shartflix/core/theme/constants/app_colors.dart';
import 'package:shartflix/core/util/context_extension.dart';
import 'package:shartflix/di_helper.dart';
import 'package:shartflix/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:shartflix/features/profile/presentation/bloc/profile_event.dart';
import 'package:shartflix/features/profile/presentation/bloc/profile_state.dart';
import 'package:shartflix/support/app_lang.dart';

class PhotoUploadPage extends StatefulWidget {
  const PhotoUploadPage({super.key});

  @override
  State<PhotoUploadPage> createState() => _PhotoUploadPageState();
}

class _PhotoUploadPageState extends State<PhotoUploadPage> {
  XFile? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUploadLoadingState) {
          context.showLoader();
        } else {
          context.hideLoader();
        }

        if (state is PhotoUploadCompleteState) {
          Navigator.pop(context);
          sl<ProfileBloc>().add(ProfileLoadedEvent());
          context.showDefaultSnackbar(lang(LocaleKeys.uploadSuccess));
        } else if (state is ProfileErrorState) {
          context.showDefaultSnackbar(state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      AppInkWell(
                        onTap: () => onBack(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            border: BoxBorder.all(color: Colors.grey[800]!),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          lang(LocaleKeys.screenTitle),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),

                  const Spacer(flex: 2),

                  Text(
                    lang(LocaleKeys.uploadPhotosTitle),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    lang(LocaleKeys.lorem),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[400], fontSize: 16),
                  ),

                  const Spacer(flex: 1),

                  // Photo Upload Area
                  if (_selectedImage != null)
                    AppInkWell(
                      onTap: () => onSelectPhoto(),
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey[800]!),
                          image: DecorationImage(
                            image: FileImage(File(_selectedImage!.path)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  else
                    AppInkWell(
                      onTap: () => onSelectPhoto(),
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey[800]!),
                        ),
                        child: Center(
                          child: Icon(Icons.add, color: Colors.grey[600], size: 48),
                        ),
                      ),
                    ),

                  const Spacer(flex: 3),

                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      onPressed: _selectedImage != null ? () => onUploadPhoto() : null,
                      title: lang(LocaleKeys.continueButton),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // MARK: Actions

  onBack() {
    Navigator.pop(context);
  }

  onSelectPhoto() async {
    final permissionGranted = await AppPermission.instance.requestPhotoPermission();
    if (permissionGranted) {
      final result = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (result != null) {
        _selectedImage = result;
        setState(() {});
      }
    }
  }

  onUploadPhoto() {
    if (_selectedImage != null) {
      sl<ProfileBloc>().add(PhotoUploadEvent(File(_selectedImage!.path)));
    }
  }
}
