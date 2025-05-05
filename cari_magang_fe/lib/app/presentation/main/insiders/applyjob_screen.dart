import 'package:cari_magang_fe/app/core/components/success_dialog.dart';
import 'package:flutter/material.dart';

class ApplyjobScreen extends StatelessWidget {
  const ApplyjobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.deepOrange),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: const [
                  Text(
                    'Application',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '(Insert Below)',
                    style: TextStyle(fontSize: 16, color: Colors.deepOrange),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Upload CV
            const Text(
              "CV",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _UploadBox(text: "Upload CV as a PDF"),

            const SizedBox(height: 24),

            // Upload Sertifikat
            const Text(
              "Sertification",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const _UploadBox(),

            const SizedBox(height: 32),

            // Summary Section
            const Center(
              child: Column(
                children: [
                  Text(
                    'Summary',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Personal User Data',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Form Fields
            const _FormLabelInput(label: 'Nama \nLengkap'),
            const _FormLabelInput(label: 'Tanggal \nLahir'),
            const _FormLabelInput(label: 'Alamat'),
            const Row(
              children: [
                Expanded(child: _FormLabelInput(label: 'Kuliah')),
                SizedBox(width: 16),
                Expanded(child: _FormLabelInput(label: 'Jurusan')),
              ],
            ),

            const SizedBox(height: 32),

            // Submit Button
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder:
                          (_) => SuccessDialog(
                            onButtonPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(
                                context,
                              ); // Kembali ke halaman sebelumnya
                            },
                          ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Save & Apply',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UploadBox extends StatelessWidget {
  final String? text;
  const _UploadBox({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Icon(Icons.add, size: 36, color: Colors.black),
          if (text != null) ...[
            const SizedBox(height: 8),
            Text(text!, style: const TextStyle(color: Colors.deepOrange)),
          ],
        ],
      ),
    );
  }
}

class _FormLabelInput extends StatelessWidget {
  final String label;
  const _FormLabelInput({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                fillColor: const Color(0xFFF3F3F3),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
