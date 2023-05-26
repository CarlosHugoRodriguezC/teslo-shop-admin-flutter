import 'package:teslo_shop/features/products/domain/domain.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  final ProductsDataSource productsDataSource;

  ProductsRepositoryImpl({required this.productsDataSource});
  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    return productsDataSource.createUpdateProduct(productLike);
  }

  @override
  Future<Product> getProduct(String id) {
    return productsDataSource.getProduct(id);
  }

  @override
  Future<List<Product>> getProducts({int limit = 10, int offset = 0}) {
    return productsDataSource.getProducts(limit: limit, offset: offset);
  }

  @override
  Future<List<Product>> getProductsByTerm(String term) {
    return productsDataSource.getProductsByTerm(term);
  }
}
