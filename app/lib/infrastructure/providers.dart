import 'package:nucleus_agenda/view/providers/contact_notifier.dart';
import 'package:provider/provider.dart';

List<ChangeNotifierProvider> providers = [
  ChangeNotifierProvider<ContactNotifier>(create: (_) => ContactNotifier()),
];
