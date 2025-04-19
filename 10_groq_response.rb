# https://console.groq.com/playground?model=llama-3.3-70b-versatile

=begin
PROMPT:
Find two numbers between 1 and 9 such that their difference is 2 and their product is 15, using the brute force method and the algebraic method.  Write Ruby code that will solve it using both these methods.  Parallelize the Brute Force Method Using Ractors ensuring that it uses the correct mechanism for waiting for all ractors to finish.  Use benchmark ruby library to determine which of the three methods is faster: the sequential brute force method, the parallelized brute force method and the algebraic method.
=end

require 'benchmark'

# Brute Force Method with Parallelization
def find_numbers_brute_force_parallel(target_product, target_difference, min_value, max_value)
  solutions = []
  ractors = []

  (min_value..max_value).each do |x|
    ractor = Ractor.new(x, target_product, target_difference, min_value, max_value) do |x, target_product, target_difference, min_value, max_value|
      (min_value..max_value).each do |y|
        # Check if y is greater than x and the difference is correct
        if y > x && y - x == target_difference
          # Check if the product is correct
          if x * y == target_product
            Ractor.yield([y, x])
          end
        end
      end
      Ractor.yield nil
    end
    ractors << ractor
  end

  # Wait for all ractors to finish and collect the results
  ractors.each do |ractor|
    result = ractor.take
    solutions << result unless result.nil?
  end

  # Return the first solution found
  if solutions.empty?
    nil
  else
    solutions[0]
  end
end

# Algebraic Method
def find_numbers_algebraic(target_product, target_difference, min_value, max_value)
  # Define the coefficients of the quadratic equation
  a = 1
  b = target_difference
  c = -target_product

  # Calculate the discriminant
  discriminant = b**2 - 4*a*c

  # Check if the discriminant is negative
  if discriminant < 0
    return nil
  end

  # Calculate the two roots of the quadratic equation
  root1 = (-b + Math.sqrt(discriminant)) / (2*a)
  root2 = (-b - Math.sqrt(discriminant)) / (2*a)

  # Calculate the corresponding values of y
  y1 = root1 + target_difference
  y2 = root2 + target_difference

  # Check if both solutions are between min_value and max_value
  if min_value <= root1 && root1 <= max_value && min_value <= y1 && y1 <= max_value
    return [y1.round, root1.round]
  elsif min_value <= root2 && root2 <= max_value && min_value <= y2 && y2 <= max_value
    return [y2.round, root2.round]
  else
    return nil
  end
end

# Example usage
target_product = 15
target_difference = 2
min_value = 1
max_value = 9

puts "Parallel Brute Force Solution: #{find_numbers_brute_force_parallel(target_product, target_difference, min_value, max_value).inspect}"
puts "Algebraic Solution: #{find_numbers_algebraic(target_product, target_difference, min_value, max_value).inspect}"

# Benchmarking
puts "Benchmarking..."
Benchmark.bm do |x|
  x.report("Parallel Brute Force") { find_numbers_brute_force_parallel(target_product, target_difference, min_value, max_value) }
  x.report("Algebraic") { find_numbers_algebraic(target_product, target_difference, min_value, max_value) }
end
