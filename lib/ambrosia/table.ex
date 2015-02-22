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
  def copy(table, destination), do: copy(table, Node.self(), destination)

  def copy_to_remote(table, destination, typed \\ :ram_copies) do
    :mnesia.add_table_copy(table, destination, typed)
  end


end
