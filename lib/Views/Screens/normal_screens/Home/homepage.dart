
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ponflow_carpoolingapp/Views/Screens/normal_screens/Profile/profile_screen.dart';
import 'package:ponflow_carpoolingapp/Views/Screens/normal_screens/Routes/routes_screen.dart';
import 'package:flutter/material.dart';
import '../../../../Controller/auth_service.dart';
import '../../../../constants.dart';
import '../../auth_screens/login.dart';
import '../Chats/chats_screen.dart';
import '../Driver/drive_screen.dart';
import '../Search/search_screen.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key, required this.index}) : super(key: key);
    int index;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final AuthService _authService = AuthService();

  static final List<Widget> _screens = <Widget>[
    const SearchScreen(),
    DriveScreen(),
    const RoutesScreen(),
    const ChatsScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      User? currentUser = _authService.getCurrentUser();
      if(currentUser == null && _selectedIndex > 0 && _selectedIndex <= 4) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  LoginScreen(index: _selectedIndex,),
            ));
      }
    });
  }

  @override
  void initState(){
    super.initState();
    setState(() {
      _selectedIndex = widget.index;
    });

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: greycolor,
        selectedItemColor: secondaryColor,
        currentIndex: _selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        items: [
         BottomNavigationBarItem(
            icon: GestureDetector(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 0 ? secondaryColor : greycolor,
                  BlendMode.srcIn,
                ),
                child: const Image(
                  image: AssetImage(
                    "assets/pngicons/search_FILL0_wght400_GRAD0_opsz48.png",
                  ),
                  height: 25,
                ),
              ),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 1 ? secondaryColor : greycolor,
                  BlendMode.srcIn,
                ),
                child: const Image(
                  image: AssetImage(
                    "assets/pngicons/directions_car_FILL0_wght500_GRAD0_opsz48.png",
                  ),
                  height: 25,
                ),
              ),
            ),
            label: 'Drive',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 2 ? secondaryColor : greycolor,
                  BlendMode.srcIn,
                ),
                child: const Image(
                  image: AssetImage(
                    "assets/pngicons/conversion_path_FILL0_wght500_GRAD0_opsz48.png",
                  ),
                  height: 25,
                ),
              ),
            ),
            label: 'Routes',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 3 ? secondaryColor : greycolor,
                  BlendMode.srcIn,
                ),
                child: const Image(
                  image: AssetImage(
                    "assets/pngicons/chat_FILL0_wght500_GRAD0_opsz48.png",
                  ),
                  height: 25,
                ),
              ),
            ),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 4 ? secondaryColor : greycolor,
                  BlendMode.srcIn,
                ),
                child: const Image(
                  image: AssetImage(
                    "assets/pngicons/account_circle_FILL0_wght500_GRAD0_opsz48.png",
                  ),
                  height: 25,
                ),
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}