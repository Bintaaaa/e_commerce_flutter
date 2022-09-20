import 'package:common/utils/constants/app_constants.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:product/data/datasource/remote/product_remote_datasource.dart';
import 'package:product/data/mapper/product_mapper.dart';
import 'package:product/domain/entity/product_entity.dart';
import 'package:product/domain/entity/product_category_entity.dart';
import 'package:product/domain/entity/banner_data_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:product/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductMapper productMapper;
  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.productMapper,
  });

  @override
  Future<Either<FailureResponse, List<BannerDataEntity>>> getBanner() async {
    try {
      final response = await remoteDataSource.getBanner();
      return Right(
        productMapper.mapBannerDataDTOToEntity(response.data!),
      );
    } on DioError catch (error) {
      return Left(
        FailureResponse(
          errorMessage:
              error.response?.data[AppConstants.errorKey.message]?.toString() ??
                  error.response.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, List<ProductCategoryEntity>>>
      getProductCategory() async {
    try {
      final response = await remoteDataSource.getProductCategory();
      return Right(
        productMapper.mapProductCategoryDTOtoEntity(
          response.data!,
        ),
      );
    } on DioError catch (error) {
      return Left(
        FailureResponse(
          errorMessage:
              error.response?.data[AppConstants.errorKey.message]?.toString() ??
                  error.response.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, ProductDataEntity>> getProduct() async {
    try {
      final response = await remoteDataSource.getProduct();
      return Right(
        productMapper.mapProductDataDTOToProductDataEntity(response.data!),
      );
    } on DioError catch (error) {
      return Left(
        FailureResponse(
          errorMessage:
              error.response?.data[AppConstants.errorKey.message]?.toString() ??
                  error.response.toString(),
        ),
      );
    }
  }
}
