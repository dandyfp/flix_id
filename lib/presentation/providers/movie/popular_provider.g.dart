// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$popularHash() => r'45bdbd1b31f7effbbf2517eb271f374ef5f64b73';

/// Provider using riverpod for provide state from API to UI
///
/// Copied from [Popular].
@ProviderFor(Popular)
final popularProvider = AsyncNotifierProvider<Popular, List<Movie>>.internal(
  Popular.new,
  name: r'popularProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$popularHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Popular = AsyncNotifier<List<Movie>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
