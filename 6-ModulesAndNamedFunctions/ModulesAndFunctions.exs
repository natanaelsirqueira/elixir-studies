defmodule Math do
  def double(n), do: n * 2
  def triple(n), do: n * 3
  def quadruple(n), do: n * double(n)

  # calculates the sum of the integers from 1 to n
  def sum(0), do: 0
  def sum(n), do: n + sum(n - 1)

  # returns the base to the exponent power
  def pow(b, e \\ 2)
  def pow(_, 0), do: 1
  def pow(b, e), do: b * pow(b, e - 1)

  # finds the greatest common divisor between two nonnegative integers
  def gcd(x, 0), do: x
  def gcd(x, y) when (x > 0) and (y > 0), do: gcd(y, rem(x, y))
  def gcd(_x, _y), do: raise(ArgumentError, message: "The numbers should be nonnegatives")
end

defmodule Factorial do
  def of(0), do: 1
  def of(n) when n > 0, do: n * of(n - 1)
  def of(_), do: raise(ArgumentError, message: "The number should be positive")
end

defmodule Fibonacci do
  def of(0), do: 0
  def of(1), do: 1
  def of(2), do: 1
  def of(n) when n > 0, do: of(n - 1) + of(n - 2)
  def of(n), do: Math.pow(-1, -n + 1) * Fibonacci.of(-n)
end

# IO.inspect Enum.map(-8..8, & Fibonacci.of(&1))
