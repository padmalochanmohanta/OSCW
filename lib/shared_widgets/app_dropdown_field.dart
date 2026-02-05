import 'package:flutter/material.dart';

class DropdownItem {
  final int? id;
  final String nameEng;
  final String nameOdia;

  DropdownItem({this.id, required this.nameEng, required this.nameOdia});

  String displayName(String language) =>
      language == 'en' ? nameEng : nameOdia;
}

// =================== AppDropdownField ===================
class AppDropdownField extends StatefulWidget {
  final String label;
  final String language;
  final List<DropdownItem> items;
  final DropdownItem? value;
  final bool enabled;
  final void Function(DropdownItem value, String? otherText)? onChanged;
  final String? hint;

  const AppDropdownField({
    super.key,
    required this.label,
    required this.items,
    this.value,
    this.language = 'en',
    this.enabled = true,
    this.onChanged,
    this.hint,
  });

  @override
  State<AppDropdownField> createState() => _AppDropdownFieldState();
}

class _AppDropdownFieldState extends State<AppDropdownField> {
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  final TextEditingController _otherCtrl = TextEditingController();

  bool get _isOtherSelected =>
      widget.value != null &&
      (widget.value!.nameEng.toLowerCase() == 'other' ||
          widget.value!.nameOdia.contains('ଅନ୍ୟ'));

  void _toggle() {
    if (!widget.enabled) return;
   // Dismiss the keyboard when dropdown is opened
    FocusScope.of(context).unfocus();
    _isOpen ? _close() : _open();
  }

  void _open() {
    _overlayEntry = _createOverlay();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _close() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) setState(() => _isOpen = false);
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
            top: offset.dy + size.height + 6,
            width: size.width,
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(8),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 320),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: widget.items.length,
                  itemBuilder: (_, index) {
                    final item = widget.items[index];
                    return ListTile(
                      dense: true,
                      title: Text(item.displayName(widget.language)),
                      trailing: item == widget.value
                          ? const Icon(Icons.check, color: Colors.blue)
                          : null,
                      onTap: widget.enabled
                          ? () {
                              if (!_isOtherSelected) _otherCtrl.clear();
                              widget.onChanged?.call(
                                  item, _isOtherSelected ? _otherCtrl.text : null);
                              _close();
                            }
                          : null,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _otherCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayText = widget.value?.displayName(widget.language) ??
        (widget.language == 'en' ? 'Select' : 'ଚୁନିବେ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggle,
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: widget.label,
              border: const OutlineInputBorder(),
              suffixIcon: Icon(
                _isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              ),
              enabled: widget.enabled,
            ),
            child: Text(displayText,
                style: widget.enabled
                    ? null
                    : const TextStyle(color: Colors.grey)),
          ),
        ),
      //  const SizedBox(height: 8),
        // if (_isOtherSelected)
        //   TextField(
        //     controller: _otherCtrl,
        //     enabled: widget.enabled,
        //     decoration: const InputDecoration(
        //       labelText: 'Please specify',
        //       border: OutlineInputBorder(),
        //     ),
        //     onChanged: (v) => widget.onChanged?.call(widget.value!, v),
        //   ),
        const SizedBox(height: 10),
      ],
    );
  }
}