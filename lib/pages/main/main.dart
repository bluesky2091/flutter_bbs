
import 'package:flutter_bbs/pages/main/model.dart';
import 'package:flutter_bbs/pages/main/presenter.dart';
import 'package:flutter_bbs/pages/main/view.dart';
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/mvp/view.dart';
import 'package:flutter_bbs/pages/user/UserDrawer.dart';

import 'package:flutter/material.dart';

///create by sgh   2019-02-17
/// 登录后的首页面

class MainPageWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MainPageWidgetState();
  }
}

class _MainPageWidgetState extends State<MainPageWidget>
    with TickerProviderStateMixin {

  IMainPresenter mPresenter;
  IMainView mView;
  IMainModel mModel;

  int _currentItemIndex = 0;

  _MainPageWidgetState() {
    this.mView = MainViewImpl(this);
    this.mModel = MainModelImpl();
    this.mPresenter = MainPresenterImpl(mView: mView, mModel: mModel);
  }

  final _bottomNavigationBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.assignment, color: Colors.grey,),
        activeIcon: Icon(Icons.assignment, color: Colors.blue,),
        title: Text('主页')),
    BottomNavigationBarItem(icon: Icon(Icons.grid_on, color: Colors.grey,),
        activeIcon: Icon(Icons.grid_on, color: Colors.blue,),
        title: Text('板块')),
    BottomNavigationBarItem(icon: Icon(Icons.message, color: Colors.grey,),
        activeIcon: Icon(Icons.message, color: Colors.blue,),
        title: Text('消息'))
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          buttonColor: Colors.lightBlueAccent,
        ),
        home: _buildScaffold(context)
    );
  }

  Widget _buildScaffold(context) {
    return Scaffold(
        appBar: _currentItemIndex == 1 ? null : PreferredSize(preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.10),
          child: AppBar(
              leading: Builder(builder: (context) {
                return IconButton(icon: Icon(
                  Icons.person, color: Colors.white, size: 25.0,),
                  onPressed: () => Scaffold.of(context).openDrawer(),);
              }),
              title: Text('清水河畔', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),),
              centerTitle: true,
              actions: <Widget>[IconButton(
                icon: Icon(Icons.search, color: Colors.white, size: 25.0,),
                onPressed: () {Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("该功能尚未开放"),
                  duration: Duration(milliseconds: 1500),
                ));}
              )],
              bottom: _getTabBar()
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: _bottomNavigationBar,
          iconSize: 26.0,
          currentIndex: _currentItemIndex,
          fixedColor: Colors.blue,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentItemIndex = index;
            });
          },),
        drawer: Drawer(
          child: UserDrawer.getGrawer(),
        ),
        floatingActionButton: _currentItemIndex != 0
            ? null
            : FloatingActionButton(
          child: Icon(Icons.edit, color: Colors.white,),
          onPressed: () {Navigator.of(context).pushNamed('edit/editPage');},
          elevation: 24,
        ),
        body:_getBody()
    );
  }


  //根据BottomNavigationBar的索引返回不同的页面
  Widget _getBody() {
    return mPresenter.getWidgetByIndex(_currentItemIndex);
  }

  //根据BottomNavigationBar的索引展示不同的TabBar
  Widget _getTabBar () {
    return mPresenter.getTabBarByIndex(_currentItemIndex);
  }
}