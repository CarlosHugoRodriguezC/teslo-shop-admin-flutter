import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/presentation/providers/products_repository_provider.dart';

final productProvider = StateNotifierProvider.autoDispose
    .family<ProductNotifier, ProductState, String>(
  (ref, productId) {
    final productsRepository = ref.watch(ProductsRepositoryProvider);

    return ProductNotifier(
      productsRepository: productsRepository,
      productId: productId,
    );
  },
);

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductsRepository productsRepository;
  final String productId;

  ProductNotifier({
    required this.productsRepository,
    required this.productId,
  }) : super(ProductState(id: productId)) {
    loadProduct();
  }

  Future<void> loadProduct() async {
    try {
      state = state.copyWith(isLoading: true);
      final product = await productsRepository.getProduct(productId);
      state = state.copyWith(product: product, isLoading: false);
    } catch (e) {
      print(e);
    }
  }
}

class ProductState {
  final String id;
  final Product? product;
  final bool isLoading;
  final bool isSaving;

  const ProductState({
    required this.id,
    this.product,
    this.isLoading = false,
    this.isSaving = false,
  });

  ProductState copyWith({
    String? id,
    Product? product,
    bool? isLoading,
    bool? isSaving,
  }) {
    return ProductState(
      id: id ?? this.id,
      product: product ?? this.product,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}
