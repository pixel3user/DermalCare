import '/components/modals/skincare_tips_modal/skincare_tips_modal_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class SkincareTipsModalModel extends FlutterFlowModel<SkincareTipsModalWidget> {
  String selectedCategory = 'daily';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  void selectCategory(String category) {
    selectedCategory = category;
    onUpdate();
  }

  void onUpdate() {
    // This method is called when the model needs to notify listeners
  }

  List<Map<String, dynamic>> getTipsForCategory(String category) {
    switch (category) {
      case 'daily':
        return [
          {
            'title': 'Morning Cleansing Routine',
            'description': 'Start your day with a gentle cleanser to remove overnight buildup and prepare your skin for the day.',
            'icon': Icons.wb_sunny,
            'steps': [
              'Use lukewarm water to wet your face',
              'Apply a gentle cleanser in circular motions',
              'Rinse thoroughly with cool water',
              'Pat dry with a clean towel'
            ],
          },
          {
            'title': 'Hydration is Key',
            'description': 'Keep your skin hydrated throughout the day with the right moisturizer for your skin type.',
            'icon': Icons.water_drop,
            'steps': [
              'Choose a moisturizer suitable for your skin type',
              'Apply while skin is still slightly damp',
              'Use upward strokes for better absorption',
              'Don\'t forget your neck and décolletage'
            ],
          },
        ];
      case 'aging':
        return [
          {
            'title': 'Retinol Night Routine',
            'description': 'Incorporate retinol into your nighttime routine to combat signs of aging.',
            'icon': Icons.nights_stay,
            'steps': [
              'Start with a low concentration (0.25%)',
              'Apply every other night initially',
              'Always follow with moisturizer',
              'Use sunscreen during the day'
            ],
          },
          {
            'title': 'Antioxidant Protection',
            'description': 'Protect your skin from free radical damage with antioxidant-rich products.',
            'icon': Icons.shield,
            'steps': [
              'Apply vitamin C serum in the morning',
              'Look for products with vitamin E',
              'Consider green tea extracts',
              'Always layer under sunscreen'
            ],
          },
        ];
      case 'acne':
        return [
          {
            'title': 'Gentle Acne Treatment',
            'description': 'Treat acne effectively without over-drying or irritating your skin.',
            'icon': Icons.healing,
            'steps': [
              'Use salicylic acid or benzoyl peroxide',
              'Start with lower concentrations',
              'Apply only to affected areas',
              'Moisturize to prevent over-drying'
            ],
          },
          {
            'title': 'Non-Comedogenic Products',
            'description': 'Choose products that won\'t clog pores and cause breakouts.',
            'icon': Icons.check_circle,
            'steps': [
              'Look for "non-comedogenic" labels',
              'Avoid heavy, oil-based products',
              'Choose lightweight, gel-based formulas',
              'Test new products on a small area first'
            ],
          },
        ];
      case 'hydration':
        return [
          {
            'title': 'Deep Hydration Techniques',
            'description': 'Achieve optimal skin hydration with these proven methods.',
            'icon': Icons.opacity,
            'steps': [
              'Apply hyaluronic acid on damp skin',
              'Use a humidifier in dry environments',
              'Drink plenty of water throughout the day',
              'Consider overnight hydrating masks'
            ],
          },
        ];
      case 'sun':
        return [
          {
            'title': 'Daily Sun Protection',
            'description': 'Protect your skin from harmful UV rays every single day.',
            'icon': Icons.wb_sunny,
            'steps': [
              'Apply SPF 30+ sunscreen daily',
              'Reapply every 2 hours when outdoors',
              'Use broad-spectrum protection',
              'Don\'t forget ears, neck, and hands'
            ],
          },
        ];
      case 'night':
        return [
          {
            'title': 'Nighttime Repair Routine',
            'description': 'Help your skin repair and regenerate while you sleep.',
            'icon': Icons.bedtime,
            'steps': [
              'Double cleanse to remove all makeup',
              'Apply night cream or treatment',
              'Use a silk pillowcase',
              'Get 7-8 hours of quality sleep'
            ],
          },
        ];
      default:
        return [];
    }
  }
}
