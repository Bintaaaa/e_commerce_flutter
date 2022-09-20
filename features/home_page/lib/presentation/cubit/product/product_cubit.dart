import 'package:bloc/bloc.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/equatable/equatable.dart';
import 'package:product/domain/entity/product_entity.dart';
import 'package:product/domain/usecase/get_product_usecase.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductUseCase getProductUseCase;
  ProductCubit({
    required this.getProductUseCase,
  }) : super(
          ProductState(
            productState: ViewData.loading(),
          ),
        );

  void getProduct() async {
    final result = await getProductUseCase.call(
      const NoParams(),
    );

    result.fold(
      (failure) => emit(
        ProductState(
          productState: ViewData.error(
            message: failure.errorMessage,
            failure: failure,
          ),
        ),
      ),
      (result) => emit(
        ProductState(
          productState: ViewData.loaded(
            data: result,
          ),
        ),
      ),
    );
  }
}
