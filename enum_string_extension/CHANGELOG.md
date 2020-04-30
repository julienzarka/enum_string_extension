## 0.0.5

* Add support for namespace. If a namespace is declared on one of the keys, it will be forced for all keys with the same name.

## 0.0.4

* Fix bugs in `EnumKey` handling (unique, determinism) and in some code generated

## 0.0.3

* Add support for `EnumKey` with prefix parameter and exclude option
* Exclude parameter prevent code gen
* Prefix parameter creates an changes the prefix of the text() and adds the prefix to the AppLocalization fields

## 0.0.2 Fix multiple enum and support subtypes for `List<T>`

* Fix bug that prevented multiple enum to generate code
* Add support for types inside lists

## 0.0.1 Initial release

* Lets you annotate an object using `@enumString` to generate a `enumString` extension
