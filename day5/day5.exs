defmodule Day5 do
  def part1(fileName) do
    run(fileName)
  end

  def part2(fileName) do
    run(fileName, "9001")
  end

  defp run(fileName, model \\ "9000") do
    table =
      readFile(fileName)
      |> parseTable()

    readFile(fileName)
    |> parseInstructions()
    |> Enum.reduce(table, fn instruction, table ->
      performInstruction(instruction, table, model)
    end)
    |> Enum.map(&hd/1)
    |> Enum.join("")
  end

  def parseTable(fileStream) do
    fileStream
    # first 8 lines
    |> Enum.take(8)
    |> Enum.map(fn line ->
      line
      # convert to a list
      |> String.codepoints()
      # drop initial [
      |> Enum.drop(1)
      # take every forth char
      |> Enum.take_every(4)
    end)
    # convert lines to stacks
    |> Enum.zip()
    # remove empty strings
    |> Enum.map(fn stack ->
      stack
      |> Tuple.to_list()
      |> Enum.filter(fn value -> value != " " end)
    end)
  end

  def parseInstructions(fileStream) do
    fileStream
    |> Enum.drop(10)
    |> Enum.map(fn line ->
      # parse digits from instructions, sub 1 for 0 based offset
      Regex.scan(~r/\d+/, line)
      |> List.flatten()
      |> Enum.map(fn value -> String.to_integer(value) - 1 end)
    end)
  end

  def performInstruction(instruction, table, model) do
    [move, from, to] = instruction

    lift = fn values ->
      if model == "9000" do
        values |> Enum.reverse()
      else
        values
      end
    end

    moveValues = Enum.at(table, from) |> Enum.slice(Range.new(0, move)) |> lift.()

    table
    |> List.replace_at(to, moveValues ++ Enum.at(table, to))
    |> List.replace_at(from, Enum.at(table, from) |> Enum.drop(move + 1))
  end

  def readFile(fileName) do
    fileName
    |> File.stream!()
  end
end

IO.puts(inspect(Day5.part1("input.txt")))
IO.puts(inspect(Day5.part2("input.txt")))
