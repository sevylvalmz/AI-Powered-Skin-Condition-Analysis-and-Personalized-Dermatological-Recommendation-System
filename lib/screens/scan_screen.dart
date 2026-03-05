import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'results_screen.dart';

class ScanScreen extends StatefulWidget {
  final Function(int)? onTabChanged;
  const ScanScreen({super.key, this.onTabChanged});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  int _currentStep = 0;
  bool _image1Uploaded = false;
  bool _image2Uploaded = false;
  bool _image3Uploaded = false;

  @override
  Widget build(BuildContext context) {
    final pinkColor = Theme.of(context).primaryColor;
    final backgroundColor = const Color(0xFFF8BBD0);

    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.only(top: 60, bottom: 30, left: 24, right: 24),
            width: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'gorsel_yukle'.tr(),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                // Progress Steps
                Row(
                  children: [
                    _buildStepIndicator(0, 'Cilt Tipi', _currentStep >= 0),
                    const SizedBox(width: 12),
                    _buildStepIndicator(1, 'Sorunlu Bölge', _currentStep >= 1),
                  ],
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
          // Navigation
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
                    onPressed: _canProceed()
                        ? () {
                            if (_currentStep == 0) {
                              setState(() => _currentStep = 1);
                            } else {
                              if (widget.onTabChanged != null) {
                                widget.onTabChanged!(2);
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ResultsScreen()),
                                );
                              }
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: pinkColor.withOpacity(0.2),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                    child: Text(
                      _currentStep == 0 ? 'ileri'.tr() : 'analizi_tamamla'.tr(),
                      style: TextStyle(
                        color: _canProceed() ? pinkColor : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
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

  bool _canProceed() {
    if (_currentStep == 0) return _image1Uploaded && _image2Uploaded;
    return _image3Uploaded;
  }

  Widget _buildStepIndicator(int step, String label, bool isActive) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 4,
            width: double.infinity,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.white.withOpacity(0.6),
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep1(Color pinkColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'cilt_tipi_analizi'.tr(),
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: pinkColor),
        ),
        const SizedBox(height: 8),
        Text(
          'adim_1_aciklama'.tr(),
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: _buildUploadPlaceholder(
                'ilk_gorsel'.tr(),
                _image1Uploaded,
                pinkColor,
                () => setState(() => _image1Uploaded = !_image1Uploaded),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildUploadPlaceholder(
                'ikinci_gorsel'.tr(),
                _image2Uploaded,
                pinkColor,
                () => setState(() => _image2Uploaded = !_image2Uploaded),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep2(Color pinkColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'sorunlu_bolge_analizi'.tr(),
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: pinkColor),
        ),
        const SizedBox(height: 8),
        Text(
          'adim_2_aciklama'.tr(),
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 32),
        _buildUploadPlaceholder(
          'sorunlu_gorsel'.tr(),
          _image3Uploaded,
          pinkColor,
          () => setState(() => _image3Uploaded = !_image3Uploaded),
          isLarge: true,
        ),
      ],
    );
  }

  Widget _buildUploadPlaceholder(String label, bool isUploaded, Color color, VoidCallback onTap, {bool isLarge = false}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: isLarge ? 250 : 180,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isUploaded ? color.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isUploaded ? color : Colors.grey[300]!,
            width: 2,
            style: isUploaded ? BorderStyle.solid : BorderStyle.none,
          ),
          boxShadow: [
            if (!isUploaded)
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isUploaded ? Icons.check_circle : Icons.add_photo_alternate_outlined,
              size: isLarge ? 60 : 40,
              color: isUploaded ? color : Colors.grey[400],
            ),
            const SizedBox(height: 12),
            Text(
              isUploaded ? 'Yüklendi' : label,
              style: TextStyle(
                color: isUploaded ? color : Colors.grey[600],
                fontWeight: isUploaded ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (!isUploaded)
              Text(
                'fotograf_sec'.tr(),
                style: TextStyle(color: color.withOpacity(0.7), fontSize: 12),
              ),
          ],
        ),
      ),
    );
  }
}
