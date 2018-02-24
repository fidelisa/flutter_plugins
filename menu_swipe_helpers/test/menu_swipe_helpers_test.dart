import 'package:flutter/material.dart';
import 'package:menu_swipe_helpers/menu_swipe_helpers.dart';
import 'package:test/test.dart';


void main() {
  test('DrawerModel should update', () {
    var model = new DrawerModel(
      drawer: new Container()
    );

    var newDrawer = new Container();
    model.update(newDrawer);

    expect(newDrawer, model.drawer);

  });
}
