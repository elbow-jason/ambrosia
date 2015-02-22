defmodule Ambrosia do

  def init do
    schema = Ambrosia.Schema.create
    started = :mnesia.start()
    case schema do
      :ok -> IO.puts "Schema successfully for #{Node.self()}."
      {:error, { _, {:already_exists, x}}} -> IO.puts "Schema for #{x} already exists."
      x -> IO.puts "Error creating schema: #{inspect x}"
    end
    case started do
      :ok -> IO.puts "Ambrosia started..."
      x -> IO.puts "Ambrosia failed to start: #{inspect x}"
    end
  end

end

Ambrosia.init
