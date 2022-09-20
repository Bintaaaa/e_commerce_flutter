import 'package:account/presentation/bloc/logout/logout_cubit.dart';
import 'package:account/presentation/bloc/user/user_cubit.dart';
import 'package:common/utils/navigation/router/auth_router.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:component/widget/button/chevron_button.dart';
import 'package:component/widget/progress_indicator/custom_circular_progress_indicator.dart';
import 'package:component/widget/stack/loading_stack.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/cached_network_image/cached_network_image.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:resources/colors.gen.dart';

class AccountScreen extends StatelessWidget {
  final AuthRouter authRouter = sl();
  AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.textFieldBackgroundGrey,
      appBar: AppBar(
        backgroundColor: ColorName.white,
        elevation: 0.0,
        centerTitle: false,
        title: Text(
          "Akun Saya",
          style: TextStyle(
            color: ColorName.orange,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: BlocConsumer<LogoutCubit, LogoutState>(
        listener: (context, state) {
          final status = state.logoutState.status;
          if (status.isHasData) {
            authRouter.navigateToSignIn();
          }
        },
        builder: (context, state) {
          return LoadingStack(
            isLoading: state.logoutState.status.isLoading,
            widget: ListView(
              padding: const EdgeInsets.only(
                top: 16.0,
                left: 16.0,
                right: 16.0,
              ),
              shrinkWrap: true,
              children: [
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    final status = state.userState.status;
                    if (status.isLoading) {
                      return const Center(
                          child: CustomCircularProgressIndicator());
                    } else if (status.isHasData) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                            child: CachedNetworkImage(
                              width: 45.w,
                              height: 45.w,
                              imageUrl: state.userState.data!.imageUrl,
                              placeholder: (context, url) => const Center(
                                  child: CustomCircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          SizedBox(
                            width: 9.w,
                          ),
                          Text(
                            state.userState.data!.fullName.isEmpty
                                ? state.userState.data!.username
                                : state.userState.data!.fullName,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp,
                                color: ColorName.textBlack),
                          ),
                        ],
                      );
                    } else if (status.isError) {
                      return Center(child: Text(state.userState.message));
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                ChevronButton(
                  buttonText: 'Data Diri',
                  onTap: () async {},
                ),
                ChevronButton(
                  buttonText: 'Logout',
                  onTap: () => context.read<LogoutCubit>()..removeUser(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
