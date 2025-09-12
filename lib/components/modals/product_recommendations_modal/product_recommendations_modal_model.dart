import '/components/modals/product_recommendations_modal/product_recommendations_modal_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class ProductRecommendationsModalModel extends FlutterFlowModel<ProductRecommendationsModalWidget> {
  String selectedSkinType = '';
  List<String> selectedConcerns = [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  void selectSkinType(String type) {
    selectedSkinType = type;
    onUpdate();
  }

  void toggleConcern(String concern) {
    if (selectedConcerns.contains(concern)) {
      selectedConcerns.remove(concern);
    } else {
      selectedConcerns.add(concern);
    }
    onUpdate();
  }

  void onUpdate() {
    // This method is called when the model needs to notify listeners
  }

  List<Map<String, dynamic>> getRecommendedProducts() {
    if (selectedSkinType.isEmpty) return [];

    List<Map<String, dynamic>> products = [];

    // Base products for each skin type
    switch (selectedSkinType) {
      case 'oily':
        products.addAll([
          {
            'name': 'Oil-Free Cleanser',
            'brand': 'Cetaphil',
            'description': 'Gentle cleanser that removes excess oil without over-drying',
            'price': '\$12.99',
            'rating': '4.5★',
            'icon': Icons.cleaning_services,
          },
          {
            'name': 'Salicylic Acid Toner',
            'brand': 'The Ordinary',
            'description': 'Unclogs pores and reduces oil production',
            'price': '\$7.20',
            'rating': '4.3★',
            'icon': Icons.opacity,
          },
        ]);
        break;
      case 'dry':
        products.addAll([
          {
            'name': 'Hydrating Cleanser',
            'brand': 'CeraVe',
            'description': 'Creamy cleanser that maintains skin\'s natural moisture',
            'price': '\$14.99',
            'rating': '4.6★',
            'icon': Icons.water_drop,
          },
          {
            'name': 'Rich Moisturizer',
            'brand': 'Eucerin',
            'description': 'Intensive hydration for very dry skin',
            'price': '\$18.99',
            'rating': '4.4★',
            'icon': Icons.spa,
          },
        ]);
        break;
      case 'combination':
        products.addAll([
          {
            'name': 'Balancing Cleanser',
            'brand': 'Neutrogena',
            'description': 'Cleanses oily T-zone while hydrating dry areas',
            'price': '\$9.99',
            'rating': '4.2★',
            'icon': Icons.balance,
          },
          {
            'name': 'Dual Moisturizer',
            'brand': 'Clinique',
            'description': 'Different formulas for different facial zones',
            'price': '\$28.00',
            'rating': '4.5★',
            'icon': Icons.auto_fix_high,
          },
        ]);
        break;
      case 'sensitive':
        products.addAll([
          {
            'name': 'Gentle Cleanser',
            'brand': 'Avene',
            'description': 'Fragrance-free, hypoallergenic cleanser',
            'price': '\$16.99',
            'rating': '4.7★',
            'icon': Icons.favorite,
          },
          {
            'name': 'Soothing Moisturizer',
            'brand': 'La Roche-Posay',
            'description': 'Calms irritation and strengthens skin barrier',
            'price': '\$22.99',
            'rating': '4.6★',
            'icon': Icons.healing,
          },
        ]);
        break;
      case 'normal':
        products.addAll([
          {
            'name': 'Daily Cleanser',
            'brand': 'Olay',
            'description': 'Maintains skin\'s natural balance',
            'price': '\$8.99',
            'rating': '4.3★',
            'icon': Icons.check_circle,
          },
          {
            'name': 'Light Moisturizer',
            'brand': 'Olay',
            'description': 'Lightweight hydration for normal skin',
            'price': '\$12.99',
            'rating': '4.4★',
            'icon': Icons.wb_sunny,
          },
        ]);
        break;
    }

    // Add concern-specific products
    if (selectedConcerns.contains('acne')) {
      products.add({
        'name': 'Benzoyl Peroxide Treatment',
        'brand': 'PanOxyl',
        'description': 'Targets acne-causing bacteria',
        'price': '\$11.99',
        'rating': '4.1★',
        'icon': Icons.healing,
      });
    }

    if (selectedConcerns.contains('aging')) {
      products.add({
        'name': 'Retinol Serum',
        'brand': 'The Ordinary',
        'description': 'Reduces fine lines and improves texture',
        'price': '\$9.80',
        'rating': '4.4★',
        'icon': Icons.timeline,
      });
    }

    if (selectedConcerns.contains('dark_spots')) {
      products.add({
        'name': 'Vitamin C Serum',
        'brand': 'Mad Hippie',
        'description': 'Brightens skin and fades dark spots',
        'price': '\$25.99',
        'rating': '4.5★',
        'icon': Icons.wb_sunny,
      });
    }

    if (selectedConcerns.contains('dryness')) {
      products.add({
        'name': 'Hyaluronic Acid Serum',
        'brand': 'The Ordinary',
        'description': 'Intense hydration boost',
        'price': '\$7.70',
        'rating': '4.6★',
        'icon': Icons.opacity,
      });
    }

    if (selectedConcerns.contains('sensitivity')) {
      products.add({
        'name': 'Calming Serum',
        'brand': 'Drunk Elephant',
        'description': 'Reduces redness and irritation',
        'price': '\$68.00',
        'rating': '4.3★',
        'icon': Icons.favorite_border,
      });
    }

    if (selectedConcerns.contains('pores')) {
      products.add({
        'name': 'Pore Minimizing Toner',
        'brand': 'Paula\'s Choice',
        'description': 'Refines pores and smooths texture',
        'price': '\$22.00',
        'rating': '4.4★',
        'icon': Icons.radio_button_unchecked,
      });
    }

    return products;
  }
}
