import 'package:flutter/material.dart';
import 'language_service.dart';

class TranslationService {
  static final TranslationService _instance = TranslationService._internal();
  factory TranslationService() => _instance;
  TranslationService._internal();

  // Navigation and UI Elements
  static const Map<String, Map<String, String>> _translations = {
    'app_title': {
      'en': 'DermalCare',
      'zh': '皮肤护理',
    },
    'features': {
      'en': 'Features',
      'zh': '功能',
    },
    'about': {
      'en': 'About',
      'zh': '关于',
    },
    'pricing': {
      'en': 'Pricing',
      'zh': '价格',
    },
    'contact': {
      'en': 'Contact',
      'zh': '联系我们',
    },
    'sign_in': {
      'en': 'Sign In',
      'zh': '登录',
    },
    'start_free_analysis': {
      'en': 'Start Free Analysis',
      'zh': '开始免费分析',
    },
    
    // Home Page
    'hero_title': {
      'en': 'AI-Powered Skincare Solutions',
      'zh': 'AI驱动的护肤解决方案',
    },
    'hero_subtitle': {
      'en': 'Get personalized skincare recommendations, track your skin health, and chat with our AI dermatologist assistant 24/7',
      'zh': '获得个性化护肤建议，跟踪您的皮肤健康，并与我们的AI皮肤科医生助手24/7聊天',
    },
    'get_started': {
      'en': 'Get Started',
      'zh': '开始使用',
    },
    'learn_more': {
      'en': 'Learn More',
      'zh': '了解更多',
    },
    'watch_demo': {
      'en': 'Watch Demo',
      'zh': '观看演示',
    },
    
    // Features Section
    'features_title': {
      'en': 'Powerful AI Features',
      'zh': '强大的AI功能',
    },
    'features_desc': {
      'en': 'Discover how our advanced AI technology can transform your skincare routine',
      'zh': '了解我们的先进AI技术如何改变您的护肤习惯',
    },
    'ai_analysis': {
      'en': 'AI Skin Analysis',
      'zh': 'AI皮肤分析',
    },
    'ai_analysis_desc': {
      'en': 'Advanced machine learning algorithms analyze your skin condition with high accuracy.',
      'zh': '先进的机器学习算法以高精度分析您的皮肤状况。',
    },
    'instant_results': {
      'en': 'Instant Results',
      'zh': '即时结果',
    },
    'instant_results_desc': {
      'en': 'Get detailed analysis and recommendations in seconds, not days.',
      'zh': '在几秒钟内获得详细分析和建议，而不是几天。',
    },
    'personalized_care': {
      'en': 'Personalized Care',
      'zh': '个性化护理',
    },
    'personalized_care_desc': {
      'en': 'Receive customized skincare recommendations based on your unique skin profile.',
      'zh': '根据您独特的皮肤特征获得定制的护肤建议。',
    },
    'expert_insights': {
      'en': 'Expert Insights',
      'zh': '专家见解',
    },
    'expert_insights_desc': {
      'en': 'Access dermatologist-approved recommendations and treatment plans.',
      'zh': '获得皮肤科医生认可的建议和治疗计划。',
    },
    'ai_chatbot': {
      'en': 'AI Chatbot',
      'zh': 'AI聊天机器人',
    },
    'ai_chatbot_desc': {
      'en': 'Get instant answers to your skincare questions from our AI dermatologist',
      'zh': '从我们的AI皮肤科医生那里获得护肤问题的即时答案',
    },
    'skin_analysis': {
      'en': 'Skin Analysis',
      'zh': '皮肤分析',
    },
    'skin_analysis_desc': {
      'en': 'Upload photos for detailed skin analysis and personalized recommendations',
      'zh': '上传照片进行详细的皮肤分析和个性化建议',
    },
    'progress_tracking': {
      'en': 'Progress Tracking',
      'zh': '进度跟踪',
    },
    'progress_tracking_desc': {
      'en': 'Monitor your skin improvement journey with detailed analytics and insights',
      'zh': '通过详细的分析和见解监控您的皮肤改善之旅',
    },
    'smart_recommendations': {
      'en': 'Smart Recommendations',
      'zh': '智能推荐',
    },
    'smart_recommendations_desc': {
      'en': 'Receive AI-powered product suggestions tailored to your unique skin type',
      'zh': '获得针对您独特皮肤类型的AI驱动产品建议',
    },
    'routine_planner': {
      'en': 'Routine Planner',
      'zh': '护肤计划',
    },
    'routine_planner_desc': {
      'en': 'Create and manage your personalized skincare routine with AI guidance',
      'zh': '在AI指导下创建和管理您的个性化护肤程序',
    },
    'privacy_first': {
      'en': 'Privacy First',
      'zh': '隐私优先',
    },
    'privacy_first_desc': {
      'en': 'Your skin data is encrypted and secure with enterprise-grade protection',
      'zh': '您的皮肤数据经过加密，具有企业级保护',
    },
    'cta_title': {
      'en': 'Ready to Transform Your Skin?',
      'zh': '准备好改变您的皮肤了吗？',
    },
    'cta_desc': {
      'en': 'Join thousands of users who have improved their skin health with our AI technology',
      'zh': '加入成千上万使用我们AI技术改善皮肤健康的用户',
    },
    'start_journey': {
      'en': 'Start Your Journey',
      'zh': '开始您的旅程',
    },
    'video_background': {
      'en': 'Video Background',
      'zh': '视频背景',
    },
    'tap_to_play': {
      'en': 'Tap to play',
      'zh': '点击播放',
    },
    
    // About Section
    'about_title': {
      'en': 'About DermalCare',
      'zh': '关于皮肤护理',
    },
    'about_desc': {
      'en': 'Advanced AI-powered dermatology solutions for accurate skin condition analysis and personalized treatment recommendations.',
      'zh': '先进的AI驱动皮肤科解决方案，用于准确的皮肤状况分析和个性化治疗建议。',
    },
    'mission': {
      'en': 'Our Mission',
      'zh': '我们的使命',
    },
    'mission_desc': {
      'en': 'To make professional dermatology care accessible to everyone, everywhere, through the power of artificial intelligence.',
      'zh': '通过人工智能的力量，让每个人、每个地方都能获得专业的皮肤科护理。',
    },
    
    // Pricing Section
    'pricing_title': {
      'en': 'Simple, Transparent Pricing',
      'zh': '简单透明的价格',
    },
    'free_plan': {
      'en': 'Free Plan',
      'zh': '免费计划',
    },
    'free_plan_desc': {
      'en': 'Perfect for getting started with basic skin analysis.',
      'zh': '非常适合开始基本皮肤分析。',
    },
    'basic_analysis': {
      'en': 'Basic skin analysis',
      'zh': '基本皮肤分析',
    },
    'monthly_reports': {
      'en': 'Monthly skin reports',
      'zh': '月度皮肤报告',
    },
    'community_support': {
      'en': 'Community support',
      'zh': '社区支持',
    },
    'premium_plan': {
      'en': 'Premium Plan',
      'zh': '高级计划',
    },
    'premium_plan_desc': {
      'en': 'Advanced features for comprehensive skin care.',
      'zh': '全面护肤的先进功能。',
    },
    'advanced_analysis': {
      'en': 'Advanced AI analysis',
      'zh': '高级AI分析',
    },
    'unlimited_scans': {
      'en': 'Unlimited skin scans',
      'zh': '无限皮肤扫描',
    },
    'expert_consultation': {
      'en': 'Expert consultation',
      'zh': '专家咨询',
    },
    'priority_support': {
      'en': 'Priority support',
      'zh': '优先支持',
    },
    'choose_plan': {
      'en': 'Choose Plan',
      'zh': '选择计划',
    },
    
    // Contact Section
    'contact_title': {
      'en': 'Get in Touch',
      'zh': '联系我们',
    },
    'contact_desc': {
      'en': 'Have questions? We\'d love to hear from you. Send us a message and we\'ll respond as soon as possible.',
      'zh': '有问题吗？我们很乐意听到您的消息。给我们发消息，我们会尽快回复。',
    },
    'name': {
      'en': 'Name',
      'zh': '姓名',
    },
    'email': {
      'en': 'Email',
      'zh': '邮箱',
    },
    'message': {
      'en': 'Message',
      'zh': '消息',
    },
    'send_message': {
      'en': 'Send Message',
      'zh': '发送消息',
    },
    
    // Common UI Elements
    'loading': {
      'en': 'Loading...',
      'zh': '加载中...',
    },
    'error': {
      'en': 'Error',
      'zh': '错误',
    },
    'success': {
      'en': 'Success',
      'zh': '成功',
    },
    'cancel': {
      'en': 'Cancel',
      'zh': '取消',
    },
    'save': {
      'en': 'Save',
      'zh': '保存',
    },
    'delete': {
      'en': 'Delete',
      'zh': '删除',
    },
    'edit': {
      'en': 'Edit',
      'zh': '编辑',
    },
    'back': {
      'en': 'Back',
      'zh': '返回',
    },
    'next': {
      'en': 'Next',
      'zh': '下一步',
    },
    'previous': {
      'en': 'Previous',
      'zh': '上一步',
    },
    'submit': {
      'en': 'Submit',
      'zh': '提交',
    },
    'upload': {
      'en': 'Upload',
      'zh': '上传',
    },
    'download': {
      'en': 'Download',
      'zh': '下载',
    },
    'share': {
      'en': 'Share',
      'zh': '分享',
    },
    'search': {
      'en': 'Search',
      'zh': '搜索',
    },
    'filter': {
      'en': 'Filter',
      'zh': '筛选',
    },
    'sort': {
      'en': 'Sort',
      'zh': '排序',
    },
    'view_all': {
      'en': 'View All',
      'zh': '查看全部',
    },
    'read_more': {
      'en': 'Read More',
      'zh': '阅读更多',
    },
    'show_less': {
      'en': 'Show Less',
      'zh': '显示更少',
    },
    'no_results': {
      'en': 'No results found',
      'zh': '未找到结果',
    },
    'try_again': {
      'en': 'Try Again',
      'zh': '重试',
    },
    'coming_soon': {
      'en': 'Coming Soon',
      'zh': '即将推出',
    },
    'new': {
      'en': 'New',
      'zh': '新',
    },
    'popular': {
      'en': 'Popular',
      'zh': '热门',
    },
    'recommended': {
      'en': 'Recommended',
      'zh': '推荐',
    },
    'best_seller': {
      'en': 'Best Seller',
      'zh': '畅销',
    },
    'sale': {
      'en': 'Sale',
      'zh': '促销',
    },
    'free': {
      'en': 'Free',
      'zh': '免费',
    },
    'premium': {
      'en': 'Premium',
      'zh': '高级',
    },
    'pro': {
      'en': 'Pro',
      'zh': '专业版',
    },
    'basic': {
      'en': 'Basic',
      'zh': '基础版',
    },
    'standard': {
      'en': 'Standard',
      'zh': '标准版',
    },
    'advanced': {
      'en': 'Advanced',
      'zh': '高级版',
    },
    'enterprise': {
      'en': 'Enterprise',
      'zh': '企业版',
    },
  };

  static String getText(String key, BuildContext context) {
    final languageService = LanguageService();
    final language = languageService.currentLanguage;
    final languageCode = language == AppLanguage.english ? 'en' : 'zh';
    
    return _translations[key]?[languageCode] ?? _translations[key]?['en'] ?? key;
  }

  static String getTextWithLanguage(String key, AppLanguage language) {
    final languageCode = language == AppLanguage.english ? 'en' : 'zh';
    return _translations[key]?[languageCode] ?? _translations[key]?['en'] ?? key;
  }

  // Helper method to get all translations for a specific language
  static Map<String, String> getAllTranslations(AppLanguage language) {
    final languageCode = language == AppLanguage.english ? 'en' : 'zh';
    final Map<String, String> result = {};
    
    _translations.forEach((key, value) {
      result[key] = value[languageCode] ?? value['en'] ?? key;
    });
    
    return result;
  }
}
