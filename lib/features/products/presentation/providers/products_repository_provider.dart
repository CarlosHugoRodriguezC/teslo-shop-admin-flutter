import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/infrastructure/infrastructure.dart';

final ProductsRepositoryProvider = Provider<ProductsRepository>((ref) {
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final productsRepository = ProductsRepositoryImpl(
    productsDataSource: ProductsDatasourceImpl(
      token: accessToken,
    ),
  );

  return productsRepository;
});
