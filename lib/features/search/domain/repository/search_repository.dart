import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/model/search_place_model.dart';

abstract class SearchRepository {
  Future<Either<Failure, SearchPlacesModel>> searchPlaceByKeyword(
    String keyword,
  );
}
