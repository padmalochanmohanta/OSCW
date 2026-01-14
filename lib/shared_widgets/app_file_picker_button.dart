import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../core/localization/app_localizations.dart';

class AppFilePickerField extends StatefulWidget {
  final int maxSizeMB;
  final List<String> allowedExtensions;

  const AppFilePickerField({
    super.key,
    this.maxSizeMB = 5,
    this.allowedExtensions = const ['jpg', 'jpeg', 'png', 'pdf'],
  });

  @override
  State<AppFilePickerField> createState() => _AppFilePickerFieldState();
}

class _AppFilePickerFieldState extends State<AppFilePickerField> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _files = [];

  Future<void> _pick(ImageSource source) async {
    final result = await _picker.pickImage(source: source);
    if (result == null) return;

    final file = File(result.path);
    final sizeMB = file.lengthSync() / (1024 * 1024);
    final ext = result.path.split('.').last.toLowerCase();

    if (!widget.allowedExtensions.contains(ext) ||
        sizeMB > widget.maxSizeMB) {
      _showError();
      return;
    }

    setState(() => _files.add(result));
  }

  void _showError() {
    final t = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "${t.translate('invalid_file')} • ${t.translate('max_file_size')}",
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showPicker() {
    final t = AppLocalizations.of(context);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading:
              const Icon(Icons.camera_alt, color: AppColors.primary),
              title: Text(t.translate('camera')),
              onTap: () {
                Navigator.pop(context);
                _pick(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library,
                  color: AppColors.primary),
              title: Text(t.translate('gallery')),
              onTap: () {
                Navigator.pop(context);
                _pick(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OutlinedButton.icon(
          onPressed: _showPicker,
          icon:
          const Icon(Icons.attach_file, color: AppColors.primary),
          label: Text(
            t.translate('choose_file'),
            style: AppTextStyles.body.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(height: 8),

        // SELECTED FILES
        ..._files.map(
              (file) => ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.insert_drive_file,
                color: AppColors.primary),
            title: Text(
              file.name,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.close, size: 18),
              onPressed: () {
                setState(() => _files.remove(file));
              },
            ),
          ),
        ),
      ],
    );
  }
}
