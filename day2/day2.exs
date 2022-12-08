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

  defp shouldChoose(opponentPlayed, outcome) do
    case {opponentPlayed, outcome} do
      {:rock, :win} -> :paper
      {:rock, :lose} -> :scissors
      {:scissors, :lose} -> :paper
      {:scissors, :win} -> :rock
      {:paper, :win} -> :scissors
      {:paper, :lose} -> :rock
      {x, :draw} -> x
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

  defp translateMove(letter) do
    case letter do
      "A" -> :rock
      "B" -> :paper
      "C" -> :scissors
    end
  end

  defp translateStrategy(letter) do
    case letter do
      "Y" -> :draw
      "X" -> :lose
      "Z" -> :win
    end
  end

  defp calc(lines) do
    lines
    |> Enum.map(fn line ->
      [opponent, strategy] = String.split(line, " ", trim: true)
      opponentPlayed = translateMove(opponent)
      myChoice = shouldChoose(opponentPlayed, translateStrategy(strategy))

      score(play(myChoice, opponentPlayed), myChoice)
    end)
    |> Enum.sum()
  end
end

result = Day2.run()

IO.puts(inspect(result))
