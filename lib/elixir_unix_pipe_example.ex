defmodule Unix do
  @processes """
  PID TTY           TIME CMD
  494 ttys000    0:00.42 -/usr/local/bin/fish
 4369 ttys000    0:00.62 npm
 4374 ttys000    0:00.00 sh -c gulp clean && gulp watch
 4381 ttys000    1:57.02 gulp
 9728 ttys001    0:00.79 -/usr/local/bin/fish
  """

  @doc """
    Returns operating system processes
  """
  def ps do
    @processes
  end

  @doc ~S"""
  Filter input by match

  ## Examples
    iex> Unix.grep("foo\nbar", ~r/foo/)
    ["foo"]
  """
  def grep(input, match) do
    String.split(input, "\n")
    |> Enum.filter(&by_line(&1, match))
  end

  @doc ~S"""
  Filter input by column

  ## Examples
    iex> Unix.awk(["foo bar"], 1)
    ["bar"]
  """
  def awk(input, column) do
    Enum.map(input, fn (line) ->
      Regex.split(~r/ /, line)
      |> Enum.at(column)
    end)
  end

  defp by_line(line, match) do
    Regex.match?(match, line)
  end
end
