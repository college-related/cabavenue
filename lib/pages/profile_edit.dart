import 'package:flutter/material.dart';

void main(){
  runApp( const EditProfile());
}

class EditProfile extends StatelessWidget{
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Profile Edit",
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget{
  @override
 

}
