defmodule Day5 do
  def part1(fileName) do
    fileName
    |> readFile()
    |> parseTable()
  end

  def parseTable(fileStream) do
    fileStream
    |> Enum.take(8)
    |> Enum.reverse()
    |> Enum.map(fn line ->
      line
      |> String.codepoints()
      |> Enum.drop(1)
      |> Enum.take_every(4)
    end)
    |> Enum.reduce([], fn line, acc ->
      line
      |> Enum.with_index(fn value, index ->
        List.insert_at(acc, index, Enum.at(acc, index, []) ++ [value])
      end)
    end)
  end

  def readFile(fileName) do
    fileName
    |> File.stream!([:trim_bom])
  end
end

IO.puts(inspect(Day5.part1("input.txt")))
