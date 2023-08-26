import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Dimension/height_width.dart';
import '../../Widgets/large_font.dart';
import 'Drawer/drawer.dart';
import 'page_body.dart';
import 'search.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});
  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop', true);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFe8e8e8),
          centerTitle: true,
          title: TextSize(
            text: 'Food App',
            fontWeight: FontWeight.bold,
            color: Colors.black,
            size: 30,
          ),
          toolbarHeight: Dimensions.heightFor60,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black87, // Set the menu icon color here
          ),
          actions: [
            Padding(
              padding: EdgeInsets.all(Dimensions.heightFor10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
                child: Container(
                  width: Dimensions.heightFor45,
                  height: Dimensions.heightFor45,
                  child: Icon(
                    Icons.search,
                    color: Colors.black87,
                    size: Dimensions.iconSize24,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        drawer: FoodDrawer(),
        body: Column(
          children: [
            //showing body
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PageBody(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
