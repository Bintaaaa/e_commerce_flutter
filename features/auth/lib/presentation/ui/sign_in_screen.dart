import 'package:auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:authentication/domain/entity/body/auth_request_entity.dart';
import 'package:common/utils/constants/app_constants.dart';
import 'package:common/utils/navigation/router/auth_router.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:component/widget/button/custom_button.dart';
import 'package:component/widget/stack/loading_stack.dart';
import 'package:component/widget/text_field/custom_text_field.dart';
import 'package:component/widget/toast/custom_toast.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:resources/colors.gen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  final AuthRouter authRouter = sl();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          final status = state.signInState.status;
          if (status.isHasData) {
            authRouter.navigateToHome();
          }

          if (status.isError) {
            if (state.signInState.message != AppConstants.errorKey.username &&
                state.signInState.message != AppConstants.errorKey.password &&
                state.signInState.message !=
                    AppConstants.errorKey.confirmPassword) {
              CustomToast.showErrorToast(
                errorMessage: state.signInState.message,
              );
            }
          }
        },
        builder: (context, state) {
          final status = state.signInState.status;
          return LoadingStack(
            isLoading: status.isLoading,
            widget: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              children: [
                SizedBox(
                  height: 124.h,
                ),
                Text(
                  "Masuk",
                  style: TextStyle(
                    color: ColorName.orange,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 43.h,
                ),
                CustomTextField(
                  labelText: "Username",
                  controller: usernameController,
                  textInputType: TextInputType.name,
                  errorText: state.signInState.message ==
                          AppConstants.errorKey.username
                      ? state.signInState.failure!.errorMessage
                      : "",
                  onChanged: (value) => {
                    context.read<SignInBloc>()
                      ..add(
                        UsernameChange(
                          username: usernameController.text,
                        ),
                      )
                  },
                ),
                CustomTextField(
                  labelText: "Password",
                  controller: passwordController,
                  obscureText: true,
                  errorText: state.signInState.message ==
                          AppConstants.errorKey.password
                      ? state.signInState.failure!.errorMessage
                      : "",
                  onChanged: (value) => {
                    context.read<SignInBloc>()
                      ..add(
                        PasswordChange(
                          password: passwordController.text,
                        ),
                      )
                  },
                ),
                SizedBox(
                  height: 128.h,
                ),
                CustomButton(
                  buttonText: "Masuk",
                  onTap: () => context.read<SignInBloc>()
                    ..add(
                      SignIn(
                        authRequestEntity: AuthRequestEntity(
                          username: usernameController.text,
                          password: passwordController.text,
                        ),
                      ),
                    ),
                ),
                SizedBox(
                  height: 34.h,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Belum punya akun? ',
                      style: TextStyle(
                        color: ColorName.textLightGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Daftar',
                          style: TextStyle(
                            color: ColorName.textBlack,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => authRouter.navigateToSignUp(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
