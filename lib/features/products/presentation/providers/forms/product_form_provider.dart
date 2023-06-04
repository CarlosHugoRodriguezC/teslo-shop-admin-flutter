import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/shared/infrastructure/inputs/inputs.dart';

final productFormProvider = StateNotifierProvider.autoDispose
    .family<ProductFormNotifier, ProductFormState, Product>((ref, product) {
  //TODO: Create on submitcallback
  return ProductFormNotifier(product: product);
});

class ProductFormNotifier extends StateNotifier<ProductFormState> {
  final void Function(Map<String, dynamic> productLike)? onSubmitCallback;

  ProductFormNotifier({
    this.onSubmitCallback,
    required Product product,
  }) : super(ProductFormState(
          id: product.id,
          title: Title.dirty(product.title),
          slug: Slug.dirty(product.slug),
          price: Price.dirty(product.price),
          inStock: Stock.dirty(product.stock),
          sizes: product.sizes,
          gender: product.gender,
          description: product.description,
          tags: product.tags.join(', '),
          images: product.images,
        ));

  Future<bool> onFormSubmit() async {
    _touchedEverything();
    if (!state.isformValid) return false;

    if (onSubmitCallback == null) return false;

    final Map<String, dynamic> productLike = {
      "id": state.id,
      "title": state.title.value,
      "slug": state.slug.value,
      "price": state.price.value,
      "stock": state.inStock.value,
      "sizes": state.sizes,
      "gender": state.gender,
      "description": state.description,
      "tags": state.tags.split(', '),
      "images": state.images
          .map((image) =>
              image.replaceAll("${Environment.apiUrl}/files/product/", ''))
          .toList(),
    };

    return true;

    // TODO: call on submit callback
  }

  void _touchedEverything() {
    state = state.copyWith(
        isformValid: Formz.validate(
      [
        Title.dirty(state.title.value),
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ],
    ));
  }

  void onTitleChanged(String value) {
    state = state.copyWith(
        title: Title.dirty(value),
        isformValid: Formz.validate([
          Title.dirty(value),
          Slug.dirty(state.slug.value),
          Price.dirty(state.price.value),
          Stock.dirty(state.inStock.value),
        ]));
  }

  void onSlugChanged(String value) {
    state = state.copyWith(
        slug: Slug.dirty(value),
        isformValid: Formz.validate([
          Slug.dirty(value),
          Title.dirty(state.title.value),
          Price.dirty(state.price.value),
          Stock.dirty(state.inStock.value),
        ]));
  }

  void onPriceChanged(double value) {
    state = state.copyWith(
        price: Price.dirty(value),
        isformValid: Formz.validate([
          Price.dirty(value),
          Title.dirty(state.slug.value),
          Slug.dirty(state.slug.value),
          Stock.dirty(state.inStock.value),
        ]));
  }

  void onStockChanged(int value) {
    state = state.copyWith(
        inStock: Stock.dirty(value),
        isformValid: Formz.validate([
          Stock.dirty(value),
          Title.dirty(state.slug.value),
          Slug.dirty(state.slug.value),
          Price.dirty(state.price.value),
        ]));
  }

  void onSizesChanged(List<String> sizes) {
    state = state.copyWith(
      sizes: sizes,
    );
  }

  void onGenderChanged(String gender) {
    state = state.copyWith(gender: gender);
  }

  void onDescriptionChanged(String description) {
    state = state.copyWith(description: description);
  }

  void onTagsChanged(String tags) {
    state = state.copyWith(tags: tags);
  }
}

class ProductFormState {
  final bool isformValid;
  final String? id;
  final Title title;
  final Slug slug;
  final Price price;
  final List<String> sizes;
  final String gender;
  final Stock inStock;
  final String? description;
  final String tags;
  final List<String> images;

  ProductFormState({
    this.isformValid = false,
    this.id = '',
    this.title = const Title.dirty(''),
    this.slug = const Slug.dirty(''),
    this.price = const Price.dirty(0.0),
    this.sizes = const [],
    this.gender = '',
    this.inStock = const Stock.dirty(0),
    this.description = '',
    this.tags = '',
    this.images = const [],
  });

  ProductFormState copyWith({
    bool? isformValid,
    String? id,
    Title? title,
    Slug? slug,
    Price? price,
    List<String>? sizes,
    String? gender,
    Stock? inStock,
    String? description,
    String? tags,
    List<String>? images,
  }) =>
      ProductFormState(
        isformValid: isformValid ?? this.isformValid,
        id: id ?? this.id,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        price: price ?? this.price,
        sizes: sizes ?? this.sizes,
        gender: gender ?? this.gender,
        inStock: inStock ?? this.inStock,
        description: description ?? this.description,
        tags: tags ?? this.tags,
        images: images ?? this.images,
      );
}
