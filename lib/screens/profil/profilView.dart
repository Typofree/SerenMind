import 'package:flutter/material.dart';

class ProfilView extends StatefulWidget {
  @override
  _ProfilViewState createState() => _ProfilViewState();
}

class _ProfilViewState extends State<ProfilView> {
  final _emailController = TextEditingController(text: "maysasha@gmail.com");
  final _passwordController = TextEditingController(text: "********");
  final _phoneController = TextEditingController(text: "+1.415.111.0000");
  final _cityController = TextEditingController(text: "San Francisco, CA");
  final _countryController = TextEditingController(text: "USA");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            // Action pour annuler
            Navigator.of(context).pop();
          },
          child: Text("Cancel", style: TextStyle(color: Colors.blue)),
        ),
        title: Text("Edit Profile", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // Action pour sauvegarder
            },
            child: Text("Save", style: TextStyle(color: Colors.blue)),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              // Avatar avec bouton pour changer la photo
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/profile_picture.jpg'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.camera_alt, color: Colors.grey),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              // Email
              buildProfileField("YOUR EMAIL", _emailController),
              SizedBox(height: 20),
              // Password
              buildProfileField("YOUR PASSWORD", _passwordController, obscureText: true),
              SizedBox(height: 20),
              // Phone
              buildProfileField("YOUR PHONE", _phoneController),
              SizedBox(height: 20),
              // City and State
              buildProfileField("CITY, STATE", _cityController),
              SizedBox(height: 20),
              // Country
              buildProfileField("COUNTRY", _countryController),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileField(String label, TextEditingController controller, {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
            letterSpacing: 1.5,
          ),
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 5),
          ),
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        Divider(
          thickness: 1,
          color: Colors.grey[300],
        ),
      ],
    );
  }
}
