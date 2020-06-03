# custom-objects.kak

[kakoune](https://kakoune.org) plugin for creating custom objects.

This plugin is not yet well tested. All feedback welcome.

## Purpose
Kakoune supports creating custom objects by pressing `c` in the object mode. However, the entered object definitions are not saved and cannot be predefined. This plugin allows defining custom objects to appear in the object mode and to have them interact correctly with e.g. `<a-i>` and `<a-a>`.

## Install
Source `custom-objects.kak` or install via [plug.kak](https://github.com/andreyorst/plug.kak):
```
plug 'mreppen/custom-objects.kak'
```

## Usage
The custom object format is the same as when pressing `c` in the object mode (some [restrictions](#restrictions)). Add a custom object by using `add-custom-object`. Keep in mind that inner scopes shadow outer scopes.

For example, to add an object for comments, run
```
add-custom-oject buffer "#" "\Q%opt{comment_block_begin}\E,\Q%opt{comment_block_end}\E" "comment"
```

## Restrictions
The object definition does not allow `=` or spaces.

# Related projects
- [kakoune-text-objects](https://github.com/Delapouite/kakoune-text-objects)
- [surround.kak](https://github.com/alexherbo2/surround.kak)
