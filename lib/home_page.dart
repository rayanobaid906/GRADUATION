import 'dart:async';
import 'package:flutter/material.dart';
import 'package:graduation/app_colors.dart';
import 'package:graduation/create_order.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _timer;
  

  final List<Map<String, dynamic>> _benefits = [
    {
      "title": "╪º╪│╪¬┘é╪¿┘ä ╪╣╪▒┘ê╪╢ ╪º┘ä╪ú╪│╪╣╪º╪▒",
      "desc": "╪ú┘å╪┤╪ª ╪╖┘ä╪¿ ╪╡┘è╪º┘å╪⌐ ┘ê╪»╪╣ ╪º┘ä┘ü┘å┘è┘è┘å ╪º┘ä┘à╪¬╪«╪╡╪╡┘è┘å ┘è┘é╪»┘à┘ê┘å ╪╣╪▒┘ê╪╢┘ç┘à",
      "icon": Icons.local_offer_rounded,
      "bg": const Color(0xFF1E293B),
    },
    {
      "title": "╪«╪╡┘ê╪╡┘è╪⌐ ┘ê╪ú┘à╪º┘å ╪¬╪º┘à",
      "desc": "╪▒┘é┘à ┘ç╪º╪¬┘ü┘â ┘à╪¡┘à┘è ╪¬┘à╪º┘à╪º┘ï ┘ê┘ä╪º ┘è╪╕┘ç╪▒ ┘ä┘ä╪╖╪▒┘ü ╪º┘ä╪ó╪«╪▒ ╪Ñ┘ä╪º ╪¿╪╣╪» ┘é╪¿┘ê┘ä┘â",
      "icon": Icons.shield_rounded,
      "bg": const Color(0xFF1E2640),
    },
    {
      "title": "╪Ñ╪║┘ä╪º┘é ╪░┘â┘è ╪¿╪º┘ä┘Ç QR",
      "desc": "╪¬╪ú┘â┘è╪» ╪Ñ┘å┘ç╪º╪í ╪º┘ä╪╣┘à┘ä ┘ê╪º┘ä╪»┘ü╪╣ ┘è╪¬┘à ╪¿╪ú┘à╪º┘å ╪¬╪º┘à ╪¿┘à╪¼╪▒╪» ┘à╪│╪¡ ╪▒┘à╪▓ ╪º┘ä┘Ç QR",
      "icon": Icons.qr_code_scanner_rounded,
      "bg": const Color(0xFF2E1B28),
    },
  ];

  final List<Map<String, dynamic>> _services = [
    {"name": "┘â┘ç╪▒╪¿╪º╪í", "icon": Icons.bolt_rounded, "color": Colors.amber},
    {"name": "╪│╪¿╪º┘â╪⌐", "icon": Icons.water_drop_rounded, "color": Colors.blue},
    {
      "name": "╪ú╪¼┘ç╪▓╪⌐ ┘à┘å╪▓┘ä┘è╪⌐",
      "icon": Icons.kitchen_rounded,
      "color": Colors.orange,
    },
    {
      "name": "╪¬┘â┘è┘è┘ü ┘ê╪¬╪¿╪▒┘è╪»",
      "icon": Icons.ac_unit_rounded,
      "color": Colors.cyan,
    },
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < _benefits.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      
      physics: const BouncingScrollPhysics(),
       
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. ╪º┘ä┘Ç Header ╪º┘ä╪¬╪▒╪¡┘è╪¿┘è (╪¬┘à ╪¬╪╡╪║┘è╪▒ ╪º┘ä┘Ç Padding ┘ê╪º┘ä╪«╪╖┘ê╪╖ ┘ä╪▒┘ü╪╣ ╪º┘ä┘à╪¡╪¬┘ê┘ë)
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              left: 20.0,
              right: 20.0,
              bottom: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "┘à╪▒╪¡╪¿╪º┘ï ╪¿┘â ┘ü┘è FIXIT ≡ƒæï",
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "╪Ñ╪╡┘ä╪º╪¡╪º╪¬┘â ╪º┘ä┘à┘å╪▓┘ä┘è╪⌐ ╪ú╪╡╪¿╪¡╪¬ ╪ú╪│┘ç┘ä",
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          // 2. ╪º┘ä┘â╪º╪▒┘ê╪│┘è┘ä ╪º┘ä╪ú┘ê╪¬┘ê┘à╪º╪¬┘è┘â┘è (╪¬┘à ╪¬╪╡╪║┘è╪▒ ╪º┘ä╪º╪▒╪¬┘ü╪º╪╣ ┘à┘å 140 ╪Ñ┘ä┘ë 100 ┘ä┘è╪╡╪¿╪¡ ┘å╪¡┘è┘ü╪º┘ï ╪¼╪»╪º┘ï)
          SizedBox(
            height: 100,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _benefits.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                final item = _benefits[index];
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 2,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: item['bg'],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.12),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item['title'],
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item['desc'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 11,
                                color: AppColors.textPrimary,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          item['icon'],
                          size: 24,
                          color: AppColors.primary,
                        ), // ╪¬╪╡╪║┘è╪▒ ╪º┘ä╪ú┘è┘é┘ê┘å╪⌐ ┘ä┘Ç 24
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // ┘å┘é╪º╪╖ ╪º┘ä┘à╪ñ╪┤╪▒ ╪ú╪│┘ü┘ä ╪º┘ä┘â╪º╪▒┘ê╪│┘è┘ä (╪¬┘à ╪¬╪╡╪║┘è╪▒ ╪º┘ä┘Ç Padding ╪º┘ä╪╣┘à┘ê╪»┘è)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _benefits.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
                width: _currentPage == index ? 14 : 5,
                height: 5,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? AppColors.primary
                      : AppColors.textSecondary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
          ),

          // ╪╣┘å┘ê╪º┘å ┘é╪│┘à ╪º┘ä╪¬╪«╪╡╪╡╪º╪¬ (╪ú╪╡╪¿╪¡ ╪º┘ä╪ó┘å ┘à╪▒╪¬┘ü╪╣╪º┘ï ┘ä┘ä╪ú╪╣┘ä┘ë ╪¬┘à╪º┘à╪º┘ï)
          const Padding(
            padding: EdgeInsets.only(
              top: 10.0,
              left: 20.0,
              right: 20.0,
              bottom: 8.0,
            ),
            child: Text(
              "╪º┘ä╪¬╪«╪╡╪╡╪º╪¬ ╪º┘ä┘à╪¬╪º╪¡╪⌐",
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // 3. ╪┤╪¿┘â╪⌐ ╪º┘ä╪¬╪«╪╡╪╡╪º╪¬ ╪º┘ä╪ú╪▒╪¿╪╣╪⌐ (╪¬╪╣┘à┘ä ┘â╪ú╪▓╪▒╪º╪▒ ┘à╪¿╪º╪┤╪▒╪⌐ ┘ä┘ä╪╖┘ä╪¿)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _services.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio:
                    1.2, // ╪▓┘è╪º╪»╪⌐ ╪º┘ä┘å╪│╪¿╪⌐ ┘ä╪¬╪╡╪║┘è╪▒ ╪º┘ä┘â╪▒┘ê╪¬ ╪╣┘à┘ê╪»┘è╪º┘ï ┘ê╪¼╪╣┘ä┘ç╪º ┘à┘å╪¿╪│╪╖╪⌐
              ),
              itemBuilder: (context, index) {
                final service = _services[index];
                return InkWell(
                  onTap: () {
                    print("╪¬┘à ╪º┘ä╪╢╪║╪╖ ┘ä╪Ñ┘å╪┤╪º╪í ╪╖┘ä╪¿ ╪¬╪«╪╡╪╡: ${service['name']}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateOrder(),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.06),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: service['color'].withOpacity(0.08),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            service['icon'],
                            size: 24,
                            color: service['color'],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          service['name'],
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // ╪╣┘å┘ê╪º┘å ┘é╪│┘à ╪╖┘ä╪¿ ╪╡┘è╪º┘å╪⌐ ╪│╪▒┘è╪╣
          const Padding(
            padding: EdgeInsets.only(
              top: 18.0,
              left: 20.0,
              right: 20.0,
              bottom: 8.0,
            ),
            child: Text(
              "╪╖┘ä╪¿ ╪╡┘è╪º┘å╪⌐ ╪│╪▒┘è╪╣",
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // 4. ┘â╪º╪▒╪¬ ┘ê╪▓╪▒ "╪╖┘ä╪¿ ╪╡┘è╪º┘å╪⌐ ┘ü┘ê╪▒┘è ╪╣╪º┘à" ╪º┘ä┘à╪╢╪║┘ê╪╖ ┘ê╪º┘ä╪¼┘à┘è┘ä ┘ü┘è ╪º┘ä╪ú╪│┘ü┘ä
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.75),// ╪¬╪»╪▒╪¼ ┘ä┘ê┘å┘è ╪¿╪│┘è╪╖ ┘ä╪Ñ╪╢╪º┘ü╪⌐ ╪╣┘à┘é ┘ê╪¼╪º╪░╪¿┘è╪⌐
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    print("╪¬┘à ╪º┘ä╪╢╪║╪╖ ╪╣┘ä┘ë ╪▓╪▒ ╪╖┘ä╪¿ ╪╡┘è╪º┘å╪⌐ ┘ü┘ê╪▒┘è ╪╣╪º┘à");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateOrder(),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 14.0,
                    ), // ╪¬┘é┘ä┘è╪╡ ╪º┘ä┘Ç Padding ╪º┘ä╪»╪º╪«┘ä┘è ┘ä╪¬┘é┘ü┘è┘ä ╪º┘ä┘à╪│╪º╪¡╪⌐
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "┘ç┘ä ╪¬┘ê╪º╪¼┘ç ╪╣╪╖┘ä╪º┘ï ┘à┘ü╪º╪¼╪ª╪º┘ï╪ƒ",
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "╪º╪╢╪║╪╖ ┘ç┘å╪º ┘ä╪Ñ┘å╪┤╪º╪í ╪╖┘ä╪¿┘â ╪º┘ä╪ó┘å ┘ê╪»╪╣ ╪º┘ä┘ü┘å┘è┘è┘å ┘è┘é╪»┘à┘ê┘å ╪╣╪▒┘ê╪╢┘ç┘à",
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 11,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w800,
                                  height: 1.9,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add_task_rounded,
                            size: 22,
                            color: AppColors.background,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20), // ┘à╪│╪º┘ü╪⌐ ╪ú┘à╪º┘å ╪│┘ü┘ä┘è ╪╡╪║┘è╪▒╪⌐ ╪«┘ü┘è┘ü╪⌐
        ],
      ),
    );
  }
}

