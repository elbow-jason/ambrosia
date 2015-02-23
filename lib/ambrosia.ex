defmodule Ambrosia do
 

  def start do
    started = :mnesia.start()
    case started do
      :ok -> IO.puts "Ambrosia started..."
      x -> IO.puts "Ambrosia failed to start: #{inspect x}"
    end
    started
  end

  def init(_tables) do
    Ambrosia.Schema.create
    # Ambrosia.Schema.wait_for_tables(tables)
    start()
  end

end

Ambrosia.init([])
