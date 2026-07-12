import 'package:flutter/material.dart';
import 'package:graduation/app_colors.dart';
import 'package:graduation/home_page.dart';
import 'package:graduation/to_be_provider.dart';
import 'package:graduation/order_situations.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isDarkMode = true;
  int _selectedIndex = 0;
  List<Widget> get _pages => [const HomePage(), const OrderSituations()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "FIXIT",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontFamily: 'cairo',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20.0,
            ), // ╪Ñ╪╣╪╖╪º╪í ┘à╪│╪º┘ü╪⌐ ╪ú┘à╪º┘å ┘à╪▒┘è╪¡╪⌐ ┘ä┘ä╪╣┘è┘å
            child: IconButton(
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: AppColors.textPrimary,
                size: 26,
              ),
              onPressed: () {
                // الإشعارات
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: AppColors.surface,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border(
              left: BorderSide(
                color: AppColors.primary.withOpacity(0.4),
                width: 1.5,
              ),
            ),
          ),
          child: Column(
            children: [
              // ╪╣┘å┘ê╪º┘å ╪º┘ä┘é╪º╪ª┘à╪⌐ ╪º┘ä╪╣┘ä┘ê┘è
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

              // 1. ┘â╪º╪▒╪¬ ╪º┘ä┘à┘ä┘ü ╪º┘ä╪┤╪«╪╡┘è (Profile Card)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 4.0,
                ),
                child: Card(
                  color: const Color(0xFF222539),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.person_rounded,
                      color: AppColors.primary,
                    ),
                    title: const Text(
                      "الملف الشخصي",
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.textSecondary,
                      size: 14,
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 4.0,
                ),
                child: Card(
                  color: const Color(0xFF222539),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.settings_rounded,
                      color: Colors.amberAccent,
                    ), // ╪ú┘è┘é┘ê┘å╪⌐ ╪¿┘ä┘ê┘å ╪»╪º┘ü╪ª ┘à┘à┘è╪▓
                    title: const Text(
                      "الإعدادات",
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      "تعديل إعدادات الحساب",
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.textSecondary,
                      size: 14,
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Card(
                  color: const Color(
                    0xFF1E293B,
                  ), // ╪»╪▒╪¼╪⌐ ┘à╪«╪¬┘ä┘ü╪⌐ ┘é┘ä┘è┘ä╪º┘ï ┘ä╪¬┘à┘è┘è╪▓ ╪«┘è╪º╪▒ ╪º┘ä┘ê╪▒╪┤ ┘ê╪º┘ä╪╣┘à┘ä
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: AppColors.primary.withOpacity(0.3),
                      width: 1,
                    ), // ╪¬╪¡╪»┘è╪» ┘à╪╢┘è╪í ╪«┘ü┘è┘ü
                  ),
                  child: ListTile(
                    
                    
                    leading: const Icon(
                      Icons.build_circle_rounded,
                      color: AppColors.primary,
                    ),
                    title: const Text(
                      "سجل كمقدم خدمة (تجريبي)",
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      "انضم لمقدمي الخدمات واحصل على طلبات في منطقتك",
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.primary,
                      size: 14,
                    ),
                   onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ToBeProvider()),
                  ),
                ),
              ),
              ),
              // --------------------------------------------------------
              // ╪│╪¿┘è╪│ ╪ú┘ê ┘à╪│╪º╪¡╪⌐ ┘ü╪º╪▒╪║╪⌐ ╪│╪¡╪▒┘è╪⌐ (Spacer) ╪¬╪»┘ü╪╣ ╪ú┘è ┘â┘ê╪» ╪¬╪¡╪¬┘ç╪º ╪Ñ┘ä┘ë ┘é╪º╪╣ ╪º┘ä╪┤╪º╪┤╪⌐ ┘ü┘ê╪▒╪º┘ï
              const Spacer(),
              // --------------------------------------------------------

              // --- ┘â╪º╪▒╪¬ ╪¬╪│╪¼┘è┘ä ╪º┘ä╪«╪▒┘ê╪¼ ┘ü┘è ╪ú╪│┘ü┘ä ╪º┘ä┘Ç Drawer ╪¬┘à╪º┘à╪º┘ï ---
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20.0,
                ), // ┘à╪│╪º┘ü╪⌐ ╪ú┘à╪º┘å ┘à┘å ╪º┘ä╪ú╪│┘ü┘ä
                child: Card(
                  color: const Color(
                    0xFF2A1B24,
                  ), // ╪»╪▒╪¼╪⌐ ╪»╪º┘â┘å╪⌐ ┘à╪º╪ª┘ä╪⌐ ┘ä┘ä╪ú╪¡┘à╪▒ ┘ä╪¬┘å╪º╪│╪¿ ┘à┘ü┘ç┘ê┘à ╪º┘ä┘Ç Logout
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Colors.redAccent.withOpacity(0.2),
                      width: 1,
                    ), // ╪Ñ╪╖╪º╪▒ ╪ú╪¡┘à╪▒ ╪«┘ü┘è┘ü
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.logout_rounded,
                      color: Colors.redAccent,
                    ), // ╪ú┘è┘é┘ê┘å╪⌐ ╪¿╪º┘ä┘ä┘ê┘å ╪º┘ä╪ú╪¡┘à╪▒
                    title: const Text(
                      "تسجيل الخروج",
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: Colors.redAccent, // ┘å╪╡ ╪ú╪¡┘à╪▒ ╪¬╪¡╪░┘è╪▒┘è ╪ú┘å┘è┘é
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex],

      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
          bottom: 3,
          top: 3,
        ), // ┘à╪│╪º┘ü╪⌐ ╪ú┘à╪º┘å ┘à┘å ╪º┘ä╪ú╪╣┘ä┘ë ┘ê╪º┘ä╪ú╪│┘ü┘ä
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 25,
        ), // ┘à╪│╪º┘ü╪⌐ ╪ú┘à╪º┘å ┘à┘å ╪º┘ä╪¼┘ê╪º┘å╪¿
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
            BoxShadow(
              color: AppColors.primary.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        // margin: const EdgeInsets.all(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: const Color.fromARGB(
                0,
                245,
                208,
                208,
              ), // ╪Ñ╪▓╪º┘ä╪⌐ ╪¬╪ú╪½┘è╪▒ ╪º┘ä┘å┘é╪▒ ╪º┘ä╪º┘ü╪¬╪▒╪º╪╢┘è
              highlightColor:
                  Colors.transparent, // ╪Ñ╪▓╪º┘ä╪⌐ ╪¬╪ú╪½┘è╪▒ ╪º┘ä╪¬╪¡╪»┘è╪» ╪º┘ä╪º┘ü╪¬╪▒╪º╪╢┘è
            ),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              backgroundColor: Colors.transparent,
              selectedItemColor: AppColors.primary,
              unselectedIconTheme: const IconThemeData(size: 24),
              selectedIconTheme: const IconThemeData(size: 28),
              unselectedItemColor: AppColors.textSecondary,
              selectedLabelStyle: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.normal,
              ),
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: "الرئيسية",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt_rounded),
                  label: "الطلبات",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

