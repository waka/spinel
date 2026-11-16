# An attribute assignment answers its right-hand side, whatever the writer
# does with it. A define_method writer whose later default assigns the
# value's parameter (`b = (a = 4)`) has the call site write that value back
# into the parameter's temp; the parameter keeps a temp of its own, apart
# from the one the assignment answers.
def id(n) = n

class D
  attr_reader :got

  define_method(:n=) { |a, b = (a = 4)| @got = [a, b] }
  define_method(:s=) { |a, b = (a = "four")| @got = [a, b] }
  define_method(:o=) { |a, b = (a = [4])| @got = [a, b] }
end

class E < D
  define_method(:n=) { |a, b = (a = 5)| @got = [:e, a, b] }
end

d = D.new
p(d.n = id(1))
p d.got
p [d.s = id("one")]
p d.got
v = (d.o = id([1]))
p v, d.got
p((d.n = id(2)) + 10)
[D.new, E.new].each do |q|
  w = (q.n = id(3))
  p w, q.got
end
