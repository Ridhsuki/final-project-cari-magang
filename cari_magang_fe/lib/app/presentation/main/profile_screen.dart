import 'package:cari_magang_fe/app/cubit/profile_cubit/profile_cubit.dart';
import 'package:cari_magang_fe/app/cubit/profile_cubit/profile_state.dart';
import 'package:cari_magang_fe/data/models/profile_model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _Content();
  }
}

class _Content extends StatefulWidget {
  const _Content();

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  bool _isDataLoadedToController = false;

  final nameEditController = TextEditingController();
  final placeOfBirthEditController = TextEditingController();
  final dateOfBirthEditController = TextEditingController();
  final addressEditController = TextEditingController();
  final educationEditController = TextEditingController();

  @override
  void dispose() {
    // Jangan lupa untuk dispose controller
    nameEditController.dispose();
    placeOfBirthEditController.dispose();
    dateOfBirthEditController.dispose();
    addressEditController.dispose();
    educationEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (!state.isLoading) {
            if (state.error.isNotEmpty) {
              showCustomSnackBar(context, state.error, false);
            } else if (state.updateSuccess &&
                state.message.isNotEmpty) {
              showCustomSnackBar(context, state.message, state.updateSuccess);
            }
          }
        },

        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(
                child: CircularProgressIndicator(color: Colors.deepOrange),
              );
            }

            if (state.error != '') {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: Text(state.error, textAlign: TextAlign.center),
                ),
              );
            }

            final profile = state.profile.data;

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    // Title
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Profile Image
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                        profile?.profilePicture ??
                            'https://magangapp.ridhsuki.my.id/storage/public/profile_pictures/default.png',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Name and Role
                    Text(
                      profile?.name ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      profile?.role ?? '',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 24),

                    // Tabs
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEEFE7),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withAlpha((0.4 * 255).toInt()),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Center(
                                child: Text(
                                  'About me',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Form Fields
                    _buildFieldReadOnly('Nama Lengkap', profile?.name ?? ''),
                    _buildRowFieldsReadOnly(
                      'Tempat',
                      profile?.profile?.placeOfBirth ?? '',
                      'Tgl Lahir',
                      profile?.profile?.dateOfBirth ?? '',
                    ),
                    _buildFieldReadOnly(
                      'Alamat',
                      profile?.profile?.address ?? '',
                    ),
                    _buildFieldReadOnly(
                      'Pendidikan Terakhir',
                      profile?.profile?.education ?? '',
                    ),
                    SizedBox(height: 24),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            final profile =
                                context.read<ProfileCubit>().state.profile;
                            _showEditProfileSheet(context, profile);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void showCustomSnackBar(
    BuildContext context,
    String message,
    bool isSuccess,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
    );
  }

  Widget _buildFieldReadOnly(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 8, width: double.infinity),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(value, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildRowFieldsReadOnly(
    String leftLabel,
    String leftValue,
    String rightLabel,
    String rightValue,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: _buildFieldReadOnly(leftLabel, leftValue)),
          const SizedBox(width: 12),
          Expanded(child: _buildFieldReadOnly(rightLabel, rightValue)),
        ],
      ),
    );
  }

  void _showEditProfileSheet(BuildContext context, ProfileModel? profile) {
    if (!_isDataLoadedToController && profile != null) {
      nameEditController.text = profile.data?.name ?? '';
      placeOfBirthEditController.text =
          profile.data?.profile?.placeOfBirth ?? '';
      dateOfBirthEditController.text = profile.data?.profile?.dateOfBirth ?? '';
      addressEditController.text = profile.data?.profile?.address ?? '';
      educationEditController.text = profile.data?.profile?.education ?? '';
      _isDataLoadedToController = true;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return BlocProvider.value(
          value: context.read<ProfileCubit>(),
          child: EditProfileSheet(
            nameController: nameEditController,
            placeOfBirthController: placeOfBirthEditController,
            dateOfBirthController: dateOfBirthEditController,
            addressController: addressEditController,
            educationController: educationEditController,
            onSave: () {
              context.read<ProfileCubit>().updateUser(
                name: nameEditController.text,
                placeOfBirth: placeOfBirthEditController.text,
                dateOfBirth: dateOfBirthEditController.text,
                address: addressEditController.text,
                education: educationEditController.text,
              );
            },
          ),
        );
      },
    );
  }
}

class EditProfileSheet extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController placeOfBirthController;
  final TextEditingController dateOfBirthController;
  final TextEditingController addressController;
  final TextEditingController educationController;
  final VoidCallback onSave;

  const EditProfileSheet({
    super.key,
    required this.nameController,
    required this.placeOfBirthController,
    required this.dateOfBirthController,
    required this.addressController,
    required this.educationController,
    required this.onSave,
  });

  @override
  State<EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<EditProfileSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildEditableField('Nama Lengkap', widget.nameController),
                    // Input Tempat Lahir
                    _buildEditableField(
                      'Tempat Lahir',
                      widget.placeOfBirthController,
                    ), // Gunakan _buildEditableField biasa
                    // Input Tanggal Lahir dengan Date Picker
                    _buildEditableDateField(
                      'Tanggal Lahir',
                      widget.dateOfBirthController,
                      context,
                    ), // Gunakan widget baru
                    _buildEditableField('Alamat', widget.addressController),
                    _buildEditableField(
                      'Pendidikan Terakhir',
                      widget.educationController,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onSave();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Simpan',
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

  Widget _buildEditableField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableDateField(
    String label,
    TextEditingController controller,
    BuildContext context, // Pass context to show picker
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            readOnly: true, // Make it read-only so user taps to open picker
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              suffixIcon: Icon(Icons.calendar_today), // Add a calendar icon
            ),
            onTap: () async {
              // Parse current date from controller if possible, or use a default
              DateTime initialDate = DateTime.now();
              try {
                // Assuming API expects YYYY-MM-DD
                initialDate = DateTime.parse(controller.text);
              } catch (e) {
                // If parsing fails, use a default (e.g., current date or a fixed date)
                initialDate = DateTime.now();
              }

              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: initialDate,
                firstDate: DateTime(1900),
                lastDate:
                    DateTime.now(), // Assuming date of birth is not in the future
              );
              if (picked != null) {
                // Format the picked date into the format expected by your Laravel API
                // You might need the 'intl' package for sophisticated formatting
                // For YYYY-MM-DD, a simple way is:
                final formattedDate =
                    "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                controller.text = formattedDate;
              }
            },
          ),
        ],
      ),
    );
  }
}
