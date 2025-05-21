import 'package:cari_magang_fe/app/core/appcolors.dart';
import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const SuccessDialog({
    super.key,
    this.title = "Berhasil Apply Pekerjaan",
    this.message =
        "Kami akan memberitahu kamu pembaruan selanjutnya melalui notifikasi.\nTetap semangat!",
    this.buttonText = "Back",
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 93,
            color: Appcolors.thirdColor,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              color: Appcolors.thirdColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: 'Urbanist',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: const TextStyle(
              fontSize: 12,
              color: Appcolors.thirdColor,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onButtonPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolors.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  color: Appcolors.secondaryColor,
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
