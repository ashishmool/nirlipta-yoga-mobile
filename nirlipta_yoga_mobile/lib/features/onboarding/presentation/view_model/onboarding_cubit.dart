// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../auth/presentation/view_model/login/login_bloc.dart';
// import 'onboarding_state.dart';
//
// class OnboardingCubit extends Cubit<OnboardingState> {
//   final PageController pageController = PageController();
//   final LoginBloc loginBloc;
//
//
//   OnboardingCubit(this.loginBloc)
//       : super(
//           OnboardingState(
//             slides: const [
//               {
//                 "image": "assets/images/onboarding-1.jpg",
//                 "title": "Welcome to Nirlipta Yoga!",
//                 "description":
//                     "Begin your journey toward balance, mindfulness, and well-being.",
//               },
//               {
//                 "image": "assets/images/onboarding-2.jpg",
//                 "title": "Transform Your Mind",
//                 "description":
//                     "Discover peace and inner strength in every breath you take.",
//               },
//             ],
//           ),
//         );
//
//   void updatePage(int index) {
//     emit(state.copyWith(currentPage: index));
//   }
//
//   void nextPage() {
//     pageController.nextPage(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void previousPage() {
//     pageController.previousPage(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void completeOnboarding() {
//     loginBloc.add(LoginEventNavigate());
//     emit(OnboardingCompleted());
//   }
// }
