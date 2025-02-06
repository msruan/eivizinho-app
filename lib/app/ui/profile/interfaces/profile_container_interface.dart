import 'package:eiviznho/app/ui/shared/button_widget.dart';
import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:flutter/material.dart';

class ProfileInterface extends StatelessWidget {
  const ProfileInterface({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu perfil"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.black26,
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text("Fulano",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(height: 16),
              _buildProfileField("Telefone", "869999999999"),
              _buildProfileField("Bairro padrão", "Morada Nova"),
              _buildProfileField("Email", "example@gmail.com"),
              _buildProfileField("Senha", "********"),
              // SwitchListTile(
              //   title: Text("Enviar como anônimo?"),
              //   value: true,
              //   onChanged: (value) {},
              // ),
              SizedBox(height: 20),
              Center(
                  child: Button(
                      onPress: () {},
                      title: 'Deletar minha conta',
                      backgroundColor: AppColors.red)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(color: Colors.grey[700])),
        ],
      ),
    );
  }
}
