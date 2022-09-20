import 'package:bloc/bloc.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/equatable/equatable.dart';
import 'package:product/domain/entity/product_category_entity.dart';
import 'package:product/domain/usecase/get_prodcut_category_usecase.dart';

part 'category_product_state.dart';

class CategoryProductCubit extends Cubit<CategoryProductState> {
  final GetProductCategoryUseCase productCategoryUseCase;
  CategoryProductCubit({
    required this.productCategoryUseCase,
  }) : super(
          CategoryProductState(
            productCategoryState: ViewData.loading(),
          ),
        );

  void getProductCategory() async {
    final result = await productCategoryUseCase.call(
      const NoParams(),
    );

    result.fold(
      (failure) => emit(
        CategoryProductState(
          productCategoryState: ViewData.error(
            message: failure.errorMessage,
            failure: failure,
          ),
        ),
      ),
      (result) => emit(
        CategoryProductState(
          productCategoryState: ViewData.loaded(
            data: result,
          ),
        ),
      ),
    );
  }
}
