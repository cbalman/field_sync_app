import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import '../../../domain/form_schema.dart';
import '../../../../../shared/theme/app_theme.dart';

class SignatureFieldWidget extends StatefulWidget {
  final InspectionField field;
  final String? value;
  final String? error;
  final ValueChanged<String?> onChanged;

  const SignatureFieldWidget({
    super.key,
    required this.field,
    this.value,
    this.error,
    required this.onChanged,
  });

  @override
  State<SignatureFieldWidget> createState() => _SignatureFieldWidgetState();
}

class _SignatureFieldWidgetState extends State<SignatureFieldWidget> {
  final _signatureKey = GlobalKey<SfSignaturePadState>();
  bool _hasSigned = false;
  bool _isSaving = false;

  Future<void> _saveSignature() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);

    try {
      final image = await _signatureKey.currentState!.toImage(pixelRatio: 2.0);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);

      if (bytes != null) {
        // Guardamos en disco local
        final dir = await getApplicationDocumentsDirectory();
        final path =
            '${dir.path}/signature_${DateTime.now().millisecondsSinceEpoch}.png';
        final file = File(path);
        await file.writeAsBytes(bytes.buffer.asUint8List());

        setState(() {
          _hasSigned = true;
          _isSaving = false;
        });

        widget.onChanged(path); // guardamos la ruta local
      }
    } finally {
      setState(() => _isSaving = false);
    }
  }

  void _clear() {
    try {
      _signatureKey.currentState?.clear();
    } catch (_) {}
    setState(() => _hasSigned = false);
    widget.onChanged(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.field.label + (widget.field.required ? ' *' : ''),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),

        // Preview de firma guardada
        if (widget.value != null && _hasSigned && File(widget.value!).existsSync())
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.synced),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(widget.value!),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              TextButton.icon(
                onPressed: _clear,
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text('Volver a firmar'),
              ),
            ],
          )
        else
        // Pad de firma
          Column(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: widget.error != null
                        ? AppColors.error
                        : Colors.grey.shade300,
                    width: widget.error != null ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SfSignaturePad(
                        key: _signatureKey,
                        backgroundColor: Colors.white,
                        strokeColor: Colors.black87,
                        minimumStrokeWidth: 1.0,
                        maximumStrokeWidth: 3.0,
                        onDrawEnd: _saveSignature,
                      ),
                    ),
                    if (!_hasSigned)
                      Center(
                        child: Text(
                          'Firmá aquí',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    if (_isSaving)
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.error != null)
                    Text(
                      widget.error!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 12,
                      ),
                    ),
                  if (_hasSigned)
                    Text(
                      '✓ Firma capturada',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.synced,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () {
                        _signatureKey.currentState?.clear();
                        setState(() => _hasSigned = false);
                        widget.onChanged(null);
                      },
                      icon: const Icon(Icons.refresh, size: 16),
                      label: const Text('Limpiar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }
}