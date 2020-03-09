// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// Придумайте пин-код для быстрого входа
  internal static let enterNewPinTitle = L10n.tr("Localizable", "enter_new_pin_title")
  /// Вы не добавили ни одного фильма
  internal static let favoriteEmptyTitle = L10n.tr("Localizable", "favorite_empty_title")
  /// Найти любимые фильмы
  internal static let favoriteFindTitle = L10n.tr("Localizable", "favorite_find_title")
  /// Избранное
  internal static let favoriteTabTitle = L10n.tr("Localizable", "favorite_tab_title")
  /// Избранное
  internal static let favoriteTitle = L10n.tr("Localizable", "favorite_title")
  /// По вашему запросу ничего не найдено :(
  internal static let filmNotFoundTitle = L10n.tr("Localizable", "film_not_found_title")
  /// Рейтинг фильма
  internal static let filmRaiting = L10n.tr("Localizable", "film_raiting")
  /// Время
  internal static let filmRuntime = L10n.tr("Localizable", "film_runtime")
  /// Поиск фильмов
  internal static let filmSearchBarPlaceholder = L10n.tr("Localizable", "film_search_bar_placeholder")
  /// Найдем любой фильм на ваш вкус
  internal static let filmSearchTitle = L10n.tr("Localizable", "film_search_title")
  /// Фильмы
  internal static let filmsTabTitle = L10n.tr("Localizable", "films_tab_title")
  /// Неверный логин или пароль
  internal static let invalidCredentialsError = L10n.tr("Localizable", "invalid_credentials_error")
  /// Неверный пин-код
  internal static let invalidPinError = L10n.tr("Localizable", "invalid_pin_error")
  /// Войти
  internal static let loginButtonText = L10n.tr("Localizable", "login_button_text")
  /// Что-то пошло не так, попробуйте войти позже
  internal static let loginFailedError = L10n.tr("Localizable", "login_failed_error")
  /// Логин
  internal static let loginFieldPlaceholder = L10n.tr("Localizable", "login_field_placeholder")
  /// Выйти
  internal static let logoutButtonText = L10n.tr("Localizable", "logout_button_text")
  /// Выйти
  internal static let logutNumpadButtonText = L10n.tr("Localizable", "logut_numpad_button_text")
  /// Пароль
  internal static let passwordFieldPlaceholder = L10n.tr("Localizable", "password_field_placeholder")
  /// Профиль
  internal static let profileTabTitle = L10n.tr("Localizable", "profile_tab_title")
  /// Повторите ваш пин-код
  internal static let repeatPinTitle = L10n.tr("Localizable", "repeat_pin_title")
  /// Укажите логин и пароль, которые вы использовали для входа
  internal static let welcomeSubtitle = L10n.tr("Localizable", "welcome_subtitle")
  /// Добро пожаловать!
  internal static let welcomeTitle = L10n.tr("Localizable", "welcome_title")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String) -> String {
    return NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
  }

  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
