import 'package:teslo_shop/config/constants/environment.dart';
import 'package:teslo_shop/features/auth/infraestructure/infraestructure.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';

class ProductMapper {
  static Product jsonToEntity(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'] ?? 'title not provided',
      price: double.parse((json['price'] ?? 0.0).toString()),
      description: json['description'] ?? 'description not provided',
      slug: json['slug'] ?? 'slug not provided',
      stock: json['stock'] ?? 0,
      gender: json['gender'] ?? 'getnder not provided',
      sizes: List<String>.from(json['sizes'].map((size) => size) ?? []),
      images: List<String>.from(json['images'].map(
            (image) => image.startsWith('http')
                ? image
                : '${Environment.apiUrl}/files/product/$image',
          ) ??
          []),
      tags: List<String>.from(json['tags'].map((tag) => tag) ?? []),
      user: UserMapper.jsonToEntity(json['user']),
    );
  }
}
