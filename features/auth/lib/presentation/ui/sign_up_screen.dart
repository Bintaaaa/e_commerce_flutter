import 'package:auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:auth/presentation/bloc/sign_up/sign_up_event.dart';
import 'package:authentication/domain/entity/body/auth_request_entity.dart';
import 'package:common/utils/constants/app_constants.dart';
import 'package:common/utils/navigation/router/auth_router.dart';
import 'package:component/widget/button/custom_button.dart';
import 'package:component/widget/stack/loading_stack.dart';
import 'package:component/widget/text_field/custom_text_field.dart';
import 'package:component/widget/toast/custom_toast.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/flutter_screenutil/flutter_screenutil.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:resources/colors.gen.dart';
import 'package:common/utils/state/view_data_state.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final AuthRouter authRouter = sl();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmationPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: IconButton(
            onPressed: () => authRouter.goBack(),
            icon: const Icon(Icons.arrow_back),
            color: ColorName.orange,
          ),
        ),
        elevation: 0.0,
        title: Text(
          "Daftar",
          style: TextStyle(
            color: ColorName.orange,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          final status = state.signUpState.status;
          if (status.isHasData) {
            authRouter.navigateToHome();
          }

          if (status.isError) {
            if (state.signUpState.message != AppConstants.errorKey.username &&
                state.signUpState.message != AppConstants.errorKey.password &&
                state.signUpState.message !=
                    AppConstants.errorKey.confirmPassword) {
              CustomToast.showErrorToast(
                errorMessage: state.signUpState.message,
              );
            }
          }
        },
        builder: (context, state) {
          final status = state.signUpState.status;
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
                  "Daftar",
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
                  errorText: state.signUpState.message ==
                          AppConstants.errorKey.username
                      ? state.signUpState.failure!.errorMessage
                      : "",
                  onChanged: (value) => {
                    context.read<SignUpBloc>()
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
                  errorText: state.signUpState.message ==
                          AppConstants.errorKey.password
                      ? state.signUpState.failure!.errorMessage
                      : "",
                  onChanged: (value) => {
                    context.read<SignUpBloc>()
                      ..add(
                        PasswordChange(
                          password: passwordController.text,
                        ),
                      )
                  },
                ),
                CustomTextField(
                  labelText: "Confirm Password",
                  controller: confirmationPasswordController,
                  obscureText: true,
                  errorText: state.signUpState.message ==
                          AppConstants.errorKey.confirmPassword
                      ? state.signUpState.failure!.errorMessage
                      : "",
                  onChanged: (value) => {
                    context.read<SignUpBloc>()
                      ..add(
                        ConfirmPassword(
                          confirmPassword: value,
                          password: passwordController.text,
                        ),
                      )
                  },
                ),
                SizedBox(
                  height: 128.h,
                ),
                CustomButton(
                  buttonText: "Daftar",
                  onTap: () => context.read<SignUpBloc>()
                    ..add(
                      SignUp(
                        authRequestEntity: AuthRequestEntity(
                          password: passwordController.text,
                          username: usernameController.text,
                        ),
                      ),
                    ),
                ),
                SizedBox(
                  height: 34.h,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
