import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:base_flutter/src/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:base_flutter/src/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:base_flutter/src/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:base_flutter/src/features/auth/presentation/screens/otp_screen.dart';
import 'package:base_flutter/src/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:base_flutter/src/features/auth/presentation/screens/sign_up_information_screen.dart';

import '../core/injections/injections.dart';

import '../features/auth/presentation/bloc/auth_bloc.dart';

import '../features/auth/presentation/screens/auth_screen.dart';
import '../features/auth/presentation/screens/get_started_screen.dart';
import '../features/auth/presentation/screens/onboarding_screen.dart';
import '../features/auth/presentation/screens/sign_in_screen.dart';
import '../features/auth/presentation/screens/sign_up_screen.dart';
import '../features/auth/presentation/screens/forgot_password_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';

import 'route.dart';

part 'router.dart';
part 'router.auth.dart';
part 'router.main.dart';
