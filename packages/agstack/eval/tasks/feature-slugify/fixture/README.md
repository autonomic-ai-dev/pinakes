# slugify

`slugify STRING` prints STRING as a URL slug:

- lowercase ASCII letters and digits are kept;
- uppercase letters are lowercased;
- each run of any other characters becomes a single `-`;
- no leading or trailing `-`.

Example: `slugify "Hello, World!"` prints `hello-world`.
