defmodule Day3 do
  def run(fileName) do
    case File.read(fileName) do
      {:ok, body} -> calc(String.split(body, "\n", trim: true))
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

  defp calc(lines) do
    lines
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
end

IO.puts(Day3.run("input.txt"))
