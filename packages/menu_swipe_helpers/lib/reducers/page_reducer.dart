import 'package:menu_swipe_helpers/actions/actions.dart';
import 'package:menu_swipe_helpers/drawer_definition.dart';
import 'package:redux/redux.dart';


/// page reducer
final pageReducer = combineTypedReducers<DrawerDefinition>([
  new ReducerBinding<DrawerDefinition, ChangePageAction>(_activePageReducer),
]);

DrawerDefinition _activePageReducer(
    DrawerDefinition activeDrawer, ChangePageAction action) {
  return action.newPage;
}
