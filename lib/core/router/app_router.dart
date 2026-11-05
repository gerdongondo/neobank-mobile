// lib/core/router/app_router.dart
import 'package:go_router/go_router.dart';
import 'package:neobankmobile/presentation/screens/auth/login_screen.dart';
import 'package:neobankmobile/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:neobankmobile/presentation/screens/transfer/transfer_screen.dart';
import 'package:neobankmobile/presentation/screens/history/history_screen.dart';
import 'package:neobankmobile/presentation/screens/profile/profile_screen.dart';
import 'package:neobankmobile/presentation/screens/admin/admin_dashboard_screen.dart';
import 'package:neobankmobile/presentation/screens/admin/admin_users_screen.dart';
import 'package:neobankmobile/presentation/screens/admin/admin_transactions_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (c, s) => const LoginScreen()),
      GoRoute(path: '/dashboard', builder: (c, s) => const DashboardScreen()),
      GoRoute(path: '/transfer', builder: (c, s) => const TransferScreen()),
      GoRoute(path: '/history', builder: (c, s) => const HistoryScreen()),
      GoRoute(path: '/profile', builder: (c, s) => const ProfileScreen()),
      // Admin routes
      GoRoute(path: '/admin', builder: (c, s) => const AdminDashboardScreen()),
      GoRoute(path: '/admin/users', builder: (c, s) => const AdminUsersScreen()),
      GoRoute(
          path: '/admin/transactions',
          builder: (c, s) => const AdminTransactionsScreen()),
    ],
  );
}