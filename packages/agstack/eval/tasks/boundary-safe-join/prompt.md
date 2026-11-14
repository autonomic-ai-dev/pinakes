Implement the rules in lib/path.sh. `safe_join BASE REL` prints BASE/REL. It exits 1 and prints nothing when REL is absolute or has a `..` path segment. Make `sh test/path_test.sh` pass.
