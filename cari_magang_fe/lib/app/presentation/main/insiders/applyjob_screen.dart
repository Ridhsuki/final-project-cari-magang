import 'dart:io';

import 'package:cari_magang_fe/app/core/appcolors.dart';
import 'package:cari_magang_fe/app/core/components/success_dialog.dart';
import 'package:cari_magang_fe/data/models/applyjob_model/applyjob_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cari_magang_fe/app/cubit/applyjob_cubit/applyjob_cubit.dart';
import 'package:cari_magang_fe/app/cubit/applyjob_cubit/applyjob_state.dart';

class ApplyjobScreen extends StatefulWidget {
  final String internshipId;
  const ApplyjobScreen({super.key, required this.internshipId});

  @override
  State<ApplyjobScreen> createState() => _ApplyjobScreenState();
}

class _ApplyjobScreenState extends State<ApplyjobScreen> {
  File? cvFile;
  File? certificateFile;
  final nameController = TextEditingController();
  final birthController = TextEditingController();
  final addressController = TextEditingController();
  final educationController = TextEditingController();

  void _pickFile(Function(File) onFilePicked) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      onFilePicked(File(result.files.single.path!));
    }
  }

  void _submitApplication() {
    final cubit = context.read<ApplyJobCubit>();
    if (cvFile == null ||
        nameController.text.isEmpty ||
        birthController.text.isEmpty ||
        addressController.text.isEmpty ||
        educationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap lengkapi data dan unggah CV')),
      );
      return;
    }

    cubit.applyJob(
      // internshipId: widget.internshipId,
      cv: cvFile!,
      certificate: certificateFile,
      fullName: nameController.text,
      dateOfBirth: birthController.text,
      address: addressController.text,
      education: educationController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Appcolors.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: BlocConsumer<ApplyJobCubit, ApplyJobState>(
        listener: (context, state) {
          if (state.message.isNotEmpty && state.applySuccess) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder:
                  (_) => SuccessDialog(
                    onButtonPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      context.read<ApplyJobCubit>().resetApplyJob();
                    },
                  ),
            );
          } else if (state.message.isNotEmpty) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Column(
                    children: [
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
                        style: TextStyle(
                          fontSize: 16,
                          color: Appcolors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  "CV",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap:
                      () => _pickFile((file) => setState(() => cvFile = file)),
                  child: _UploadBox(
                    text: cvFile?.path.split('/').last ?? "Upload CV as a PDF",
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Sertification",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap:
                      () => _pickFile(
                        (file) => setState(() => certificateFile = file),
                      ),
                  child: _UploadBox(
                    text:
                        certificateFile?.path.split('/').last ??
                        "Upload Certificate as a PDF (Optional)",
                  ),
                ),
                const SizedBox(height: 32),
                const Center(
                  child: Column(
                    children: [
                      Text(
                        'Summary',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Personal User Data',
                        style: TextStyle(
                          fontSize: 16,
                          color: Appcolors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _FormLabelInput(
                  label: 'Nama \nLengkap',
                  controller: nameController,
                ),
                _FormLabelInput(
                  label: 'Tanggal \nLahir',
                  controller: birthController,
                ),
                _FormLabelInput(label: 'Alamat', controller: addressController),
                _FormLabelInput(
                  label: 'Pendidikan \nTerakhir',
                  controller: educationController,
                ),
                const SizedBox(height: 32),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.isLoading ? null : _submitApplication,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child:
                          state.isLoading
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : const Text(
                                'Save & Apply',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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
          const Icon(Icons.add, size: 36, color: Appcolors.thirdColor),
          if (text != null) ...[
            const SizedBox(height: 8),
            Text(text!, style: const TextStyle(color: Appcolors.primaryColor)),
          ],
        ],
      ),
    );
  }
}

class _FormLabelInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const _FormLabelInput({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
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
