import 'package:canya/common/presentation/screen_banner_image.dart';
import 'package:canya/features/auth/presentation/social_media_button.dart';
import 'package:canya/util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

import '../../../common/routing/router.dart';

class SignInScreen extends HookConsumerWidget with UiLoggy {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const imagePath = 'assets/images/authenticate.png';
    const buttonHeight = 50.0;
    const buttonWidth = 300.0;
    const maxWidth = 700.0;
    return Scaffold(
      appBar: createAppBar(context, 'Sign In'),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 18.0,
          horizontal: 12.0,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 700.0,
              maxWidth: 950.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                spacing: 20.0,
                children: [
                  ScreenBannerImage(
                    height: 250.0,
                    width: maxWidth,
                    imagePath: imagePath,
                  ),

                  Text(
                    'Come on in!',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: buttonHeight,
                    width: buttonWidth,
                    child: SocialMediaButton(
                      label: 'Sign in with Google',
                      imagePath: 'assets/images/google.png',
                      // onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    height: buttonHeight,
                    width: buttonWidth,
                    child: SocialMediaButton(
                      label: 'Sign in with Apple',
                      imagePath: 'assets/images/apple.png',
                      // onPressed: null,
                    ),
                  ),

                  SizedBox(
                    height: buttonHeight,
                    width: buttonWidth,
                    child: SocialMediaButton(
                      label: 'Sign In with Facebook',
                      imagePath:
                          'assets/images/facebook.png',
                      // onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    height: buttonHeight,
                    width: buttonWidth,
                    child: ElevatedButton(
                      onPressed: () => context.goNamed(
                        AppRoute.home.name,
                      ),
                      child: Text('Home'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
