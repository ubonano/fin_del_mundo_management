import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/daily_income.dart';
import '../utils/interfaces/daily_income_repository.dart';
import 'package:logging/logging.dart';

class FirestoreDailyIncomeRepository implements DailyIncomeRepository {
  final Logger _logger;
  late final CollectionReference _collection;

  FirestoreDailyIncomeRepository(this._logger, FirebaseFirestore instance) {
    _collection = instance.collection('dailyIncomes');
  }

  @override
  Stream<List<DailyIncome>> getAll() {
    _logger.info('Starting to fetch all daily incomes');
    return _collection.snapshots().map(
      (query) {
        final incomes =
            query.docs.map((doc) => DailyIncome.fromDocument(doc)).toList();
        _logger.info('Finished fetching all daily incomes');
        return incomes;
      },
    );
  }

  @override
  Future<void> add(DailyIncome income) {
    _logger.info('Starting to add a daily income');
    return _collection
        .add(income.toDocument())
        .then((value) => _logger.info('Successfully added a daily income'))
        .catchError(
      (error) {
        _logger.severe('Failed to add a daily income: $error');
        throw error;
      },
    );
  }

  @override
  Future<void> update(DailyIncome income) {
    _logger.info('Starting to update a daily income with ID: ${income.id}');
    return _collection.doc(income.id).update(income.toDocument()).then(
      (value) {
        _logger
            .info('Successfully updated a daily income with ID: ${income.id}');
      },
    ).catchError(
      (error) {
        _logger.severe(
            'Failed to update a daily income with ID: ${income.id}. Error: $error');
        throw error;
      },
    );
  }

  @override
  Future<void> delete(DailyIncome income) {
    _logger.info('Starting to delete a daily income with ID: ${income.id}');
    return _collection
        .doc(income.id)
        .delete()
        .then((value) => _logger.info('Successfully deleted a daily income'))
        .catchError(
      (error) {
        _logger.severe(
            'Failed to delete a daily income with ID: ${income.id}. Error: $error');
        throw error;
      },
    );
  }
}
