import 'package:flutter/material.dart';
import '../../../Services/auth.dart';
import '../../../Widgets/large_font.dart';
import '../../Cart Page/cart_page.dart';
import '../Food/categories_items.dart';
import '../food_page.dart';
import '../loading_page.dart';
import 'profile.dart';

class FoodDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                'Food App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: TextSize(text: 'Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FoodPage()),
              );
              // Navigator.pushNamed(context, Routes.food);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: TextSize(text: 'Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          ExpansionTile(
            leading: Icon(Icons.category),
            title: TextSize(text: 'Categories'),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 65.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoriesItemsPage(
                                pageIndex: 0,
                                isBreakfast: true,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            TextSize(text: 'BreakFast'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoriesItemsPage(
                                pageIndex: 0,
                                isSnack: true,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            TextSize(text: 'Snacks/Lunch'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoriesItemsPage(
                                pageIndex: 0,
                                isDinner: true,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            TextSize(text: 'Dinner'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoriesItemsPage(
                                pageIndex: 0,
                                isDrink: true,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            TextSize(text: 'Hot & Cold Drinks'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoriesItemsPage(
                                pageIndex: 0,
                                isDessert: true,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            TextSize(text: 'Desserts'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart_outlined),
            title: TextSize(text: 'Cart'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: TextSize(text: 'LogOut'),
            onTap: () async {
              await AuthService().SignOut();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Loading()));
              // Navigator.of(context)
              //     .pushNamedAndRemoveUntil(Routes.getHome(), (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
