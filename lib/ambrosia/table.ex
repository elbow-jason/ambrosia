defmodule Ambrosia.Table do

  @doc """
  Permanently deletes all replias of a table with a given name.
  """
  def delete(table), do: :mnesia.delete_table(table)

  @doc """
  Removes all data in a table of a given name.
  """
  def clear(table), do: :mnesia.clear_table(table)

  @doc """
  Copies a table from one node(origin) to a specified node(destination).
  """
  def copy(table, origin, destination) do
    :mnesia.move_table_copy(table, origin, destination)
  end

  @doc """
  Copies table to local node from remote node (origin).
  """
  def copy_to_local(table, origin), do: copy(table, origin,  Node.self)

  @doc """
  Copies table from local node to remote node (destination).
  """
  def copy_to_remote(table, destination) do
    copy(table, Node.self, destination)
  end

  @doc """
  Adds a copy of a table to a new node. A node that is passed the ```schema```
  table will become part of this Mnesia system.
  """
  def init_copy(table, destination, storage_type \\ :ram_copies) do
    :mnesia.add_table_copy(table, destination, storage_type)
  end

  def delete_copy(table, node) do
    :mnesia.del_table_copy(table, node)
  end

  @doc """
  As it's only arg takes a record. A record by definition has its 
  name (an atom) as it's first element and args (a keyword list) 
  as it's second element.

  See examples in 3.4 http://www.erlang.org/doc/apps/mnesia/Mnesia_chap3.html
  """
  def create({name, args}), do: create(name, args)

  defp create(name, args) do
    created = :mnesia.create_table(name, args)
    case created do
      {:atomic, :ok} ->
        IO.puts("Table '#{inspect name}' created successfully.")
      {:aborted, reason} ->
        IO.puts("Table '#{inspect name}' aborted: #{inspect reason}")
    end
  end
end
