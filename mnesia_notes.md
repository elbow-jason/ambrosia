#### Tables Have:

1. Erlang Records(Tables in other DBs)
2. Location(Node and Directory)
3. Persistance(Ram, Disk, Both)

#### Table Creation (create_table)

on success returns ```:ok```

on failure returns ```{:aborted {:reason, info}}```

```create_table(name, arg_list)```

```name``` is an atom

```arglist``` is a keyword list

#####atoms for arglist ```{atom, value}```

|  ```atom```             | ```value```                                 | default                         | description                               |
|------------------------ |-------------------------------------------- |-------------------------------- |------------------------------------------ |
|```:type```              | ```:set```, ```:ordered_set```, ```:bag```  | ```:set```                      | sets the behavior of the table            |
|```:disc_copies```       | NodeList                                    | Should be ```[Node.self]```     | sets where disk copies should exist       |
|```:ram_copies```        | NodeList                                    | Should be ```[Node.self]```     | sets where ram copies should exist        |
|```:disc_only_copies```  | NodeList                                    | Should be ```[Node.self]```     | sets where ram copies should exist        |
|```:index```             | AttributeNameList                           | include atoms that need indexed | sets which attributes with be indexed     |
|```:snmp```              | SnmpStruct                                  | nil (?)                         | sets availability of table to SNMP        |
|```:local_content```     | boolean                                     | false                           | sets uniqueness of local table vs network |
|```:attributes```        | not(List of Atoms)                          | [:id]                           | 


Note on ```:type``` : currently 'ordered_set' is not supported for 'disc_only_copies' tables. A table of type set or ordered_set has either zero or one record per key. Whereas a table of type bag can have an arbitrary number of records per key. The key for each record is always the first attribute of the record.

Note on NodeList: NodeList is a list of nodes matching ```:"name@machine"``` format.

Note on SNMP:  SnmpStruct is described in the SNMP User Guide. Basically, if this attribute is present in ArgList of mnesia:create_table/2, the table is immediately accessible by means of the Simple Network Management Protocol (SNMP). ![wiki](http://en.wikipedia.org/wiki/Simple_Network_Management_Protocol)

Note on ```:local_content```: When an application needs a table whose contents should be locally unique on each node, ```:local_content``` tables may be used. The name of the table is known to all Mnesia nodes, but its contents is unique for each node. Access to this type of table must be done locally.

Note on ```:attributes```: there must exists at least one atom in this list.