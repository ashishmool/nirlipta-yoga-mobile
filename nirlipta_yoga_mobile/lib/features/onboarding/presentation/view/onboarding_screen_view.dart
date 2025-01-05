import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/di.dart';
import '../../../auth/presentation/view_model/login/login_bloc.dart';
import '../view_model/onboarding_cubit.dart';

class OnboardingScreenView extends StatelessWidget {
  const OnboardingScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => getIt<LoginBloc>(),
        ),
        BlocProvider<OnboardingCubit>(
          create: (context) => OnboardingCubit(
            loginBloc: context.read<LoginBloc>(),
          ),
        ),
      ],
      child: const OnboardingScreenContent(),
    );
  }
}

class OnboardingScreenContent extends StatelessWidget {
  const OnboardingScreenContent({super.key});

  final List<Map<String, String>> _slides = const [
    {
      "image": "assets/images/onboarding-1.jpg",
      "title": "Welcome to Nirlipta Yoga!",
      "description":
          "Begin your journey toward balance, mindfulness, and well-being.",
    },
    {
      "image": "assets/images/onboarding-2.jpg",
      "title": "Transform Your Mind",
      "description":
          "Discover peace and inner strength in every breath you take.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: cubit.pageController,
            itemCount: _slides.length,
            onPageChanged: cubit.updatePage,
            // Call the public method instead of emit
            itemBuilder: (context, index) => Stack(
              children: [
                _buildBackgroundImage(_slides[index]["image"]!),
                _buildSlideContent(context, index),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black.withValues(alpha: .6),
      ),
    );
  }

  Widget _buildSlideContent(BuildContext context, int index) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _slides[index]["title"]!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _slides[index]["description"]!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 40),
            _buildBreadcrumb(context, _slides.length),
            const SizedBox(height: 40),
            _buildNavigationButtons(context, index, _slides.length),
          ],
        ),
      ),
    );
  }

  Widget _buildBreadcrumb(BuildContext context, int totalSlides) {
    final currentPage = context.watch<OnboardingCubit>().state;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSlides, (index) {
        return Container(
          width: index == currentPage ? 24 : 10,
          height: 4,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: index == currentPage ? Colors.white : Colors.grey,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }

  Widget _buildNavigationButtons(
      BuildContext context, int index, int totalSlides) {
    final cubit = context.read<OnboardingCubit>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (index > 0)
          ElevatedButton(
            onPressed: cubit.previousPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(width: 8),
                Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ElevatedButton(
          onPressed: () => cubit.nextPage(context, totalSlides),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                index == totalSlides - 1 ? 'Login' : 'Next',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
