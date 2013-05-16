require './bandit_algorithm'

# An Implementation of the EpsilonGreedy Algroithm
class EpsilonGreedy < BanditAlgorithm
	# @param chosen_arm [Fixnum] The number of the selected arm
	# @param reward [Float] The reward that was returned
	def update(chosen_arm, reward)
    # Update the number of times the arm has been pulled
    @counts[chosen_arm] += 1
    n = @counts[chosen_arm]

    # Update the value of the arm that has been pulled
    value = @values[chosen_arm]
    new_value = ((n - 1) / n.to_f) * value + (1 / n.to_f) * reward
    @values[chosen_arm] = new_value
  end

  # @return [Fixnum] The number of the selected arm
  def select_arm
    if rand > @epsilon
      return @values.find_index(@values.max)
    else
      return rand(@values.length)
    end
  end
end