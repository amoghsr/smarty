import 'package:get_it/get_it.dart';
import 'package:smarty/services/AIPopUpService.dart';
import 'package:smarty/services/doorbellPopUpService.dart';

import 'firePopUpService.dart';
import 'p2pPopUpService.dart';

GetIt locator = GetIt();

void setupAIPopUp() {
  locator.registerLazySingleton(() => AIDialogService());
}
void setupP2PPopUp() {
  locator.registerLazySingleton(() => P2PDialogService());
}
void setupDoorBell() {
  locator.registerLazySingleton(() => DoorBellService());
}
void setupFire() {
  locator.registerLazySingleton(() => FireService());
}