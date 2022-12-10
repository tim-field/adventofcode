defmodule Day3 do
  def run(fileName) do
    case File.read(fileName) do
      {:ok, body} -> part2(body)
      {:error, reason} -> reason
    end
  end

  defp priority(letter) do
    cond do
      # a-z is charcode [97-122] so sub 97 to get 1 for "a" [1-26]
      String.match?(letter, ~r/[a-z]/) -> (String.to_charlist(letter) |> hd) - 96
      # A-Z is charcode [65-90] so sub 64 to get 1 for 'A" ( then add 26 to offset the above ) [27-52]
      String.match?(letter, ~r/[A-Z]/) -> (String.to_charlist(letter) |> hd) - 64 + 26
    end
  end

  defp part1(fileContents) do
    String.split(fileContents, "\n", trim: true)
    |> Enum.map(fn line ->
      splitAt = round(String.length(line) / 2)

      # convert to a list then split in the middle
      {c1, c2} =
        String.codepoints(line)
        |> Enum.split(splitAt)

      c1
      |> Enum.find(fn l -> c2 |> Enum.member?(l) end)
      |> priority()
    end)
    |> Enum.sum()
  end

  defp part2(fileContents) do
    String.split(fileContents, "\n", trim: true)
    |> Enum.map(fn line -> String.codepoints(line) end)
    |> Enum.chunk_every(3)
    |> Enum.flat_map(fn sack ->
      sack
      |> Enum.reduce(nil, fn contents, acc ->
        if acc == nil do
          MapSet.new(contents)
        else
          MapSet.intersection(MapSet.new(contents), acc)
        end
      end)
    end)
    |> Enum.map(fn letter -> priority(letter) end)
    |> Enum.sum()
  end
end

IO.puts(inspect(Day3.run("input.txt")))
# IO.puts(length(Day3.run("input.txt")))
