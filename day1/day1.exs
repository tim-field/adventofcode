defmodule Day1 do
  def run() do
    case File.read("input.txt") do
      {:ok, body} -> sort(body)
      {:error, reason} -> reason
    end
  end

  defp sort(fileContents) do
    groups = String.split(fileContents, "\n\n")

    groups
    |> Enum.map(fn group ->
      group
      |> String.split("\n", trim: true)
      |> Enum.map(fn line -> String.to_integer(line) end)
      |> Enum.sum()
    end)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
  end
end

result = Day1.run()

IO.puts(inspect(result))

IO.puts(Enum.sum(result))
