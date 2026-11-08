import 'package:flutter_bloc/flutter_bloc.dart';

import '../injections/injections.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../localization/bloc/localization_bloc.dart';
import '../theme/bloc/theme_bloc.dart';

List<BlocProvider> get appProviders => [
  BlocProvider<AuthBloc>(
    create: (_) => getIt<AuthBloc>(),
  ),
  BlocProvider<LocalizationBloc>(
    create: (_) => LocalizationBloc()..add(GetLanguage()),
  ),
  BlocProvider<ThemeBloc>(
    create: (_) => ThemeBloc()..add(GetTheme()),
  ),
];
