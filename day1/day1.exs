defmodule Day1 do
  def run() do
    case File.read("input.txt") do
      {:ok, body} -> read(String.split(body, "\n"))
      {:error, reason} -> reason
    end
  end

  defp read(lines) do
    # a better shape
    # https://elixir-lang.org/getting-started/keywords-and-maps.html#nested-data-structures
    lines
    |> Enum.reduce(%{1 => 0}, fn line, acc ->
      idx = map_size(acc)

      if line == "" do
        Map.put(acc, idx + 1, 0)
      else
        Map.put(acc, idx, Map.get(acc, idx) + String.to_integer(line))
      end
    end)
  end
end

result = Day1.run()

IO.puts(inspect(result))

IO.puts(result[1])

numbers = [5794, 5879, 4899, 6777, 5845, 1303, 6761, 1814, 6605, 4715, 2264, 2789]

# Use the sum function to sum the numbers
IO.puts(Enum.sum(numbers))
