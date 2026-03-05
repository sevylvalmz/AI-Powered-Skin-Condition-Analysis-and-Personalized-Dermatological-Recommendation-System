import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'main_wrapper.dart';

class SkinProfileScreen extends StatefulWidget {
  const SkinProfileScreen({super.key});

  @override
  State<SkinProfileScreen> createState() => _SkinProfileScreenState();
}

class _SkinProfileScreenState extends State<SkinProfileScreen> {
  int _currentStep = 0;
  final List<String> selectedGoals = [];
  String sensitivityLevel = 'Orta';
  final List<String> selectedAllergies = [];

  final List<Map<String, String>> goals = [
    {'id': 'akne_kontrolu', 'label': 'akne_kontrolu'},
    {'id': 'nemlendirme', 'label': 'nemlendirme'},
    {'id': 'yaslanma_karsiti', 'label': 'yaslanma_karsiti'},
    {'id': 'leke_giderme', 'label': 'leke_giderme'},
    {'id': 'gozenek_sikilastirma', 'label': 'gozenek_sikilastirma'},
    {'id': 'aydinlatma', 'label': 'aydinlatma'},
  ];

  final List<String> allergies = [
    'parfum', 'sulfat', 'paraben', 'alkol', 'esansiyel_yaglar', 'hicbir'
  ];

  @override
  Widget build(BuildContext context) {
    final pinkColor = Theme.of(context).primaryColor;
    final backgroundColor = const Color(0xFFF8BBD0);

    return Scaffold(
      body: Column(
        children: [
          // Header with Progress
          Container(
            padding: const EdgeInsets.only(top: 60, bottom: 30, left: 24, right: 24),
            width: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'cilt_profili_olusturma'.tr(),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentStep == 1 ? Colors.white : Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  _currentStep == 0 ? 'Adım 1 / 2' : 'Adım 2 / 2',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _currentStep == 0 ? _buildStep1(pinkColor) : _buildStep2(pinkColor),
            ),
          ),
          // Navigation Buttons
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                if (_currentStep == 1)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: OutlinedButton(
                        onPressed: () => setState(() => _currentStep = 0),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: pinkColor),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        ),
                        child: Text('geri'.tr(), style: TextStyle(color: pinkColor, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentStep == 0) {
                        if (selectedGoals.isNotEmpty) setState(() => _currentStep = 1);
                      } else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const MainWrapper()),
                          (route) => false,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: pinkColor.withOpacity(0.2),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                    child: Text(
                      _currentStep == 0 ? 'ileri'.tr() : 'devam_et'.tr(),
                      style: TextStyle(color: pinkColor, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildStep1(Color pinkColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'cilt_hedefleri'.tr(),
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: pinkColor),
        ),
        const SizedBox(height: 8),
        Text(
          'en_onemli_hedef'.tr(),
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        const SizedBox(height: 32),
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
            return _buildChip(goal['id']!, goal['label']!.tr(), isSelected, pinkColor, (val) {
              setState(() {
                isSelected ? selectedGoals.remove(goal['id']) : selectedGoals.add(goal['id']!);
              });
            });
          },
        ),
      ],
    );
  }

  Widget _buildStep2(Color pinkColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'hassasiyet_alerjiler'.tr(),
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: pinkColor),
        ),
        const SizedBox(height: 24),
        Text(
          'cilt_hassasiyeti'.tr(),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: pinkColor.withOpacity(0.8)),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLevelButton('dusuk', pinkColor),
            _buildLevelButton('orta', pinkColor),
            _buildLevelButton('yuksek', pinkColor),
          ],
        ),
        const SizedBox(height: 32),
        Text(
          'bilinen_alerjiler'.tr(),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: pinkColor.withOpacity(0.8)),
        ),
        const SizedBox(height: 8),
        Text('secin_tumunu'.tr(), style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: allergies.map((allergy) {
            final isSelected = selectedAllergies.contains(allergy);
            return _buildChip(allergy, allergy.tr(), isSelected, pinkColor, (val) {
              setState(() {
                if (allergy == 'hicbir') {
                  selectedAllergies.clear();
                  selectedAllergies.add('hicbir');
                } else {
                  selectedAllergies.remove('hicbir');
                  isSelected ? selectedAllergies.remove(allergy) : selectedAllergies.add(allergy);
                }
              });
            });
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildLevelButton(String label, Color pinkColor) {
    final isSelected = sensitivityLevel == label.tr();
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: GestureDetector(
          onTap: () => setState(() => sensitivityLevel = label.tr()),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: isSelected ? pinkColor.withOpacity(0.2) : Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: isSelected ? pinkColor : Colors.grey[300]!),
            ),
            child: Center(
              child: Text(
                label.tr(),
                style: TextStyle(
                  color: isSelected ? pinkColor : Colors.grey[600],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String id, String label, bool isSelected, Color pinkColor, Function(bool) onTap) {
    return GestureDetector(
      onTap: () => onTap(!isSelected),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? pinkColor.withOpacity(0.2) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? pinkColor : Colors.grey[300]!),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? pinkColor : Colors.grey[600],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

