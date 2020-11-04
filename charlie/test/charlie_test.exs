defmodule CharlieTest do
  use ExUnit.Case
  doctest Charlie

  test "greets the world" do
    assert Charlie.hello() == :world
  end
end
