import 'package:dependencies/get_it/get_it.dart';
import 'package:product/data/datasource/remote/product_remote_datasource.dart';
import 'package:product/data/mapper/product_mapper.dart';
import 'package:product/data/repository/product_repository_impl.dart';
import 'package:product/domain/repository/product_repository.dart';
import 'package:product/domain/usecase/get_banner_usecase.dart';
import 'package:product/domain/usecase/get_prodcut_category_usecase.dart';
import 'package:product/domain/usecase/get_product_usecase.dart';

class ProductDependencies {
  ProductDependencies() {
    _registerDataSource();
    _registerMapper();
    _registerRepository();
    _resgisterUserCase();
  }

  _registerDataSource() => sl.registerLazySingleton<ProductRemoteDataSource>(
        () => ProductRemoteDataSourceImpl(
          dio: sl(),
        ),
      );
  _registerMapper() => sl.registerLazySingleton<ProductMapper>(
        () => ProductMapper(),
      );
  _registerRepository() => sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(
          remoteDataSource: sl(),
          productMapper: sl(),
        ),
      );
  _resgisterUserCase() {
    sl.registerLazySingleton<GetBannerUseCase>(
      () => GetBannerUseCase(
        productRepository: sl(),
      ),
    );
    sl.registerLazySingleton<GetProductUseCase>(
      () => GetProductUseCase(
        productRepository: sl(),
      ),
    );
    sl.registerLazySingleton<GetProductCategoryUseCase>(
      () => GetProductCategoryUseCase(
        productRepository: sl(),
      ),
    );
  }
}
