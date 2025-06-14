import 'package:fithub_home_test/data/implementation/local/entity/movie_entity.dart';
import 'package:fithub_home_test/data/implementation/local/entity/movies_entity.dart';
import 'package:hive_ce/hive.dart';
import 'package:fithub_home_test/data/implementation/local/entity/movie_detail_entity.dart';

@GenerateAdapters([
  AdapterSpec<MovieDetailEntity>(),
  AdapterSpec<GenreEntity>(),
  AdapterSpec<ProductionCompanyEntity>(),
  AdapterSpec<MoviesEntity>(),
  AdapterSpec<MovieEntity>(),
])
part 'hive_adapters.g.dart';