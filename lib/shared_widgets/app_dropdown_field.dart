import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

class AppDropdownField extends StatefulWidget {
  final String label;
  final List<String> items;

  /// 🔹 optional callback (recommended)
  final void Function(String value, String? otherText)? onChanged;

  const AppDropdownField({
    super.key,
    required this.label,
    required this.items,
    this.onChanged,
  });

  @override
  State<AppDropdownField> createState() => _AppDropdownFieldState();
}

class _AppDropdownFieldState extends State<AppDropdownField> {
  OverlayEntry? _overlayEntry;
  String? _selected;
  bool _isOpen = false;

  final TextEditingController _searchCtrl = TextEditingController();
  final TextEditingController _otherCtrl = TextEditingController(); // 🔹 NEW
  late List<String> _filtered;

  bool get _isOtherSelected =>
      _selected != null &&
          _selected!.toLowerCase() == 'others'; // 🔹 KEY CHECK

  @override
  void initState() {
    super.initState();
    _filtered = widget.items;
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _searchCtrl.dispose();
    _otherCtrl.dispose();
    super.dispose();
  }

  void _toggle() => _isOpen ? _close() : _open();

  void _open() {
    _filtered = widget.items;
    _searchCtrl.clear();
    _overlayEntry = _createOverlay();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _close() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isOpen = false);
  }

  OverlayEntry _createOverlay() {
    final box = context.findRenderObject() as RenderBox;
    final size = box.size;
    final offset = box.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (_) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _close,
              behavior: HitTestBehavior.translucent,
            ),
          ),
          Positioned(
            left: offset.dx,
            top: offset.dy + size.height + 4,
            width: size.width,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(6),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 260),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        controller: _searchCtrl,
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        onChanged: (v) {
                          _filtered = widget.items
                              .where((e) =>
                              e.toLowerCase().contains(v.toLowerCase()))
                              .toList();
                          _overlayEntry?.markNeedsBuild();
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _filtered.length,
                        itemBuilder: (_, i) {
                          final item = _filtered[i];
                          return ListTile(
                            dense: true,
                            title: Text(item, style: AppTextStyles.body),
                            trailing: item == _selected
                                ? const Icon(Icons.check,
                                color: AppColors.primary)
                                : null,
                            onTap: () {
                              setState(() {
                                _selected = item;
                                if (!_isOtherSelected) {
                                  _otherCtrl.clear(); // 🔹 reset
                                }
                              });

                              widget.onChanged?.call(
                                item,
                                _isOtherSelected
                                    ? _otherCtrl.text
                                    : null,
                              );

                              _close();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔽 DROPDOWN
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            onTap: _toggle,
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: widget.label,
                border: const OutlineInputBorder(),
                suffixIcon: Icon(
                  _isOpen
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
              ),
              child: Text(
                _selected ?? 'Select',
                style: AppTextStyles.body,
              ),
            ),
          ),
        ),

        /// ✏️ OTHER TEXTFIELD (VISIBLE ONLY WHEN OTHERS)
        if (_isOtherSelected)
          TextField(
            controller: _otherCtrl,
            decoration: const InputDecoration(
              labelText: 'Please specify',
              border: OutlineInputBorder(),
            ),
            onChanged: (v) {
              widget.onChanged?.call(_selected!, v);
            },
          ),
        SizedBox(height: 10,),
      ],
    );
  }
}
