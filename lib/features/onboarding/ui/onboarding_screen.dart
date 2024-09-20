import 'package:divmeds/features/auth/ui/login/auth_login.dart';
import 'package:divmeds/features/onboarding/ui/intro%20pages/intro_page_1.dart';
import 'package:divmeds/features/onboarding/ui/intro%20pages/intro_page_2.dart';
import 'package:divmeds/features/onboarding/ui/intro%20pages/intro_page_3.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _onboardingPageController = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: _onboardingPageController,
              onPageChanged: (pageIndex) {
                // onPageChanged tracks the current index of the pages.
                // if the the user is on last page then pageIndex == 2 will retyen true & the onLastPage value will be set to true.
                setState(
                  () {
                    onLastPage = (pageIndex == 2);
                  },
                );
              },
              children: const [
                IntroPageOne(),
                IntroPageTwo(),
                IntroPageThree(),
              ],
            ),
            Container(
              alignment: const Alignment(0, 0.70),
              child: SmoothPageIndicator(
                controller: _onboardingPageController,
                count: 3,
              ),
            ),
            Container(
              alignment: const Alignment(0.85, 0.85),
              child: !onLastPage
                  ? TextButton(
                      onPressed: () {
                        _onboardingPageController.jumpToPage(2);
                      },
                      child: const Text("Skip"),
                    )
                  : TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const AuthLoginScreen();
                            },
                          ),
                        );
                      },
                      child: const Text("Log In"),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
