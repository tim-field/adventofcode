defmodule Day6 do
  def part1(fileName) do
    run(fileName)
  end

  defp run(fileName) do
    readFile(fileName)
    |> String.codepoints()
    |> detect([], 0)
  end

  defp detect(msg, seen, idx) do
    if length(seen) > 3 and isUnique(seen |> Enum.slice(-4..-1)) do
      idx
    else
      [head | tail] = msg
      detect(tail, seen ++ [head], idx + 1)
    end
  end

  defp isUnique(list) do
    IO.puts(list)
    list |> Enum.uniq() |> length() === list |> length()
  end

  def readFile(fileName) do
    fileName
    |> File.read!()
  end
end

IO.puts(inspect(Day6.part1("input.txt")))
