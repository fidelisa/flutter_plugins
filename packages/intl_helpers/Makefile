install:
	flutter pub pub global activate intl_translation

extract:
	flutter pub pub global run intl_translation:extract_to_arb --output-dir=lib/l10n lib/intl_helpers.dart

build:
	flutter pub pub global run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/intl_helpers.dart lib/l10n/helpers_*.arb
