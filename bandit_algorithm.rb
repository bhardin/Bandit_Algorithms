# An Templated class. Other BanditAlgorithms should inherit this.
class BanditAlgorithm
	@epsilon = @counts = @values = nil

	# @param epsilon [Float] Percentage of the time algorithm should explore
	# @param number_of_arms [Fixnum] The number of different iterations
	def initialize(epsilon, number_of_arms)
		@epsilon = epsilon
		@values = Array.new(number_of_arms, 0.0)
		@counts = Array.new(number_of_arms, 0)
	end	

	# Prints data about the arms
	def print_data
		puts "----------------------------------------"
		puts " General Data"
		puts "----------------------------------------"
		@values.each_with_index do | value, i |
			puts "arm_#{i}: #{value}"
		end
		puts "----------------------------------------"
	end

	# @param chosen_arm [Fixnum] The number of the selected arm
	# @param reward [Float] The reward that was returned
	def update(chosen_arm, reward)
		raise NotImplemented
	end

	# Based on the current data, return the arm to pull
	def select_arm
		raise NotImplemented
  end

  # Based on the current data, return an array that is ordered 
  # from the best_arm to the worst arm to pull
  def ordered_arms
  	@ordered_arms = @values.sort.reverse
  	puts "----------------------------------------"
  	puts " Ordered Arms"
  	puts "----------------------------------------"
		@ordered_arms.each do | value |
			puts "arm_#{@values.index(value)}: #{value}"
		end
		puts "----------------------------------------"
  end
end