import 'package:fin_del_mundo_management/modules/branch/branch_repository.dart';
import '../branch.dart';
import '../../user/user.dart';
import '../../../setup/get_it_setup.dart';

void branchDefaultGenerate() async {
  final branchRepository = getIt<BranchRepository>();

  Branch restaurantBranch = Branch(
    id: '',
    name: 'Restaurante',
    createdAt: DateTime.now(),
    createdBy: User(id: 'system', name: 'System'),
    modifiedBy: User(id: 'system', name: 'System'),
    modifiedAt: DateTime.now(),
  );

  Branch nightclubBranch = Branch(
    id: '',
    name: 'Discoteca',
    createdAt: DateTime.now(),
    createdBy: User(id: 'system', name: 'System'),
    modifiedBy: User(id: 'system', name: 'System'),
    modifiedAt: DateTime.now(),
  );

  try {
    await branchRepository.add(restaurantBranch);
    await branchRepository.add(nightclubBranch);

    print('Branches created successfully.');
  } catch (e) {
    print('Failed to create branches: $e');
  }
}
