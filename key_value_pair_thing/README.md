<br>

# Key Value Pair Thing 

This utility is a shortcut for storing key-value pairs as sqlite tables, for updating them and for querying their values.

<br>

## Sqlite3

KVPT has no compile-time dependencies, but it does require sqlite3 to be installed as a runtime dependency in order for the functions to create any key value stores.

To check if you have it installed on your machine, run

```
sqlite3 --version
```

<br>

## Warning : User Input

<img src="bobby_tables.png" width="100%" height="auto" />

[SQL injection](https://www.w3schools.com/sql/sql_injection.asp) is a very real danger when user input string are plugged directly into larger strings that execute code.

Don't forget to [sanitise](https://happycoding.io/tutorials/java-server/sanitizing-user-input) those input strings!

<br>
