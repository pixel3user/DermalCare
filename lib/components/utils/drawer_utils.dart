import '/components/sidebar_mobile/sidebar_mobile_widget.dart';
import '/components/sidebar/sidebar_widget.dart';
import '/pages/main/main_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

/// Utility class for standardized drawer implementations across all pages
/// Provides consistent drawer behavior and reduces code duplication
class DrawerUtils {
  /// Creates a standardized mobile drawer widget with optimized performance
  static Widget createMobileDrawer({
    required BuildContext context,
    required Future<void> Function() onSearch,
    required Future<void> Function() onItemSelect,
    Future<void> Function()? onNewChat,
  }) {
    return Drawer(
      elevation: 16.0,
      child: SidebarMobileWidget(
        onNewChat: onNewChat ?? () async {
          try {
            Navigator.pop(context);
            await _navigateToMain(context);
          } catch (e) {
            debugPrint('Error navigating to new chat: $e');
          }
        },
        onSearch: () async {
          try {
            await onSearch();
            Navigator.pop(context);
          } catch (e) {
            debugPrint('Error in search callback: $e');
          }
        },
        onItemSelect: () async {
          try {
            await onItemSelect();
            Navigator.pop(context);
          } catch (e) {
            debugPrint('Error in item select callback: $e');
          }
        },
      ),
    );
  }

  /// Creates a standardized desktop sidebar widget with optimized performance
  static Widget createDesktopSidebar({
    required Future<void> Function() onSearch,
    required Future<void> Function() onItemSelect,
    Future<void> Function()? onNewChat,
  }) {
    return SidebarWidget(
      onNewChat: onNewChat ?? () async {
        // Default behavior - can be overridden
        debugPrint('Default new chat behavior triggered');
      },
      onItemSelect: () async {
        try {
          await onItemSelect();
        } catch (e) {
          debugPrint('Error in desktop item select callback: $e');
        }
      },
      onSearch: () async {
        try {
          await onSearch();
        } catch (e) {
          debugPrint('Error in desktop search callback: $e');
        }
      },
    );
  }

  /// Standard navigation to main page with new chat
  /// Includes error handling and performance optimization
  static Future<void> navigateToNewChat(BuildContext context) async {
    try {
      await _navigateToMain(context);
    } catch (e) {
      debugPrint('Error navigating to new chat: $e');
      // Fallback navigation
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed('/main');
      }
    }
  }

  /// Standard navigation to main page
  /// Includes error handling and performance optimization
  static Future<void> navigateToMain(BuildContext context) async {
    try {
      await _navigateToMain(context);
    } catch (e) {
      debugPrint('Error navigating to main: $e');
      // Fallback navigation
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed('/main');
      }
    }
  }

  /// Private helper method for navigation to main page
  /// Centralizes navigation logic and reduces code duplication
  static Future<void> _navigateToMain(BuildContext context) async {
    if (!context.mounted) return;
    
    await context.pushNamed(
      MainWidget.routeName,
      extra: <String, dynamic>{
        kTransitionInfoKey: TransitionInfo(
          hasTransition: true,
          transitionType: PageTransitionType.fade,
        ),
      },
    );
  }

  /// Utility method to check if drawer should be shown based on screen size
  static bool shouldShowDrawer(BuildContext context) {
    return MediaQuery.of(context).size.width < 768; // Mobile breakpoint
  }

  /// Utility method to get drawer width based on screen size
  static double getDrawerWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 400 ? 300.0 : screenWidth * 0.8;
  }
}
