import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';

final routeStateProvider = ChangeNotifierProvider.autoDispose((ref) {
  return PersistentTabController(initialIndex: 0);
});
