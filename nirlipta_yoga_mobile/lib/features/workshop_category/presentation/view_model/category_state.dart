part of 'category_bloc.dart';

class CategoryState {
  final List<CategoryEntity> categories;
  final bool isLoading;
  final String? error;
  final bool isImageLoading;
  final bool isImageSuccess;
  final String? imageName;

  CategoryState({
    required this.categories,
    required this.isLoading,
    this.error,
    required this.isImageLoading,
    required this.isImageSuccess,
    this.imageName,
  });

  factory CategoryState.initial() {
    return CategoryState(
      categories: [],
      isLoading: false,
      isImageLoading: false,
      isImageSuccess: false,
      imageName: null,
    );
  }

  CategoryState copyWith({
    List<CategoryEntity>? categories,
    bool? isLoading,
    String? error,
    bool? isImageLoading,
    bool? isImageSuccess,
    String? imageName,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isImageLoading: isImageLoading ?? this.isImageLoading,
      isImageSuccess: isImageSuccess ?? this.isImageSuccess,
      imageName: imageName ?? this.imageName,
    );
  }

  @override
  List<Object?> get props =>
      [categories, isLoading, error, isImageLoading, isImageSuccess, imageName];
}
