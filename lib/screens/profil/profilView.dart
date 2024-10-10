import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart'; // Assurez-vous d'avoir importé go_router
import 'package:serenmind/constants/styles.dart';
import 'package:serenmind/generated/l10n.dart';
import 'package:serenmind/screens/profil/profilController.dart';

class ProfilView extends StatefulWidget {
  @override
  _ProfilViewState createState() => _ProfilViewState();
}

class _ProfilViewState extends State<ProfilView> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  bool _hasChanged = false;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  void _loadUserProfile() {
    final profilController =
        Provider.of<ProfilController>(context, listen: false);
    profilController.loadUserProfile().then((_) {
      if (profilController.userData != null) {
        setState(() {
          _firstNameController.text =
              profilController.userData?['firstName'] ?? '';
          _lastNameController.text =
              profilController.userData?['lastName'] ?? '';
          _ageController.text = profilController.userData?['age'] ?? '';
        });
      }
    });

    _firstNameController.addListener(_checkForChanges);
    _lastNameController.addListener(_checkForChanges);
    _ageController.addListener(_checkForChanges);
  }

  void _checkForChanges() {
    final profilController =
        Provider.of<ProfilController>(context, listen: false);
    bool changed = _firstNameController.text !=
            profilController.userData?['firstName'] ||
        _lastNameController.text != profilController.userData?['lastName'] ||
        _ageController.text != profilController.userData?['age'];

    setState(() {
      _hasChanged = changed;
    });
  }

  void _updateProfile() async {
    final profilController =
        Provider.of<ProfilController>(context, listen: false);
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();
    String age = _ageController.text.trim();

    await profilController.updateUserProfile(
      firstName: firstName,
      lastName: lastName,
      age: age,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.of(context).profileUpdated),
        backgroundColor: Colors.green,
      ),
    );

    setState(() {
      _hasChanged = false;
    });
  }

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).confirmDelete),
          content: Text(S.of(context).deleteAccountWarning),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).cancel),
            ),
            TextButton(
              onPressed: () async {
                final profilController =
                    Provider.of<ProfilController>(context, listen: false);
                await profilController.deleteUserAccount(context);
                Navigator.of(context).pop();
                context.go('/'); // Assurez-vous que context.go est bien utilisé
              },
              child: Text(
                S.of(context).deleteAccount,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final profilController = Provider.of<ProfilController>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: profilController.userData == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/zen_profile.png',
                        height: 150,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        S.of(context).profileTitle,
                        style: AppTextStyles.headline1,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        S.of(context).profileSubtitle,
                        style: AppTextStyles.bodyText1,
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _firstNameController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.whiteColor,
                                hintText: S.of(context).firstNameHint,
                                hintStyle: AppTextStyles.bodyText2,
                                prefixIcon: const Icon(Icons.person,
                                    color: AppColors.primaryColor),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _lastNameController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.whiteColor,
                                hintText: S.of(context).lastNameHint,
                                hintStyle: AppTextStyles.bodyText2,
                                prefixIcon: const Icon(Icons.person,
                                    color: AppColors.primaryColor),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.whiteColor,
                          hintText: S.of(context).ageHint,
                          hintStyle: AppTextStyles.bodyText2,
                          prefixIcon: const Icon(Icons.cake,
                              color: AppColors.primaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _hasChanged ? _updateProfile : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _hasChanged
                              ? AppColors.primaryColor
                              : Colors.grey,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          S.of(context).saveChanges,
                          style: AppTextStyles.buttonText,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _confirmDeleteAccount,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          S.of(context).deleteAccount,
                          style: AppTextStyles.buttonText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
