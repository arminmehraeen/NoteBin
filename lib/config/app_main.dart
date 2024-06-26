import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebin/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:notebin/features/home/presentation/cubit/home_cubit.dart';
import 'package:notebin/features/intro/presentation/cubit/intro_cubit.dart';
import 'package:notebin/features/post/presentation/bloc/post_bloc.dart';
import 'package:notebin/features/profile/presentation/bloc/profile_bloc.dart';

import '../core/bloc/theme/theme_cubit.dart';
import '../features/intro/presentation/screens/p_splash.dart';
import 'app_theme.dart';
import 'custom_scroll_behavior.dart';
import 'locator.dart';

class AppMain extends StatelessWidget {
  const AppMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<ThemeCubit>()),
        BlocProvider(create: (_) => locator<HomeCubit>()),
        BlocProvider(create: (_) => locator<AuthCubit>()),
        BlocProvider(create: (_) => locator<IntroCubit>()),
        BlocProvider(create: (_) => locator<PostBloc>()),
        BlocProvider(create: (_) => locator<ProfileBloc>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          context.setLocale(state.locale);
          return MaterialApp(
              key: state.isRefreshApp ? UniqueKey() : null,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              title: "NOTEBIN",
              scrollBehavior: CustomScrollBehavior().copyWith(scrollbars: false),
              darkTheme: AppTheme.dark,
              theme: AppTheme.light,
              themeMode: state.themeMode,
              home: const SplashScreen());
        },
      ),
    );
  }
}
