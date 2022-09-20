import 'package:authentication/di/dependency.dart';
import 'package:common/utils/di/common_dependencies.dart';
import 'package:core/di/dependency.dart';
import 'package:dependencies/di/dependency.dart';
import 'package:product/di/product_dependencies.dart';
import 'package:profile/di/depedency.dart';

class Injections {
  Future<void> initialize() async {
    await _registerSharedDependencies();
    _registerDomains();
  }

  void _registerDomains() {
    AuthenticationDependency();
    ProductDependencies();
    ProfileDepedency();
  }

  Future<void> _registerSharedDependencies() async {
    await const SharedLibDependencies().registerCore();
    RegisterCoreModule();
    CommonDependencies();
  }
}
