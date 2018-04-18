import 'package:menu_swipe_helpers/actions/actions.dart';
import 'package:menu_swipe_helpers/drawer_helper.dart';
import 'package:menu_swipe_helpers/drawer_state.dart';
import 'package:redux/redux.dart';

List<Middleware<DrawerState>> createDrawerMiddleware() {
  final updateDrawer = _createUpdateDrawer();

  return [
    new TypedMiddleware<DrawerState, UpdateDrawerAction>(updateDrawer),
  ];
}

Middleware<DrawerState> _createUpdateDrawer() {
  return (Store<DrawerState> store, action, NextDispatcher next) {
    if (action.newDrawer.runtimeType == DrawerHelper) {
      DrawerHelper drawerHelper = action.newDrawer;
      var firstPage = drawerHelper.drawerContents.first;
      if (firstPage != null) {
        store.dispatch(new ChangePageAction(firstPage));
      }
    }

    next(action);
  };
}
