// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../view_model/onboarding_cubit.dart';
// import '../view_model/onboarding_state.dart';
//
// class OnboardingScreenView extends StatelessWidget {
//   const OnboardingScreenView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<OnboardingCubit>(
//           create: (_) => OnboardingCubit(),
//         ),
//       ],
//       child: const OnboardingScreenContent(),
//     );
//   }
// }
//
// class OnboardingScreenContent extends StatelessWidget {
//   const OnboardingScreenContent({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<OnboardingCubit>();
//
//     return BlocBuilder<OnboardingCubit, OnboardingState>(
//       builder: (context, state) {
//         return Scaffold(
//           body: Stack(
//             children: [
//               PageView.builder(
//                 controller: cubit.pageController,
//                 itemCount: state.slides.length,
//                 onPageChanged: cubit.updatePage,
//                 itemBuilder: (context, index) => Stack(
//                   children: [
//                     _buildBackgroundImage(state.slides[index]["image"]!),
//                     _buildSlideContent(context, index, state.slides),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildBackgroundImage(String imagePath) {
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage(imagePath),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Container(
//         color: Colors.black.withOpacity(0.6),
//       ),
//     );
//   }
//
//   Widget _buildSlideContent(
//       BuildContext context, int index, List<Map<String, String>> slides) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               slides[index]["title"]!,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               slides[index]["description"]!,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontSize: 18,
//                 color: Colors.white70,
//               ),
//             ),
//             const SizedBox(height: 40),
//             _buildBreadcrumb(context, slides.length),
//             const SizedBox(height: 40),
//             _buildNavigationButtons(context, index, slides.length),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBreadcrumb(BuildContext context, int totalSlides) {
//     final currentPage = context.watch<OnboardingCubit>().state.currentPage;
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(totalSlides, (index) {
//         return Container(
//           width: index == currentPage ? 24 : 10,
//           height: 4,
//           margin: const EdgeInsets.symmetric(horizontal: 4),
//           decoration: BoxDecoration(
//             color: index == currentPage ? Colors.white : Colors.grey,
//             borderRadius: BorderRadius.circular(2),
//           ),
//         );
//       }),
//     );
//   }
//
//   Widget _buildNavigationButtons(
//       BuildContext context, int index, int totalSlides) {
//     final cubit = context.read<OnboardingCubit>();
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         if (index > 0)
//           ElevatedButton(
//             onPressed: cubit.previousPage,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.transparent,
//               shadowColor: Colors.transparent,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12.0),
//               ),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: const [
//                 Icon(
//                   Icons.arrow_back_ios,
//                   color: Colors.white,
//                   size: 18,
//                 ),
//                 SizedBox(width: 8),
//                 Text(
//                   'Back',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ElevatedButton(
//           onPressed: () {
//             if (index == totalSlides - 1) {
//               cubit.completeOnboarding(context);
//             } else {
//               cubit.nextPage();
//             }
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.transparent,
//             shadowColor: Colors.transparent,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12.0),
//             ),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 index == totalSlides - 1 ? 'Login' : 'Next',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white,
//                 ),
//               ),
//               const SizedBox(width: 8),
//               const Icon(
//                 Icons.arrow_forward_ios,
//                 color: Colors.white,
//                 size: 18,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
