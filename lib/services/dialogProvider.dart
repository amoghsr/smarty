import 'package:flutter/material.dart';
import 'package:smarty/services/AIPopUpService.dart';
import 'package:smarty/services/dialogLocator.dart';
import 'package:smarty/services/doorbellPopUpService.dart';
import 'package:smarty/services/firePopUpService.dart';
import 'package:smarty/services/p2pPopUpService.dart';

class DialogProvider extends ChangeNotifier {
  final AIDialogService _aiDialog = locator<AIDialogService>();
  final P2PDialogService _p2pDialog = locator<P2PDialogService>();
  final DoorBellService _doorBellDialog = locator<DoorBellService>();
  final FireService _fireDialog = locator<FireService>();
  Future popAi() async {
    await _aiDialog.showDialog();
  }

  Future popP2P() async {
    await _p2pDialog.showDialog();
  }

  Future popDoorBell() async {
    await _doorBellDialog.showDialog();
  }

  Future popFireDialog() async {
    await _fireDialog.showDialog();
  }
}
