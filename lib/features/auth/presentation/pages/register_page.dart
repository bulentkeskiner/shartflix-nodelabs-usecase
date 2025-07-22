import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shartflix/core/app/app_assets_constants.dart';
import 'package:shartflix/core/app/app_validator.dart';
import 'package:shartflix/core/components/button/primary_button.dart';
import 'package:shartflix/core/enum/route_type.dart';
import 'package:shartflix/core/resources/data_state.dart';
import 'package:shartflix/core/theme/constants/app_colors.dart';
import 'package:shartflix/core/theme/theme_data/app_style.dart';
import 'package:shartflix/core/util/context_extension.dart';
import 'package:shartflix/di_helper.dart';
import 'package:shartflix/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shartflix/features/auth/presentation/bloc/auth_event.dart';
import 'package:shartflix/support/app_lang.dart';

// Kayıt Sayfası
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController(text: "demo1");
  final TextEditingController emailController = TextEditingController(
    text: "demo1@nodelabs.com",
  );
  final TextEditingController passwordController = TextEditingController(text: "123456");
  final TextEditingController confirmPasswordController = TextEditingController(
    text: "123456",
  );
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, DataState>(
      listener: (context, state) {
        if (state is DataFailed) {
          context.hideLoader();
          context.showDefaultSnackbar(lang(state.error));
        } else if (state is DataLoading) {
          context.showLoader();
        } else {
          context.hideLoader();
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(34),
                    child: Column(
                      children: [
                        Text(
                          lang(LocaleKeys.welcome),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          lang(LocaleKeys.lorem),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        SizedBox(height: 40),

                        // Name Input
                        TextFormField(
                          validator: AppValidator.instance.nameValidator,
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: lang(LocaleKeys.nameSurname),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 18, right: 8),
                              child: Image.asset(
                                AssetsConstants.addUserIcon,
                                width: 15,
                                height: 15,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Email Input
                        TextFormField(
                          controller: emailController,
                          validator: AppValidator.instance.emailValidator,
                          decoration: InputDecoration(
                            hintText: lang(LocaleKeys.emailPlaceholder),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 18, right: 8),
                              child: Image.asset(
                                AssetsConstants.message,
                                width: 15,
                                height: 15,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Password Input
                        TextFormField(
                          controller: passwordController,
                          validator: AppValidator.instance.passwordValidator,
                          obscureText: obscurePassword,
                          decoration: InputDecoration(
                            hintText: lang(LocaleKeys.passwordPlaceholder),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 18, right: 8),
                              child: Image.asset(
                                AssetsConstants.unlock,
                                width: 15,
                                height: 15,
                              ),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 20.0),
                              child: Image.asset(
                                AssetsConstants.hide,
                                width: 15,
                                height: 15,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Confirm Password Input
                        TextFormField(
                          controller: confirmPasswordController,
                          validator: AppValidator.instance.confirmValidator(
                            passwordController,
                          ),
                          obscureText: obscureConfirmPassword,
                          decoration: InputDecoration(
                            fillColor: Colors.grey[900],
                            hintText: lang(LocaleKeys.confirmPasswordPlaceholder),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 18, right: 8),
                              child: Image.asset(
                                AssetsConstants.unlock,
                                width: 15,
                                height: 15,
                              ),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 20.0),
                              child: Image.asset(
                                AssetsConstants.hide,
                                width: 15,
                                height: 15,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 30),

                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.grey[400], fontSize: 14),
                            children: [
                              TextSpan(text: lang(LocaleKeys.termsPart1)),
                              TextSpan(
                                text: lang(LocaleKeys.termsPart2),
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(text: lang(LocaleKeys.termsPart3)),
                            ],
                          ),
                        ),

                        SizedBox(height: 32),

                        PrimaryButton(
                          title: lang(LocaleKeys.registerButton),
                          onPressed: () => onRegisterTap(),
                        ),

                        SizedBox(height: 30),

                        // Social Login Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _socialButton(AssetsConstants.google),
                            SizedBox(width: 16),
                            _socialButton(AssetsConstants.apple),
                            SizedBox(width: 16),
                            _socialButton(AssetsConstants.facebook),
                          ],
                        ),

                        SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              lang(LocaleKeys.alreadyHaveAccountQuestion),
                              style: AppStyles.alreadyText,
                            ),
                            TextButton(
                              onPressed: () => navigateToLogin(),
                              child: Text(
                                lang(LocaleKeys.loginHere),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _socialButton(String assetName) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(18),
        border: BoxBorder.all(color: AppColors.borderColor),
      ),
      child: Center(child: Image.asset(assetName, width: 20, height: 20)),
    );
  }

  // MARK: Actions
  onRegisterTap() {
    if (formKey.currentState?.validate() != true) return;

    sl<AuthBloc>().add(
      RegisterSubmitted(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      ),
    );
  }

  navigateToLogin() {
    context.go(RouteType.login.name);
  }
}
