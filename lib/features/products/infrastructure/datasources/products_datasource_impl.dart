import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/environment.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/infrastructure/mappers/product_mapper.dart';

class ProductsDatasourceImpl extends ProductsDataSource {
  late final Dio dio;
  final String token;

  ProductsDatasourceImpl({required this.token})
      : dio = Dio(BaseOptions(
            baseUrl: Environment.apiUrl,
            headers: {'Authorization': "Bearer $token"}));

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    // TODO: implement createUpdateProduct
    throw UnimplementedError();
  }

  @override
  Future<Product> getProduct(String id) {
    // TODO: implement getProduct
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProducts({int limit = 10, int offset = 0}) async {
    final response =
        await dio.get<List>('/products?limit=$limit&offset=$offset');

    final List<Product> products = [];

    for (final product in response.data ?? []) {
      final productMapped = ProductMapper.jsonToEntity(product);
      products.add(productMapped);
    }

    return products;
  }

  @override
  Future<List<Product>> getProductsByTerm(String term) {
    // TODO: implement getProductsByTerm
    throw UnimplementedError();
  }
}
