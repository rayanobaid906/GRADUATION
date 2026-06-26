import 'package:flutter/material.dart';
import 'package:graduation/app_colors.dart';
import 'presentation/screens/available_orders_screen.dart';
import 'presentation/screens/subscription_payment_screen.dart';

class ProviderDashboardLaunchScreen extends StatefulWidget {
  const ProviderDashboardLaunchScreen({Key? key}) : super(key: key);

  @override
  State<ProviderDashboardLaunchScreen> createState() => _ProviderDashboardLaunchScreenState();
}

class _ProviderDashboardLaunchScreenState extends State<ProviderDashboardLaunchScreen> {
  int _selectedIndex = 0;

  Widget _buildProviderBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.engineering, size: 80, color: AppColors.primary),
          const SizedBox(height: 32,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), backgroundColor: AppColors.surface),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AvailableOrdersScreen())),
            child: const Text('استعراض طلبات الصيانة المتاحة',style: TextStyle(color: AppColors.textPrimary)),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), backgroundColor: AppColors.surface),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SubscriptionPaymentScreen())),
            child: const Text('إدارة الاشتراك والدفع اليدوي',style: TextStyle(color: AppColors.textPrimary)),
          ),
        ],
      ),
    );
  }

  List<Widget> get _pages => [
    Builder(builder: (context) => _buildProviderBody(context)),
    const SizedBox.shrink(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text('لوحة تحكم مقدم الخدمة', style: TextStyle(color: AppColors.textPrimary)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: const Icon(Icons.notifications_none_rounded, color: AppColors.textPrimary, size: 26),
              onPressed: () {},
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: AppColors.surface,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.textPrimary,
            border: Border(
              left: BorderSide(
                color: AppColors.primary.withValues(alpha: 0.4),
                width: 1.5,
              ),
            ),
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60.0, bottom: 20.0),
                child: Text(
                  "القائمة الرئيسية",
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
                child: Card(
                  color: const Color(0xFF222539),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const Icon(Icons.person_rounded, color: AppColors.primary),
                    title: const Text("الملف الشخصي", style: TextStyle(fontFamily: 'Cairo', color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
                    trailing: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textSecondary, size: 14),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Card(
                  color: const Color(0xFF2A1B24),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.redAccent.withValues(alpha: 0.2), width: 1)),
                  child: ListTile(
                    leading: const Icon(Icons.logout_rounded, color: Colors.redAccent),
                    title: const Text("تسجيل الخروج", style: TextStyle(fontFamily: 'Cairo', color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 15)),
                    onTap: () { Navigator.pop(context); },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 3, top: 3),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: AppColors.primary.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 0)),
            BoxShadow(color: AppColors.primary.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 4)),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Theme(
            data: Theme.of(context).copyWith(splashColor: const Color.fromARGB(0, 245, 208, 208), highlightColor: Colors.transparent),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) => setState(() { _selectedIndex = index; }),
              backgroundColor: Colors.transparent,
              selectedItemColor: AppColors.primary,
              unselectedIconTheme: const IconThemeData(size: 24),
              selectedIconTheme: const IconThemeData(size: 28),
              unselectedItemColor: AppColors.textSecondary,
              selectedLabelStyle: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
              unselectedLabelStyle: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.normal),
              elevation: 0,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "الرئيسية"),
                BottomNavigationBarItem(icon: Icon(Icons.list_alt_rounded), label: "طلباتي"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
