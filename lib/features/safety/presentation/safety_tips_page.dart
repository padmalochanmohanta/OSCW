import 'package:flutter/material.dart';
import 'package:oscw/core/localization/app_localizations.dart';
import 'package:oscw/features/safety/SafetyTipsService.dart';
import 'dart:async';
import 'package:oscw/shared_widgets/app_app_bar.dart';




class SafetyTipsPage extends StatefulWidget {
  const SafetyTipsPage({super.key});

  @override
  State<SafetyTipsPage> createState() => _SafetyTipsPageState();
}

class _SafetyTipsPageState extends State<SafetyTipsPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  List<String> _imageUrls = [];
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    try {
      final images = await SafetyTipsService.fetchImageUrls();
      setState(() {
        _imageUrls = images;
        _isLoading = false;
      });
      _startAutoScroll();
    } catch (e) {
      setState(() {
        _error = 'Failed to load images';
        _isLoading = false;
      });
      debugPrint('Error fetching images: $e');
    }
  }

  void _startAutoScroll() {
    if (_imageUrls.isEmpty) return;
      _timer?.cancel(); 
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < _imageUrls.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
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
    final t = AppLocalizations.of(context); 

    return Scaffold(
      appBar: AppAppBar(
        title: t.translate("safety_tips"),
        showBack: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error.isNotEmpty
              ? Center(child: Text(_error))
              : _imageUrls.isEmpty
                  ? const Center(child: Text("No images available"))
                  : PageView.builder(
                      controller: _pageController,
                      itemCount: _imageUrls.length,
                        onPageChanged: (index) {
                                 _currentPage = index;
                      },
                      itemBuilder: (context, index) {
                        return Image.network(
                          _imageUrls[index],
                          fit: BoxFit.fill,
                          width: double.infinity,
                        );
                      },
                    ),
    );
  }
}
