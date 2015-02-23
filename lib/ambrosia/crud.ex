defmodule Ambrosia.Crud do

  def do_write(record), do: :mnesia.write(record)
  def do_delete(record), do: :mnesia.delete_object(record)
  def do_read(table, key), do: :mnesia.read({table, key})
  def do_wread(table, key), do: :mnesia.wread({table, key})
  def do_delete_many(table, key), do: :mnesia.delete({table, key})


  def transact(fun), do: :mnesia.transaction(fun)

  def write(record) do
    transact(fn -> do_write(record) end)
  end

  def read(table, key) do
    transact(fn -> do_read(table, key) end)
  end

  def delete_record(record) do
    transact(fn -> do_delete(record) end)
  end

  def delete_many(table, key) do
    transact(fn -> do_delete_many(table, key) end)
  end

  defp alter_records(record_list, fun) do
    alter_records(record_list, fun, [])
  end
  defp alter_records([ record | rest ], fun, acc) do
    alter_records(rest, [fun.(record) | acc])
  end 
  defp alter_records([], _fun, acc), do: acc

  def read_then_write(table, key, fun) do
    fun = fn ->
      records = do_wread(table, key)
      case records |> is_list do
        true ->
          alter_records(records, fun)
        false ->
          records
      end
    end
    transact(fun)
  end

end