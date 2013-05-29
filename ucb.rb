require './bandit_algorithm'

class Ucb < BanditAlgorithm
  include Math

  def select_arm
    arm_count = @counts.length - 1
    
    # Return arms that have never been pulled
    (0..arm_count).each do | arm |
      if @counts[arm] == 0
        return arm
      end
    end

    @ucb_values = Array.new(@counts.length, 0.0)

    (0..arm_count).each do | arm |
      bonus = sqrt(2 * Math.log(@total_count, 10) / @counts[arm].to_f)
      @ucb_values[arm] = @values[arm] + bonus
    end    

    return @ucb_values.index(@ucb_values.max)
  end

  def update(chosen_arm, reward)
    @total_count += 1
    @counts[chosen_arm] += 1
    n = @counts[chosen_arm]

    value = @values[chosen_arm]
    new_value = ((n - 1) / n.to_f) * value + (1 / n.to_f) * reward
    @values[chosen_arm] = new_value
  end
end

