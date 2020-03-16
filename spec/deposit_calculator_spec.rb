require File.expand_path '../spec_helper.rb', __FILE__

describe 'Deposit Calculator' do
  let(:amount) { 500 }
  let(:rate) { 10 }
  let(:start_date) { Date.parse("2020-03-15") }
  let(:term_length) { 3 }
  let(:term_type) { "months" }
  let(:inflation_rate) { 7.0 }

  subject { DepositCalculator.new(amount, rate, start_date, term_type, term_length, inflation_rate) }

  context 'deposit_calculator' do
    it '#monthly' do
      expect(subject.monthly.first[:date]).to eq(start_date.next_month)
      expect(subject.monthly.first[:days]).to eq(31)
      expect(subject.monthly.first[:interest]).to eq(4.25)
    end

    it '#total_interest' do
      expect(subject.total_interest).to eq(12.6)
    end

    it '#amount_with_interest' do
      expect(subject.amount_with_interest).to eq(512.6)
    end

    it '#total_inflation' do
      expect(subject.total_inflation).to eq(479.07)
    end

    it '#amount_inflation' do
      expect(subject.amount_inflation).to eq(467.29)
    end

    it '#interest_inflation' do
      expect(subject.interest_inflation).to eq(11.78)
    end

    context 'private' do
      it '#count_all_days' do
        expect(subject.send(:count_all_days)).to eq(92)
      end

      it '#days_in_month' do
        expect(subject.send(:days_in_month, start_date)).to eq(31)
      end

      it '#convert_to_months month type' do
        expect(subject.send(:convert_to_months, term_type, term_length)).to eq(3)
      end

      it '#convert_to_months years type' do
        expect(subject.send(:convert_to_months, "years", term_length)).to eq(36)
      end
    end
  end
end
