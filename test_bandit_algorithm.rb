require './bernoulli_arm'
require './epsilon_greedy'
require './softmax'
require './ucb'

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

			chosen_arm = algo.select_arm()
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

means = [0.1, 0.11, 0.12, 0.13, 0.14, 0.15, 0.18]
# means.shuffle!

arms = means.collect { |x|
	BernoulliArm.new(x)
} 

# Testing EpsilonGreedy
# eg = EpsilonGreedy.new(0.2, arms.length)
# test_algorithm(eg, arms, 1, 200).inspect
# eg.print_data

# Testing softmax
# sm = Softmax.new(0.1, arms.length)
# test_algorithm(sm, arms, 1, 1000).inspect
# sm.print_data
# sm.ordered_arms

# Testing UCB
ucb = Ucb.new(0.1, arms.length)
test_algorithm(ucb, arms, 1, 500).inspect
ucb.print_data
ucb.ordered_arms

arms.each_with_index do | arm, i |
	puts "arm_#{i}: #{arm.probability}"
end


