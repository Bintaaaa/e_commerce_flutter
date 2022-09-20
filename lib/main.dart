import 'package:account/presentation/bloc/logout/logout_cubit.dart';
import 'package:account/presentation/bloc/user/user_cubit.dart';
import 'package:auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:auth/presentation/ui/sign_in_screen.dart';
import 'package:auth/presentation/ui/sign_up_screen.dart';
import 'package:common/utils/navigation/navigation_helper.dart';
import 'package:common/utils/navigation/router/app_routes.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/firebase/firebase.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:home_page/presentation/cubit/banner/banner_cubit.dart';
import 'package:home_page/presentation/cubit/bottom_nav_cubit/home_cubit.dart';
import 'package:home_page/presentation/cubit/category_product/category_product_cubit.dart';
import 'package:home_page/presentation/cubit/product/product_cubit.dart';
import 'package:home_page/presentation/ui/bottom_navigation.dart';
import 'package:onboarding/presentation/bloc/onboarding_bloc/onboarding_cubit.dart';
import 'package:onboarding/presentation/bloc/splash_bloc/splash_cubit.dart';
import 'package:onboarding/presentation/ui/on_boarding_screen.dart';
import 'package:onboarding/presentation/ui/splash_screen.dart';

import 'injections/injections.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Injections().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (_, __) => MaterialApp(
        title: 'Flutter E Commerce',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiBlocProvider(providers: [
          BlocProvider(
            create: (_) => SplashCubit(
                getOnBoardingStatusUseCase: sl(), getTokenUsecase: sl())
              ..initSplash(),
          )
        ], child: SplashScreen()),
        navigatorKey: NavigationHelperImpl.navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case AppRoutes.splash:
              return MaterialPageRoute(builder: (_) => SplashScreen());
            case AppRoutes.onboarding:
              return MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => OnBoardingCubit(
                    cacheOnBoardingUseCase: sl(),
                  ),
                  child: OnBoardingScreen(),
                ),
              );
            case AppRoutes.signIn:
              return MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => SignInBloc(
                    cacheTokenUseCase: sl(),
                    signInUseCase: sl(),
                  ),
                  child: SignInScreen(),
                ),
              );
            case AppRoutes.signUp:
              return MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => SignUpBloc(
                    signUpUseCase: sl(),
                    cacheTokenUseCase: sl(),
                  ),
                  child: SignUpScreen(),
                ),
              );
            case AppRoutes.home:
              return MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<HomeCubit>(
                      create: (_) => HomeCubit(),
                    ),
                    BlocProvider<BannerCubit>(
                      create: (_) => BannerCubit(
                        getBannerUseCase: sl(),
                      )..getBanner(),
                    ),
                    BlocProvider<ProductCubit>(
                      create: (_) => ProductCubit(
                        getProductUseCase: sl(),
                      )..getProduct(),
                    ),
                    BlocProvider<CategoryProductCubit>(
                      create: (_) =>
                          CategoryProductCubit(productCategoryUseCase: sl())
                            ..getProductCategory(),
                    ),
                    BlocProvider<UserCubit>(
                      create: (_) => UserCubit(getUserUsecase: sl())..getUSer(),
                    ),
                    BlocProvider<LogoutCubit>(
                        create: (_) => LogoutCubit(postLogoutUsecase: sl())),
                  ],
                  child: const BottomNavigation(),
                ),
              );

            default:
              return MaterialPageRoute(builder: (_) => SplashScreen());
          }
        },
      ),
    );
  }
}
