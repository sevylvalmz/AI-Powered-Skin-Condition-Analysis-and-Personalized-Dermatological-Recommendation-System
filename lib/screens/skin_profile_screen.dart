import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SkinProfileScreen extends StatefulWidget {
  const SkinProfileScreen({super.key});

  @override
  State<SkinProfileScreen> createState() => _SkinProfileScreenState();
}

class _SkinProfileScreenState extends State<SkinProfileScreen> {
  final List<String> selectedGoals = [];

  final List<Map<String, String>> goals = [
    {'id': 'akne_kontrolu', 'label': 'akne_kontrolu'},
    {'id': 'nemlendirme', 'label': 'nemlendirme'},
    {'id': 'yaslanma_karsiti', 'label': 'yaslanma_karsiti'},
    {'id': 'leke_giderme', 'label': 'leke_giderme'},
    {'id': 'gozenek_sikilastirma', 'label': 'gozenek_sikilastirma'},
    {'id': 'aydinlatma', 'label': 'aydinlatma'},
  ];

  @override
  Widget build(BuildContext context) {
    final pinkColor = const Color(0xFFEC407A);

    return Scaffold(
      body: Column(
        children: [
          // Header with Progress
          Container(
            padding: const EdgeInsets.only(top: 60, bottom: 30, left: 24, right: 24),
            width: double.infinity,
            decoration: BoxDecoration(
              color: pinkColor.withOpacity(0.15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'cilt_profili_olusturma'.tr(),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: pinkColor,
                  ),
                ),
                const SizedBox(height: 20),
                // Progress Bar
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: pinkColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'adim_1_2'.tr(),
                  style: TextStyle(
                    color: pinkColor.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'cilt_hedefleri'.tr(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: pinkColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'en_onemli_hedef'.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 32),
                // Grid of goals
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 2.2,
                  ),
                  itemCount: goals.length,
                  itemBuilder: (context, index) {
                    final goal = goals[index];
                    final isSelected = selectedGoals.contains(goal['id']);

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedGoals.remove(goal['id']);
                          } else {
                            selectedGoals.add(goal['id']!);
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: isSelected ? pinkColor.withOpacity(0.1) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? pinkColor : Colors.grey[300]!,
                            width: 1.5,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: pinkColor.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  )
                                ]
                              : [],
                        ),
                        child: Center(
                          child: Text(
                            goal['label']!.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isSelected ? pinkColor : Colors.grey[600],
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Spacer(),
          // Next Button
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: selectedGoals.isEmpty ? null : () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: pinkColor.withOpacity(0.15),
                  foregroundColor: pinkColor,
                  elevation: 0,
                  disabledBackgroundColor: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ileri'.tr(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
