import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:base_flutter/src/core/local_storage/app_local_storage.dart';
import 'package:base_flutter/src/core/local_storage/local_storage_key.dart';

import 'package:language_code/language_code.dart';

import '../models/language.dart';

part 'localization_event.dart';
part 'localization_state.dart';

const languagePrefsKey = 'languagePrefs';

class LocalizationBloc extends Bloc<LocalizationEvent, AppLocalizationState> {
  LocalizationBloc() : super(const AppLocalizationState()) {
    on<ChangeLanguage>(onChangeLanguage);
    on<GetLanguage>(onGetLanguage);
  }

  Future<void> onChangeLanguage(
    ChangeLanguage event,
    Emitter<AppLocalizationState> emit,
  ) async {
    AppLocalStorage.update(
      LocalStorageKey.languagePrefs,
      event.selectedLanguage.value.languageCode,
    );
    emit(state.copyWith(selectedLanguage: event.selectedLanguage));
    AppLocalStorage.currentLanguageCode = AppLocalStorage.get(
      LocalStorageKey.languagePrefs,
    );
  }

  Future<void> onGetLanguage(
    GetLanguage event,
    Emitter<AppLocalizationState> emit,
  ) async {
    final languageCode = AppLocalStorage.get(LocalStorageKey.languagePrefs);
    emit(
      state.copyWith(
        selectedLanguage: languageCode != null
            ? Language.values.firstWhere(
                (item) => item.value.languageCode == languageCode,
                orElse: () => _selectedDefaultLanguage(),
              )
            : _selectedDefaultLanguage(),
      ),
    );
    AppLocalStorage.currentLanguageCode = AppLocalStorage.get(
      LocalStorageKey.languagePrefs,
    );
  }

  Language _selectedDefaultLanguage() {
    Language language = Language.values.firstWhere(
      (item) =>
          item.value.languageCode == LanguageCode.code.locale.languageCode,
      orElse: () => Language.en,
    );
    AppLocalStorage.update(
      LocalStorageKey.languagePrefs,
      language.value.languageCode,
    );
    return language;
  }
}