require './bandit_algorithm'

class Softmax < BanditAlgorithm
  def select_arm
    arm_probabilities = @values.each_with_index { | v,i | 
      value = v / @counts[i].to_f
    }

    return categorical_draw(arm_probabilities)
  end

  def categorical_draw(probabilities)
    z = rand
    cum_total = 0.0

    probabilities.each_with_index do | p, i |
      cum_total += p
      if cum_total > z
        return i
      end
    end

    rand(probabilities.length)
  end

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
end