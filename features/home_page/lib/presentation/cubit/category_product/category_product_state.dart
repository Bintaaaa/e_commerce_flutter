part of 'category_product_cubit.dart';

class CategoryProductState extends Equatable {
  final ViewData<List<ProductCategoryEntity>> productCategoryState;
  const CategoryProductState({
    required this.productCategoryState,
  });

  CategoryProductState copyWith({
    ViewData<List<ProductCategoryEntity>>? productCategoryState,
  }) =>
      CategoryProductState(
        productCategoryState: productCategoryState ?? this.productCategoryState,
      );
  @override
  List<Object?> get props => [productCategoryState];
}
