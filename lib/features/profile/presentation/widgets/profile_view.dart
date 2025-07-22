import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shartflix/core/enum/route_type.dart';
import 'package:shartflix/core/theme/constants/app_colors.dart';
import 'package:shartflix/core/util/context_extension.dart';
import 'package:shartflix/di_helper.dart';
import 'package:shartflix/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:shartflix/features/profile/presentation/bloc/profile_event.dart';
import 'package:shartflix/features/profile/presentation/bloc/profile_state.dart';
import 'package:shartflix/models/user_model.dart';
import 'package:shartflix/support/app_lang.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  UserModel? model;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      sl<ProfileBloc>().add(ProfileLoadedEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return SizedBox(height: 60, child: Center(child: CircularProgressIndicator()));
        }

        var image = model?.photoUrl ?? '';
        var hasImage = image.isNotEmpty;

        return SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                if (hasImage)
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: CachedNetworkImageProvider(model?.photoUrl ?? ''),
                  ),

                if (!hasImage)
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.primary,
                    child: Icon(Icons.person, color: Colors.white, size: 32),
                  ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model?.name ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'ID: ${model?.id ?? ''}',
                        style: TextStyle(color: Colors.grey[400], fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                InkWell(
                  onTap: () => onTapAddPhoto(),
                  child: Container(
                    height: 35,
                    width: 120,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        lang(LocaleKeys.addPhoto),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is ProfileErrorState) {
          context.showDefaultSnackbar(lang(state.message));
        } else if (state is ProfileLoadedState) {
          model = state.model;
        }
      },
    );
  }

  // MARK: Actions
  void onTapAddPhoto() {
    context.push(RouteType.photoUpload.name);
  }
}
