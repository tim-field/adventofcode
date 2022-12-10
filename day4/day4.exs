defmodule Day4 do
  def part1(fileName) do
    fileName
    |> readFile()
    |> countContaining()
  end

  def part2(fileName) do
    fileName
    |> readFile()
    |> countOverlaps()
  end

  defp readFile(fileName) do
    case File.read(fileName) do
      {:ok, body} -> body
      {:error, reason} -> raise(reason)
    end
  end

  defp toRange(stringRange) do
    [x, y] = String.split(stringRange, "-")
    Range.new(String.to_integer(x), String.to_integer(y))
  end

  defp ranges(fileContents) do
    fileContents
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(",", trim: true)
      |> Enum.map(fn r -> toRange(r) end)
    end)
  end

  defp contains(r1, r2) do
    [small, big] =
      if(Range.size(r1) > Range.size(r2)) do
        [r2, r1]
      else
        [r1, r2]
      end

    MapSet.subset?(MapSet.new(small), MapSet.new(big))
  end

  defp countContaining(fileContents) do
    fileContents
    |> ranges()
    |> Enum.reduce(0, fn set, acc ->
      [r1, r2] = set

      if(contains(r1, r2)) do
        acc + 1
      else
        acc
      end
    end)
  end

  defp countOverlaps(fileContents) do
    fileContents
    |> ranges()
    |> Enum.reduce(0, fn set, acc ->
      [r1, r2] = set

      if(Range.disjoint?(r1, r2)) do
        acc
      else
        acc + 1
      end
    end)
  end
end

IO.puts(inspect(Day4.part1("input.txt")))
IO.puts(inspect(Day4.part2("input.txt")))
