import 'package:teslo_shop/features/products/domain/entities/product.dart';

abstract class ProductsDataSource {
  Future<List<Product>> getProducts({int limit = 10, int offset = 0});
  Future<Product> getProduct(String id);
  Future<List<Product>> getProductsByTerm(String term);
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike);
}
