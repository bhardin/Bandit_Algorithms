# A simple arm. Will return a reward of either 1 or 0.
class BernoulliArm
	attr_reader :probability

	@probability = nil

	# Initialize a BernoulliArm with a probablity
	# @param probability [Float] The probability the arm should return a reward
	def initialize(probability)
		@probability = probability
	end

	# Return a reward
	def draw
		if rand > @probability
			return 0.0 
		else
			return 1.0
		end
	end
end