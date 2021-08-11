import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mebeluiexam/UI/login_page.dart';
import 'package:mebeluiexam/UI/main_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mebeluiexam/local_databse/database_helper.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

import 'local_databse/picture.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static List imglist = [
    "https://thumbs.dreamstime.com/z/interior-design-stylish-living-room-modern-neutral-sofa-furniture-mock-up-poster-farmes-dried-flowers-vase-coffee-214093789.jpg",
    "https://assets.weimgs.com/weimgs/ab/images/dp/ecm/202118/1390/001/001.jpg",
    "https://www.mymove.com/wp-content/uploads/2020/07/staircase-design-railing.jpg",
    "https://images.unsplash.com/photo-1513694203232-719a280e022f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8bm92b3dvZHJvJTIwYmlvJTIwcm9vbXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=60",
  ];
  static List tekstlar = [
    [
      "Primary wall",
      "staircase",
      "Living Room There",
      "Una Chair",
    ],
    [
      "Walpaper wall",
      "Sofa",
      "Hall is There",
      "Living Room There",
    ],
    [
      "Mirror Wall",
      "stair",
      "Office is there",
      "furniture",
    ],
    [
      "Primary wall",
      "Sofa",
      "Bed Room there",
      "bedroom",
    ],
  ];

  static List rasm = [
    [
      "https://thumbs.dreamstime.com/z/interior-design-stylish-living-room-modern-neutral-sofa-furniture-mock-up-poster-farmes-dried-flowers-vase-coffee-214093789.jpg",
      "https://assets.weimgs.com/weimgs/ab/images/dp/ecm/202118/1390/001/001.jpg",
      "https://www.mymove.com/wp-content/uploads/2020/07/staircase-design-railing.jpg",
      "https://images.unsplash.com/photo-1513694203232-719a280e022f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8bm92b3dvZHJvJTIwYmlvJTIwcm9vbXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=60"
    ],
    [
      "https://images.unsplash.com/photo-1461988625982-7e46a099bf4f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
      "https://images.unsplash.com/photo-1498409785966-ab341407de6e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDJ8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
      "https://images.unsplash.com/photo-1518604100146-5d90d05f1b58?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDV8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
      "https://images.unsplash.com/photo-1462826303086-329426d1aef5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bm92b3dvZHJvJTIwYmlvJTIwcm9vbXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=60",
    ],
    [
      "https://images.unsplash.com/photo-1560264280-88b68371db39?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8d29ya3BsYWNlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=60",
      "https://images.unsplash.com/file-1626897789502-538d933b419fimage",
      "https://images.unsplash.com/photo-1556761175-4b46a572b786?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8d29ya3BsYWNlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=60",
      "https://images.unsplash.com/photo-1549637642-90187f64f420?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8d29ya3BsYWNlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=1000&q=60",
    ],
    [
      "https://images.unsplash.com/photo-1562664348-1ee6c6c0ce92?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE4fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60",
      "https://images.unsplash.com/photo-1541533260371-b8fc9b596d84?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXRodW1ibmFpbHx8d04wREpscGZlOHd8fGVufDB8fHx8&dpr=2&auto=format&fit=crop&w=291.2&q=60",
      "https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8d29ya3BsYWNlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=60",
      "https://images.unsplash.com/photo-1541746972996-4e0b0f43e02a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHdvcmtwbGFjZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=60",
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (RouteSettings settings) {
        List<String> path = settings.name.toString().split("/");
        if (path[1] == "OngeneratePage1") {
          return MaterialPageRoute(
              builder: (context) => MainPage(int.parse(path[2])));
        }
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: _lightTheme,
      home: LoginPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var verfiy = Firebase.initializeApp();

  int currentindex = 0;
  var _key = GlobalKey<ScaffoldState>();
  DatabaseHelper databaseHelper = DatabaseHelper();
  static ThemeData darktema = ThemeData.light();
  final ImagePicker _picker = ImagePicker();
  File? _image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _getPictures() async {
    for (String item in MyApp.rasm[currentindex]) {
      var image = await http.get(Uri.parse(item));

      var bytes = image.bodyBytes;
      Picture picture = Picture(picture: bytes);

      databaseHelper.insertPicture(picture);
    }
  }

  var a;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800.withOpacity(1),
        elevation: 0,
        leading: InkWell(
          onTap: () {
            _key.currentState!.openDrawer();
          },
          child: Icon(
            Icons.menu_rounded,
            color: Colors.white,
          ),
        ),
        actions: [Icon(Icons.more_vert_outlined)],
      ),
      endDrawer: buildProfileDrawer(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
                accountName: Text("Baxtiyor"),
                accountEmail: Text("@baxtiyor611"),
                currentAccountPicture: InkWell(
                  onTap: () {
                    _imgFromGallery();
                  },
                  child: _image != null
                      ? CircleAvatar(
                          backgroundImage: FileImage(_image!),
                          radius: 40.0,
                          backgroundColor: Colors.indigo.shade400,
                        )
                      : CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Colors.orange,
                          child: Icon(
                            CupertinoIcons.camera,
                            color: Colors.grey.shade100,
                            size: 32.0,
                          ),
                        ),
                )),
            // DrawerHeader(
            //   decoration: BoxDecoration(
            //     color: Colors.grey.shade500.withOpacity(0.5),
            //   ),
            //   child: Text(
            //     'John Antony',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 24,
            //     ),
            //   ),
            // ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: InkWell(
                child: Icon(Icons.settings),
              ),
              onTap: () {},
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10, left: 30, right: 30),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey.shade800.withOpacity(1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: 250,
              child: Text(
                "Luxury, Style and Comfort",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Get customized furniture for  your choice",
                    style: TextStyle(
                        // fontSize: 20,
                        color: Colors.white,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "online at your one click",
                    style: TextStyle(
                        // fontSize: 20,
                        color: Colors.white,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  makebutton(
                    0,
                    AssetImage("assets/icons/sofa.png"),
                  ),
                  makebutton(
                    1,
                    AssetImage("assets/icons/chair.png"),
                  ),
                  makebutton(
                    2,
                    AssetImage("assets/icons/bed.png"),
                  ),
                  makebutton(
                    3,
                    AssetImage("assets/icons/lamp.png"),
                  ),
                ],
              ),
            ),
            Text(
              "Popular themes",
              style: TextStyle(
                  fontSize: 29,
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                  future: databaseHelper.queryPicture(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length != 0) {
                        List<Picture> lst1 = snapshot.data;
                        return StaggeredGridView.countBuilder(
                          crossAxisCount: 4,
                          itemCount: MyApp.imglist.length,
                          itemBuilder: (BuildContext context, int index) =>
                              InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, "/OngeneratePage1/$index");
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: MemoryImage(lst1[index].picture!),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          staggeredTileBuilder: (int index) =>
                              StaggeredTile.count(2, index.isEven ? 3 : 2),
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                        );
                      }
                    } else {
                      _getPictures();
                    }

                    return StaggeredGridView.countBuilder(
                      crossAxisCount: 4,
                      itemCount: MyApp.imglist.length,
                      itemBuilder: (BuildContext context, int index) => InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, "/OngeneratePage1/$index");
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  NetworkImage(MyApp.rasm[currentindex][index]),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      staggeredTileBuilder: (int index) =>
                          StaggeredTile.count(2, index.isEven ? 3 : 2),
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }

  buildProfileDrawer() {
    return Drawer();
  }

  makebutton(index, icon) {
    Color rang = Colors.transparent;

    if (index == currentindex) {
      rang = Colors.grey.shade600;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          currentindex = index;
        });
      },
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: rang,
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: icon,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  _imgFromGallery() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image!.path);
    });
    a = _image;
  }

  void showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text('Photo Library'),
                  onTap: () {
                    _imgFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
