import 'package:hive_ce/hive.dart';
import 'package:fithub_home_test/data/implementation/local/entity/movie_detail_entity.dart';

@GenerateAdapters([
  AdapterSpec<MovieDetailEntity>(),
  AdapterSpec<GenreEntity>(),
  AdapterSpec<ProductionCompanyEntity>(),
])
part 'hive_adapters.g.dart';