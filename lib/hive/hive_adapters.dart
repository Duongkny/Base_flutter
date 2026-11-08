import 'package:hive_ce/hive.dart';
import 'package:base_flutter/src/features/auth/data/models/user_token_model.dart';
import 'package:base_flutter/src/features/auth/domain/entites/user_token.dart';


part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<UserToken>(),
  AdapterSpec<UserTokenModel>(),

])
// This is for code generation
// ignore: unused_element
void _() {}