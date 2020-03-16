class DepositCalculator
  attr_reader :amount, :rate, :months, :start_date, :inflation_rate

  def initialize(amount, rate, start_date, type, value, inflation_rate = nil)
    @amount = amount
    @rate = rate
    @months = convert_to_months(type, value)
    @start_date = start_date
    @inflation_rate = inflation_rate
  end

  def monthly
    (0..months).map do |month_number|
      date = start_date.next_month(month_number)
      days = days_in_month(date)

      { date: date.next_month, days: days, interest: interest(days) }
    end
  end

  def total_interest
    interest(count_all_days)
  end

  def amount_with_interest
    amount + total_interest
  end

  def total_inflation
    amount_inflation + interest_inflation
  end

  def amount_inflation
    inflation(amount)
  end

  def interest_inflation
    inflation(total_interest)
  end

  private

    def count_all_days
      (start_date.next_month(months) - start_date).to_i
    end

    def days_in_month(date)
      Date.new(date.year, date.month, -1).day
    end

    def convert_to_months(type, value)
      type == 'years' ? value * 12 : value
    end

    def interest(days)
      ((amount * rate / 100) * days * (1 / 365.0)).round(2)
    end

    def inflation(value)
      (value / (1 + 1 * inflation_rate / 100)).round(2)
    end
end
