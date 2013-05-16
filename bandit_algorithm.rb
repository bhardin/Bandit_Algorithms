# An Templated class. Other BanditAlgorithms should inherit this.
class BanditAlgorithm
	@epsilon = @counts = @values = nil

	# @param epsilon [Float] Percentage of the time algorithm should explore
	# @param number_of_arms [Fixnum] The number of different iterations
	def initialize(epsilon, number_of_arms)
		@epsilon = epsilon
		@counts = @values = Array.new(number_of_arms, 0.0)
	end	

	# Prints data about the arms
	def print_data
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
end