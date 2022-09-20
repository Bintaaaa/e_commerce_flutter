import 'package:common/utils/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:product/domain/entity/banner_data_entity.dart';
import 'package:product/domain/entity/product_category_entity.dart';
import 'package:product/domain/entity/product_entity.dart';

abstract class ProductRepository {
  const ProductRepository();

  Future<Either<FailureResponse, List<ProductCategoryEntity>>>
      getProductCategory();
  Future<Either<FailureResponse, ProductDataEntity>> getProduct();
  Future<Either<FailureResponse, List<BannerDataEntity>>> getBanner();
}
