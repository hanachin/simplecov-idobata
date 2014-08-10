class SimpleCov::Formatter::IdobataFormatter
  class Badge
    def initialize(result)
      @result = result
    end

    def to_s
      Idobadge.send(badge_method, message)
    end

    private

    def message
      "%d / %d LOC (%.1f%%) covered." %  [@result.covered_lines, @result.total_lines, @result.covered_percent]
    end

    def goal_reached?
      @result.covered_percent >= (SimpleCov::Formatter::IdobataFormatter.goal || 90)
    end

    def warning?
      @result.covered_percent >= (SimpleCov::Formatter::IdobataFormatter.warning || 80)
    end

    def badge_method
      case
      when goal_reached?
        :success
      when warning?
        :warning
      else
        :failure
      end
    end
  end
end
