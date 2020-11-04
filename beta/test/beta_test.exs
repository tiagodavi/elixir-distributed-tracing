defmodule BetaTest do
  use ExUnit.Case
  doctest Beta

  test "greets the world" do
    assert Beta.hello() == :world
  end
end
