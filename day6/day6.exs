defmodule Day6 do
  def part1(fileName) do
    run(fileName, 4)
  end

  def part2(fileName) do
    run(fileName, 14)
  end

  defp run(fileName, uniqueCount) do
    readFile(fileName)
    |> String.codepoints()
    |> detect(uniqueCount, [], 0)
  end

  defp detect(msg, uniqueCount, seen, idx) do
    if length(seen) > uniqueCount - 1 and
         seen |> Enum.slice(-uniqueCount..-1) |> isUnique() do
      idx
    else
      [head | tail] = msg
      detect(tail, uniqueCount, seen ++ [head], idx + 1)
    end
  end

  defp isUnique(list) do
    list |> Enum.uniq() |> length() === list |> length()
  end

  def readFile(fileName) do
    fileName
    |> File.read!()
  end
end

IO.puts(inspect(Day6.part1("input.txt")))
IO.puts(inspect(Day6.part2("input.txt")))
