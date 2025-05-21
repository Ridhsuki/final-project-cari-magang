import 'dart:developer';
import 'dart:io';
import 'package:cari_magang_fe/app/core/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cari_magang_fe/app/core/components/success_dialog.dart';
import 'package:cari_magang_fe/data/models/profile_model/profile_model.dart';
import 'package:cari_magang_fe/app/cubit/applyjob_cubit/applyjob_cubit.dart';
import 'package:cari_magang_fe/app/cubit/applyjob_cubit/applyjob_state.dart';
import 'package:cari_magang_fe/app/cubit/profile_cubit/profile_cubit.dart';
import 'package:cari_magang_fe/app/cubit/profile_cubit/profile_state.dart';

class ApplyjobScreen extends StatelessWidget {
  final String internshipId;
  const ApplyjobScreen({super.key, required this.internshipId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ApplyJobCubit()),
        BlocProvider(create: (_) => ProfileCubit()..getUser()),
      ],
      child: _Content(internshipId: internshipId),
    );
  }
}

class _Content extends StatefulWidget {
  final String internshipId;
  const _Content({required this.internshipId});

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  File? cvFile;
  File? certificateFile;
  final nameController = TextEditingController();
  final birthController = TextEditingController();
  final addressController = TextEditingController();
  final educationController = TextEditingController();
  bool isProfileFilled = false;

  void _pickFile(Function(File) onFilePicked) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      onFilePicked(File(result.files.single.path!));
    }
  }

  Future<void> _submitApplication() async {
    if (cvFile == null ||
        nameController.text.isEmpty ||
        birthController.text.isEmpty ||
        addressController.text.isEmpty ||
        educationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Harap lengkapi data dan unggah CV'),
        ),
      );
      return;
    }

    await context.read<ApplyJobCubit>().applyJob(
      internshipId: widget.internshipId,
      cv: cvFile!,
      certificate: certificateFile,
      fullName: nameController.text,
      dateOfBirth: birthController.text,
      address: addressController.text,
      education: educationController.text,
    );
  }

  void _autoFillProfile(ProfileModel profileModel) {
    if (!isProfileFilled && profileModel.data?.profile != null) {
      final profile = profileModel.data!.profile!;

      nameController.text = profileModel.data?.name ?? '';
      birthController.text = profile.dateOfBirth?.toString() ?? '';
      addressController.text = profile.address ?? '';
      educationController.text = profile.education?.toString() ?? '';

      isProfileFilled = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ApplyJobCubit, ApplyJobState>(
      listenWhen:
          (previous, current) =>
              current.applySuccess != previous.applySuccess ||
              current.message.isNotEmpty,
      listener: (context, state) {
        log(state.applySuccess.toString());
        if (state.applyjob.message!.isNotEmpty) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder:
                (_) => SuccessDialog(
                  onButtonPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
          );
        }

        if (state.message.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(state.message),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Appcolors.primaryColor),
            onPressed: () => Navigator.pop(context),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, profileState) {
            _autoFillProfile(profileState.profile);

            return BlocBuilder<ApplyJobCubit, ApplyJobState>(
              builder: (context, applyState) {
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
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '(Insert Below)',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.bold,
                                color: Appcolors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        "CV",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap:
                            () => _pickFile(
                              (file) => setState(() => cvFile = file),
                            ),
                        child: _UploadBox(
                          text:
                              cvFile?.path.split('/').last ??
                              "Upload CV as a PDF",
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Sertification",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
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
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Personal User Data',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Urbanist',
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
                      _FormLabelInput(
                        label: 'Alamat',
                        controller: addressController,
                      ),
                      _FormLabelInput(
                        label: 'Pendidikan \nTerakhir',
                        controller: educationController,
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed:
                                applyState.isLoading
                                    ? null
                                    : _submitApplication,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Appcolors.primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child:
                                applyState.isLoading
                                    ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                    : const Text(
                                      'Save & Apply',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.bold,
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
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    birthController.dispose();
    addressController.dispose();
    educationController.dispose();
    super.dispose();
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
