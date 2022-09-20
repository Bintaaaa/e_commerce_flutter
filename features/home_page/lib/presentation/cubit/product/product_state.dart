part of 'product_cubit.dart';

class ProductState extends Equatable {
  final ViewData<ProductDataEntity> productState;
  const ProductState({required this.productState});

  ProductState copyWith({ViewData<ProductDataEntity>? productState}) =>
      ProductState(
        productState: productState ?? this.productState,
      );

  @override
  List<Object?> get props => [productState];
}
