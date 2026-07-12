
import 'package:flutter/material.dart';
import 'package:graduation/login_page.dart';
import 'package:graduation/main_page.dart';
import 'package:graduation/sign_up.dart';
import 'package:provider/provider.dart';
import 'package:graduation/app_colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'business_logic/auth/auth_provider.dart';
import 'business_logic/auth/signup_provider.dart';
import 'business_logic/auth/otp_provider.dart';
import 'business_logic/main/main_page_provider.dart';
import 'business_logic/main/home_page_provider.dart';
import 'business_logic/main/order_situations_provider.dart';
import 'business_logic/splash/splash_provider.dart';
import 'business_logic/order/create_order_provider.dart';
import 'service_provider/business_logic/available_orders/available_orders_provider.dart';
import 'service_provider/business_logic/subscription/subscription_provider.dart';
import 'service_provider/ProviderDashboardLaunchScreen.dart';
import 'package:graduation/providers/auth_provider.dart' as remote_auth;
import 'package:graduation/providers/order_provider.dart' as remote_order;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AvailableOrdersProvider()..fetchAvailableOrders(),
        ),
        ChangeNotifierProvider(
          create: (_) => SubscriptionProvider()..checkSubscriptionStatus(),
        ),
        ChangeNotifierProvider(
          create: (_) => MainPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomePageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderSituationsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SignupProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OtpProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SplashProvider()..startTimer(),
        ),
        ChangeNotifierProvider(
          create: (_) => CreateOrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => remote_auth.AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => remote_order.OrderProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'بوابة مقدم الخدمة',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: AppColors.background,
          appBarTheme: const AppBarTheme(centerTitle: true, elevation: 1),
        ),
        locale: const Locale('ar', 'AE'),
        supportedLocales: const [Locale('ar', 'AE')],
        home: const ProviderDashboard(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignupPage(),
          '/main_page': (context) => const MainPage(),
        },
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}