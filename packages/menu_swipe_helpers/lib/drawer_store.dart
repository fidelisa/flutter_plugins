import 'package:menu_swipe_helpers/drawer_helper.dart';
import 'package:menu_swipe_helpers/drawer_state.dart';
import 'package:redux/redux.dart';

createDrawerStore(DrawerHelper drawerHelper) => new Store<DrawerState>(
      drawerAppReducer,
      initialState: new DrawerState(
          activeDrawer: drawerHelper,
          activePage: drawerHelper.drawerContents.first),
    );
