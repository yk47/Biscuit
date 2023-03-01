import 'package:biscuit2/Pages/Main_Screens/settings.dart';
import 'package:biscuit2/temp/Firsttab.dart';
import 'package:biscuit2/temp/Secondtab.dart';
import 'package:biscuit2/temp/thiredtab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfilePage extends StatefulWidget {
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String _value = 'one';
  var img = Image.asset('assets/images/user1.png');
  //late File img = File('assets/images/user1.png');
  //File? imgFile;
  File imageFile = File('');
  String? imgPath;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future _getFromGallery() async {
    ImagePicker picker = ImagePicker();
    final pickFile = await picker.getImage(source: ImageSource.gallery);
    if (pickFile != null) {
      saveData(pickFile.path.toString());
      setState(() {
        imageFile = File(pickFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //var imgf = Image.file(File(imgPath!));
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/biscuit_logo.png',
                fit: BoxFit.contain,
                height: 40,
              ),
              SizedBox(
                width: 20,
              ),
              new DropdownButtonHideUnderline(
                child: new DropdownButton<String>(
                  value: _value,
                  items: <DropdownMenuItem<String>>[
                    new DropdownMenuItem(
                      child: new Text('Yash Karnik'),
                      value: 'one',
                    ),
                  ],
                  onChanged: (value) => _value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 140),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return Setting();
                      }));
                    },
                    icon: Icon(
                      Icons.settings_outlined,
                      size: 30,
                    )),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            SizedBox(height: 20),
            // profile photo
            if (imgPath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: imgPath != null
                    ? Image.file(
                        File(imgPath!),
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      )
                    : Image.asset(
                        'assets/images/user1.png',
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      ),
              ),
            // CircleAvatar(
            //   backgroundImage:  ,

            //   //child: Image.file(File(imgPath!)),
            //   radius: 50,
            // ),

            // username
            Padding(
              padding: const EdgeInsets.only(left: 140),
              child: Row(
                children: [
                  Text(
                    'Yash Karnik',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  IconButton(
                      onPressed: _getFromGallery,
                      icon: Image.asset('assets/images/edit.png'))
                ],
              ),
            ),

            // number of following, followers, likes
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Column(
                      children: [
                        Text(
                          '6',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Post',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          '65',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Following',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(
                          '56',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '  Followers  ',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),

            SizedBox(height: 15),

            // bio

            // default tab controller

            TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.grid_3x3, color: Colors.white),
                ),
                Tab(
                  icon: Icon(Icons.favorite, color: Colors.white),
                ),
                Tab(
                  icon: Icon(Icons.lock_outline_rounded, color: Colors.white),
                ),
              ],
            ),

            Expanded(
              child: TabBarView(
                children: [
                  FirstTab(),
                  SecondTab(),
                  ThiredTab(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // void getImg() async {
  //   final pickedImage =
  //       await ImagePicker().getImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     saveData(pickedImage.path.toString()); // path cache
  //     setState(() {
  //       imageFile = File(pickedImage.path);
  //     });
  //   }
  // }

  void saveData(String val) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString('path', val);
    getData();
  }

  void getData() async {
    final sharedPref = await SharedPreferences.getInstance();
    setState(() {
      imgPath = sharedPref.getString('path');
    });
  }

  void deleteData() async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.remove('path');
    getData();
  }
}
