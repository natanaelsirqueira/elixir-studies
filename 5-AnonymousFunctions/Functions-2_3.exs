# the classic FizzBuzz exercise
result = fn
  (0, 0, _) -> "FizzBuzz"
  (0, _, _) -> "Fizz"
  (_, 0, _) -> "Buzz"
  (_, _, x) -> x
end

test = fn(n) -> result.(rem(n,3), rem(n,5), n) end

list = Enum.map(10..16, & IO.inspect(test.(&1)))

IO.inspect list
