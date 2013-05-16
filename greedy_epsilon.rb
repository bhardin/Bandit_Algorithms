class BernoulliArm
	@probability = nil

	def initialize(probability)
		@probability = probability
	end

	def draw
		if rand > @probability
			return 0.0 
		else
			return 1.0
		end
	end
end

class EpsilonGreedy
	@epsilon = @counts = @values = nil

	def initialize(epsilon, counts, values)
		@epsilon = epsilon
		@counts = counts
		@values = values
	end	

	def update(chosen_arm, reward)
 #    @counts[chosen_arm] = chosen_arm
 #    n = @counts[chosen_arm]

 #    value = values[chosen_arm]
 #    new_value = ((n - 1) / float(n)) * value + (1 / float(n)) * reward
 #    values[chosen_arm] = new_value
  end

  def select_arm
 #    if rand > @epsilon
 #      return @values.find_index(@values.max)
 #    else
 #      return rand(@values.length)
  end

end

means = [0.9, 0.1, 0.1, 0.1]
means.shuffle!

arms = means.collect { |x|
BernoulliArm.new(x)
} 

# This is the bandit_algorithm that will be tested.
algo = Proc.new {
	eg = EpsilonGreedy.new(0.1, Array.new, Array.new)

	public
	def update(chosen_arm, reward)
		#eg.update(chosen_arm, reward)
	end

	def select_arm
		return 1
		# eg.select_arm
	end
}

# Testing framework for testing bandit algorithms
# 
# @param algo [Proc] - Block of code you want to test
# @param arms [Array] - Arms we want to simulate draws from
# @param number_of_simulations [Fixnum] - self explanatory.
# @param horizon [Fixnum] - The number of times each algorithm is allowed to pull on arms during each simulation.
# @return [Array, Array, Array, Array, Array] sim_nums, times, chosen_arms, rewards, cumulative_rewards
def test_algorithm(algo, arms, number_of_simulations, horizon)
	# array of arrays

	chosen_arms = []
	rewards = []
	cumulative_rewards = []
	sim_nums = []
	times = []
	
	(number_of_simulations * horizon).times do | i |
		chosen_arms << 0.0
		rewards << 0.0
		cumulative_rewards << 0.0
		sim_nums << 0.0
		times << 0.0
	end

	number_of_simulations.times do | sim |
		# Initialize the algorithm

		horizon.times do | t |
			index = (sim) * horizon + t

			sim_nums[index] = sim
			times[index] = t

			chosen_arm = algo.call.select_arm()
			chosen_arms[index] = chosen_arm

			reward = arms[chosen_arms[index]].draw
			rewards[index] = reward

			if t == 0
				cumulative_rewards[index] = reward
			else
				cumulative_rewards[index] = reward + cumulative_rewards[index - 1]
			end

			algo.update(chosen_arm, reward)
		end
	end

	return [sim_nums, times, chosen_arms, rewards, cumulative_rewards]
end

puts test_algorithm(algo, arms, 10, 200).inspect