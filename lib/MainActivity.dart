import 'package:flutter/material.dart';
import 'package:reside_menu/residemenu.dart';
import 'fabbutton.dart';
import 'layout.dart';

class MainActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _MainActivityState();
  }
}

class _MainActivityState extends State<MainActivity>
    with TickerProviderStateMixin {

  String _lastSelected = 'TAB: 0';

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = 'TAB: $index';
    });
  }

  void _selectedFab(int index) {
    setState(() {
      _lastSelected = 'FAB: $index';
    });
  }


  MenuController _menuController;

  Widget buildItem(String msg,Widget img) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        child: ResideMenuItem(
          title: msg, icon: img,),
        onTap: () {
          Scaffold
              .of(context)
              .showSnackBar(new SnackBar(content: new Text('Clicked : $msg')));
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return new ResideMenu.scafford(
      direction: ScrollDirection.LEFT,
      decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("images/menu_background.png"),
              fit: BoxFit.cover)),
      controller: _menuController,
      leftScaffold: new MenuScaffold(
        header: new ConstrainedBox(

          constraints: new BoxConstraints(maxHeight: 80.0, maxWidth: 80.0),
          child: new CircleAvatar(

            backgroundImage: new AssetImage('images/author.jpg'),
            radius: 40.0,
          ),
        ),
        children: <Widget>[
          buildItem("Home",Icon(Icons.home,color: Colors.white,)),
          buildItem("Cart",Icon(Icons.shopping_cart,color: Colors.white)),
          buildItem("Restaurant",Icon(Icons.restaurant,color: Colors.white)),
          buildItem("About Us",Icon(Icons.info,color: Colors.white)),
          buildItem("Share",Icon(Icons.share,color: Colors.white)),
          buildItem("Rate Us", Icon(Icons.star_border,color: Colors.white)),
          buildItem("LogOut", Icon(Icons.exit_to_app,color: Colors.white))
        ],
      ),

      child: new Scaffold(
        body: Center(
          child: Text(
            _lastSelected,
            style: TextStyle(fontSize: 32.0),
          ),
        ),
        appBar: new AppBar(
          leading: new GestureDetector(
            child: const Icon(Icons.menu),
            onTap: () {
              _menuController.openMenu(true);
            },
          ),
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: new Text('ResideMenu'),
        ),
        bottomNavigationBar: FABBottomAppBar(
          centerItemText: 'Cart',
          color: Colors.grey,
          selectedColor: Colors.blue,
          notchedShape: CircularNotchedRectangle(),
          onTabSelected: _selectedTab,
          items: [
            FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
            FABBottomAppBarItem(iconData: Icons.restaurant, text: 'Restaurant'),
            FABBottomAppBarItem(iconData: Icons.share, text: 'Share'),
            FABBottomAppBarItem(iconData: Icons.info_outline, text: 'About Us'),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _buildFab(
            context),
      ),
      onClose: () {
//        print("closed");
      },
      onOpen: (left) {

      },
      onOffsetChange: (offset) {

      },
    );
  }

  AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _menuController = new MenuController(vsync: this);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }


//  @override
//  void initState() {
//    super.initState();
//
//  }

  Widget _buildFab(BuildContext context) {
    final icons = [ Icons.sms, Icons.mail, Icons.phone ];
    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
//          child: FabWithIcons(
//            icons: icons,
//            onIconTapped: _selectedFab,
//          ),
        );
      },
      child: FloatingActionButton(
        onPressed: () {
          print("Clicked");
          Scaffold
              .of(context)
              .showSnackBar(new SnackBar(content: new Text('Cart clicked')));
          },
        tooltip: 'Cart',
        child: Icon(Icons.shopping_cart),
        elevation: 2.0,
      ),
    );
  }
}