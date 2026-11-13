# Greeting tool

A small command-line tool that greets people by name, in a language they choose.

## Language

**Greeting**:
The single line of text the tool prints to welcome a person, such as `Hello, Ana!`.
_Avoid_: Message, salutation

**Language code**:
The short, case-insensitive code naming which language a Greeting is in: `en`, `es` or `fr`.
_Avoid_: Locale, language name

**Default language**:
The language used when no Language code is given: English.
_Avoid_: Fallback language
