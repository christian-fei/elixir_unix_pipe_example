defmodule UnixTest do
  use ExUnit.Case
  doctest Unix

  @processes """
  PID TTY           TIME CMD
  494 ttys000    0:00.42 -/usr/local/bin/fish
 4369 ttys000    0:00.62 npm
 4374 ttys000    0:00.00 sh -c gulp clean && gulp watch
 4381 ttys000    1:57.02 gulp
 9728 ttys001    0:00.79 -/usr/local/bin/fish
  """

  test "#ps returns operating system processes" do
    assert Unix.ps() == @processes
  end

  test "#grep filters lines by match" do
    match = ~r/ba/
    assert Unix.grep("foo\nbar\nbaz", match) == ["bar","baz"]
  end

  test "#awk get specified column" do
    output = ["bar"]
    assert Unix.awk(["foo bar"], 1) == output
  end
end
