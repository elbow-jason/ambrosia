defmodule Ambrosia.Schema do

  @doc """
  Creates a new Mnesia schema.
  This can be thought of as installing a database (kind of). It creates the files on whateve
  Ambrosia.create/0 uses Node.self().
  Ambrosia.create/1 uses an atom name for schema creation on a remote node
  """
  def create(nodes) when nodes |> is_list, do: :mnesia.create_schema nodes
  def create(node) when node |> is_atom, do: create [node]
  def create, do: create Node.self()

  @doc """
  Deletes a schema (files) from the local (delete/0) node, single node
  (delete/1(atom)), or multiple nodes(delete/1(list)).
  This will delete all data on the given nodes.
  This requires all db_nodes to be stopped.
  """
  def delete(nodes) when nodes |> is_list, do: :mnesia.delete_schema(nodes)
  def delete(node) when node |> is_atom, do: delete [node]
  def delete, do: delete Node.self()


end