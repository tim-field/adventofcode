defmodule Day1 do
  def run() do
    case File.read("input.txt") do
      {:ok, body} -> sort(String.split(body, "\n"))
      {:error, reason} -> reason
    end
  end

  defp sort(lines) do
    lines
    |> Enum.reduce([0], fn line, list ->
      idx = length(list) - 1

      if line == "" do
        # start a new list entry
        list ++ [0]
      else
        # update the count for the entry at this idx
        List.replace_at(list, idx, Enum.at(list, idx) + String.to_integer(line))
      end
    end)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
  end
end

result = Day1.run()

IO.puts(inspect(result))

IO.puts(Enum.sum(result))
