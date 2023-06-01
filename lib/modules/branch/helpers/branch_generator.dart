import 'package:fin_del_mundo_management/modules/branch/helpers/branch_repository.dart';
import '../branch.dart';
import '../../../setup/get_it_setup.dart';

void branchDefaultGenerate() async {
  final branchRepository = getIt<BranchRepository>();

  Branch restaurantBranch = Branch(
    id: 'VHoSIo5jxIcUVbfsEVcv',
    name: 'Restaurante',
  );

  Branch nightclubBranch = Branch(
    id: 'uEdiho4VWh0PgkbojfoW',
    name: 'Discoteca',
  );

  try {
    await branchRepository.add(restaurantBranch);
    await branchRepository.add(nightclubBranch);

    print('Branches created successfully.');
  } catch (e) {
    print('Failed to create branches: $e');
  }
}
