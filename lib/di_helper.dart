import 'package:get_it/get_it.dart';
import 'package:shartflix/core/network/dio_network_service.dart';
import 'package:shartflix/core/network/network_service.dart';
import 'package:shartflix/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:shartflix/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:shartflix/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:shartflix/features/auth/domain/repositories/auth_repository.dart';
import 'package:shartflix/features/auth/domain/use_cases/login_use_case.dart';
import 'package:shartflix/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:shartflix/features/auth/domain/use_cases/register_use_case.dart';
import 'package:shartflix/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shartflix/features/discover/data/datasources/discover_remote_data_source.dart';
import 'package:shartflix/features/discover/data/datasources/discover_remote_data_source_impl.dart';
import 'package:shartflix/features/discover/data/repositories/discover_repository_impl.dart';
import 'package:shartflix/features/discover/domain/repositories/discover_repository.dart';
import 'package:shartflix/features/discover/domain/usecases/get_movie_list_use_case.dart';
import 'package:shartflix/features/discover/domain/usecases/toggle_favorite_use_case.dart';
import 'package:shartflix/features/discover/presentation/bloc/discover_bloc.dart';
import 'package:shartflix/features/language/presentation/bloc/lang_bloc.dart';
import 'package:shartflix/features/main_navigation/presentation/cubit/main_nav_cubit.dart';
import 'package:shartflix/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:shartflix/features/profile/data/datasources/profile_remote_data_source_impl.dart';
import 'package:shartflix/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:shartflix/features/profile/domain/repositories/profile_repository.dart';
import 'package:shartflix/features/profile/domain/usecases/get_my_favorite_use_case.dart';
import 'package:shartflix/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:shartflix/features/profile/domain/usecases/upload_profile_use_case.dart';
import 'package:shartflix/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:shartflix/features/splash/data/datasources/splash_remote_data_source.dart';
import 'package:shartflix/features/splash/data/datasources/splash_remote_data_source_impl.dart';
import 'package:shartflix/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:shartflix/features/splash/domain/repositories/splash_repository.dart';
import 'package:shartflix/features/splash/domain/usecases/check_token_use_case.dart';
import 'package:shartflix/features/splash/domain/usecases/delete_token_use_case.dart';
import 'package:shartflix/features/splash/domain/usecases/get_token_use_case.dart';
import 'package:shartflix/features/splash/domain/usecases/get_user_use_case.dart';
import 'package:shartflix/features/splash/domain/usecases/save_user_use_case.dart';
import 'package:shartflix/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:shartflix/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:shartflix/shared/local/shared_prefs/secure_shrared_pref_impl.dart';
import 'package:shartflix/shared/local/shared_prefs/shared_pref.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Shared Prefs
  final securePref = SecureShraredPrefImpl();
  securePref.init();
  sl.registerLazySingleton<SharedPref>(() => securePref);

  // Network Service
  sl.registerLazySingleton<NetworkService>(() => DioNetworkService());

  // Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl(), sl()),
  );
  sl.registerLazySingleton<SplashRemoteDataSource>(
    () => SplashRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<DiscoverRemoteDataSource>(
    () => DiscoverRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<SplashRepository>(() => SplashRepositoryImpl(sl()));
  sl.registerLazySingleton<DiscoverRepository>(() => DiscoverRepositoryImpl(sl()));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(sl()));

  // UseCases
  sl.registerLazySingleton(() => RegisterUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => LoginUseCase(authRepository: sl()));

  sl.registerLazySingleton(() => GetTokenUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTokenUseCase(sl()));
  sl.registerLazySingleton(() => CheckTokenUseCase(sl()));
  sl.registerLazySingleton(() => GetUserUseCase(sl()));
  sl.registerLazySingleton(() => SaveUserUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  sl.registerLazySingleton(() => GetMovieListUseCase(sl()));
  sl.registerLazySingleton(() => ToggleFavoriteUseCase(sl()));

  sl.registerLazySingleton(() => GetMyFavoriteUseCase(sl()));
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton(() => UploadProfilePhotoUseCase(sl()));

  // Bloc
  sl.registerLazySingleton(() => SplashBloc(sl()));
  sl.registerLazySingleton(() => AuthBloc(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => DiscoverBloc(sl(), sl()));
  sl.registerLazySingleton(() => MainNavCubit());
  sl.registerLazySingleton(() => ProfileBloc(sl(), sl(), sl()));
  sl.registerLazySingleton(() => ThemeBloc());
  sl.registerLazySingleton(() => LanguageBloc());
}
