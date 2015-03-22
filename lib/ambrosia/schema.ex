defmodule Ambrosia.Schema do

  @wait_timeout 20_000

  @doc """
  Creates a new Mnesia schema.
  This can be thought of as installing a database (kind of).
  It creates the files on whatever node is specified (local if create/0)
  Ambrosia.create/0 uses Node.self().
  Ambrosia.create/1 uses an atom name for schema creation on a remote node
  """
  def create(nodes) when nodes |> is_list do
    created = :mnesia.create_schema nodes
    case created do
      :ok -> 
        IO.puts "Schema successfully for #{inspect nodes}."
      {:error, { _, {:already_exists, x}}} ->
        IO.puts "Schema for #{x} already exists."
      x -> 
        IO.puts "Error creating schema: #{inspect x}"
    end
  end
  def create(node) when node |> is_atom, do: create [node]
  def create, do: create Node.self()

  @doc """
  Table creation is async and could fail. We must wait after creation.
  """
  def wait_for_tables(table_list) do
    IO.puts ("waiting for tables to be created...")
    waited = :mnesia.wait_for_tables(table_list, @wait_timeout)
    IO.puts "waited: #{inspect waited}"
    waited
  end

  @doc """
  Deletes a schema (files) from the local (delete/0) node, single node
  (delete/1(atom)), or multiple nodes(delete/1(list)).
  This will delete all data on the given nodes.
  This requires all db_nodes to be stopped.
  """
  def delete(nodes) when nodes |> is_list, do: :mnesia.delete_schema(nodes)
  def delete(node) when node |> is_atom, do: delete [node]
  def delete, do: delete Node.self()

  def print(table), do: :mnesia.schema(table)
  def print, do: :mnesia.schema


end