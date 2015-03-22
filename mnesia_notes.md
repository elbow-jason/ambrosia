#### Tables Have:

1. Erlang Records(Tables in other DBs)
2. Location(Node and Directory)
3. Persistance(Ram, Disk, Both)

#### Table Creation (create_table)

on success returns :ok
on failure returns {:aborted {:reason, info}}

create_table(name, arg_list)
name is an atom
arglist is a key value list
#####atoms for arglist {atom, value}

|atom    | values                           | default | description                    |
|--------|----------------------------------|---------|--------------------------------|
|:type   | one of :set, :ordered_set, :bag  | :set    | sets the behavior of the table



Note: currently 'ordered_set' is not supported for 'disc_only_copies' tables. A table of type set or ordered_set has either zero or one record per key. Whereas a table of type bag can have an arbitrary number of records per key. The key for each record is always the first attribute of the record.