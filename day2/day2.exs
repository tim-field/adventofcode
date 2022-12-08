defmodule Day2 do
  def run() do
    case File.read("input.txt") do
      {:ok, body} -> calc(String.split(body, "\n", trim: true))
      {:error, reason} -> reason
    end
  end

  defp play(me, opponent) do
    case {me, opponent} do
      {:rock, :scissors} -> :win
      {:rock, :paper} -> :lose
      {:scissors, :paper} -> :win
      {:scissors, :rock} -> :lose
      {:paper, :rock} -> :win
      {:paper, :scissors} -> :lose
      {x, y} when x == y -> :draw
    end
  end

  defp score(result, choice) do
    game =
      case result do
        :win -> 6
        :draw -> 3
        :lose -> 0
      end

    hand =
      case choice do
        :rock -> 1
        :paper -> 2
        :scissors -> 3
      end

    game + hand
  end

  defp translate(letter) do
    case letter do
      "X" -> :rock
      "A" -> :rock
      "Y" -> :paper
      "B" -> :paper
      "Z" -> :scissors
      "C" -> :scissors
    end
  end

  defp calc(lines) do
    lines
    |> Enum.map(fn line ->
      IO.puts(line)
      [opponent, me] = String.split(line, " ", trim: true)
      score(play(translate(me), translate(opponent)), translate(me))
    end)
    |> Enum.sum()
  end
end

result = Day2.run()

IO.puts(inspect(result))
