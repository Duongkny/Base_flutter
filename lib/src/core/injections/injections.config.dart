// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:base_flutter/src/core/api/dio_client.dart' as _i240;
import 'package:base_flutter/src/core/injections/module.dart' as _i613;
import 'package:base_flutter/src/features/auth/data/datasources/auth_remote_datasource.dart'
    as _i252;
import 'package:base_flutter/src/features/auth/data/repos/auth_repo_impl.dart'
    as _i299;
import 'package:base_flutter/src/features/auth/domain/repos/auth_repo.dart'
    as _i519;
import 'package:base_flutter/src/features/auth/domain/usecases/forgot_password_usecase.dart'
    as _i71;
import 'package:base_flutter/src/features/auth/domain/usecases/reset_password_usecase.dart'
    as _i24;
import 'package:base_flutter/src/features/auth/domain/usecases/send_otp_usecase.dart'
    as _i479;
import 'package:base_flutter/src/features/auth/domain/usecases/sign_in_usecase.dart'
    as _i1065;
import 'package:base_flutter/src/features/auth/domain/usecases/sign_up_usecase.dart'
    as _i955;
import 'package:base_flutter/src/features/auth/domain/usecases/update_profile_usecase.dart'
    as _i271;
import 'package:base_flutter/src/features/auth/domain/usecases/verify_otp_usecase.dart'
    as _i611;
import 'package:base_flutter/src/features/auth/presentation/bloc/auth_bloc.dart'
    as _i355;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_ce_flutter/adapters.dart' as _i170;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i240.DioClient>(() => _i240.DioClient());
    gh.lazySingleton<_i170.HiveInterface>(() => registerModule.hive);
    gh.lazySingleton<_i974.Logger>(() => registerModule.logger);
    gh.lazySingleton<_i361.Dio>(
      () => registerModule.dio(gh<_i240.DioClient>()),
    );
    gh.lazySingleton<_i252.AuthRemoteDataSource>(
      () => _i252.AuthRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i519.AuthRepo>(
      () => _i299.AuthRepoImpl(gh<_i252.AuthRemoteDataSource>()),
    );
    gh.factory<_i71.ForgotPasswordUseCase>(
      () => _i71.ForgotPasswordUseCase(gh<_i519.AuthRepo>()),
    );
    gh.factory<_i24.ResetPasswordUseCase>(
      () => _i24.ResetPasswordUseCase(gh<_i519.AuthRepo>()),
    );
    gh.factory<_i479.SendOtpUseCase>(
      () => _i479.SendOtpUseCase(gh<_i519.AuthRepo>()),
    );
    gh.factory<_i1065.SignInUseCase>(
      () => _i1065.SignInUseCase(gh<_i519.AuthRepo>()),
    );
    gh.factory<_i955.SignUpUseCase>(
      () => _i955.SignUpUseCase(gh<_i519.AuthRepo>()),
    );
    gh.factory<_i271.UpdateProfileUseCase>(
      () => _i271.UpdateProfileUseCase(gh<_i519.AuthRepo>()),
    );
    gh.factory<_i611.VerifyOtpUseCase>(
      () => _i611.VerifyOtpUseCase(gh<_i519.AuthRepo>()),
    );
    gh.factory<_i355.AuthBloc>(
      () => _i355.AuthBloc(
        gh<_i1065.SignInUseCase>(),
        gh<_i955.SignUpUseCase>(),
        gh<_i271.UpdateProfileUseCase>(),
        gh<_i71.ForgotPasswordUseCase>(),
        gh<_i611.VerifyOtpUseCase>(),
        gh<_i24.ResetPasswordUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i613.RegisterModule {}
