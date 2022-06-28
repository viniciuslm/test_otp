defmodule TestOtpTest do
  use ExUnit.Case
  doctest TestOtp

  test "greets the world" do
    assert TestOtp.hello() == :world
  end
end
