import 'package:chat_app/data/phraseData.dart';
import 'package:chat_app/services/api_servcie.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/primary_button.dart';
import 'package:chat_app/widgets/primary_dropdown.dart';
import 'package:chat_app/widgets/primary_input.dart';
import 'package:chat_app/widgets/register_screen/Upload_Image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nickNameController = TextEditingController();
  final TextEditingController interestController = TextEditingController();

  XFile? selectedImage;

  String? genderValue;

  bool agreeToTerms = false;
  final _registerFormKey = GlobalKey<FormState>();
  static const List<DropdownMenuEntry<String>> genderEntries = [
    DropdownMenuEntry(value: 'M', label: 'Male'),
    DropdownMenuEntry(value: 'F', label: 'Female'),
    DropdownMenuEntry(value: 'O', label: 'Other'),
  ];

  @override
  void dispose() {
    nickNameController.dispose();
    super.dispose();
  }

  final String phrase = phrases.map((p) => p.text).join(" ");

  void onSubmit() {
    final nickName = nickNameController.text.trim();
    if (_registerFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Processing Data')));
    }

    Navigator.pushNamed(context, "/verify", arguments: phrase);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(32, 64, 32, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Scrollbar(
                      thickness: 0,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Form(
                          key: _registerFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    const AppText(
                                      "Create a new Account",
                                      color: AppColors.textMediumColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    SizedBox(height: 30),
                                    UploadImage(
                                      selectedImage: selectedImage,
                                      onImageSelected: (XFile? image) async {
                                        if (image == null) return;

                                        setState(() {
                                          selectedImage = image;
                                        });

                                        await CloudinaryService.uploadImage(
                                          image,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AppText(
                                    "HOW ARE YOU CALLED",
                                    color: AppColors.textSmallColor,
                                    fontSize: 12,
                                  ),
                                  const SizedBox(height: 10),

                                  PrimaryInput(
                                    placeholderText: "NickName",
                                    controller: nickNameController,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Nickname is required';
                                      }

                                      final regex = RegExp(
                                        r'^[a-zA-Z0-9_.#]+$',
                                      );

                                      if (!regex.hasMatch(value)) {
                                        return 'Only letters, numbers, _, ., # are allowed';
                                      }

                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: 5),
                                  const AppText(
                                    "e.g Azuki, Azuki #99, ... (some symbols are allowed)",
                                    color: AppColors.textSmallColor,
                                    fontSize: 12,
                                  ),

                                  const SizedBox(height: 20),
                                  const AppText(
                                    "GENDER",
                                    color: AppColors.textSmallColor,
                                    fontSize: 12,
                                  ),
                                  const SizedBox(height: 10),

                                  PrimaryDropdown(
                                    entries: genderEntries,
                                    initialValue: genderValue,
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select a gender';
                                      }
                                      return null;
                                    },
                                    onSelected: (value) {
                                      setState(() {
                                        genderValue = value;
                                      });
                                    },
                                  ),

                                  const SizedBox(height: 15),
                                  const AppText(
                                    "WHAT ARE YOU INTERESTED IN",
                                    color: AppColors.textSmallColor,
                                    fontSize: 12,
                                  ),
                                  const SizedBox(height: 10),

                                  PrimaryInput(
                                    placeholderText: "(optional)",
                                    controller: interestController,
                                  ),

                                  const SizedBox(height: 5),
                                  const AppText(
                                    "e.g Design, Photography, ... etc.",
                                    color: AppColors.textSmallColor,
                                    fontSize: 12,
                                  ),

                                  const SizedBox(height: 20),

                                  Row(
                                    children: [
                                      AppText(
                                        "YOUR KEY PHRASE",
                                        color: AppColors.textSmallColor,
                                        fontSize: 12,
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          Clipboard.setData(
                                            ClipboardData(text: phrase),
                                          );
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: const AppText(
                                                "Phrase Copied",
                                                color:
                                                    AppColors.primaryLightColor,
                                              ),
                                            ),
                                          );
                                        },
                                        child: const AppText(
                                          "COPY",
                                          color: AppColors.primaryColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 5),
                                  PrimaryInput(
                                    placeholderText: phrase,
                                    maxlines: 4,
                                    readOnly: true,
                                  ),

                                  const SizedBox(height: 5),
                                  const AppText(
                                    "Save the key phrase to a safe place. This is the one and only access to your account.",
                                    color: AppColors.dangerColor,
                                    fontSize: 12,
                                  ),

                                  const SizedBox(height: 20),
                                ],
                              ),

                              FormField<bool>(
                                initialValue: agreeToTerms,
                                validator: (value) {
                                  if (value != true) {
                                    return 'You must agree to the terms';
                                  }
                                  return null;
                                },
                                builder: (field) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Transform.translate(
                                            offset: const Offset(-8, -6),
                                            child: Checkbox(
                                              value: field.value ?? false,
                                              onChanged: (value) {
                                                field.didChange(value);
                                                setState(() {
                                                  agreeToTerms = value ?? false;
                                                });
                                              },
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          const Expanded(
                                            child: AppText(
                                              "By registering an account, you are agreeing to the Terms and Agreement of Chatx.",
                                              color: AppColors.textSmallColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),

                                      if (field.hasError)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 12,
                                            top: 4,
                                          ),
                                          child: Text(
                                            field.errorText!,
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),

                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(text: "Continue", onCick: onSubmit),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
