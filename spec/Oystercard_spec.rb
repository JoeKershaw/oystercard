require 'Oystercard'

describe Oystercard do
  it '#initialize: starting balance is 0' do
    expect(subject.balance).to eq 0
  end
  describe '#top_up' do
    it 'balance increases by amount given' do
      initial_balance = subject.balance
      expect(subject.top_up(50)).to eq initial_balance + 50
    end
    it 'raises an error if balance exceeds £90' do
      expect{ subject.top_up(91) }.to raise_error("#{Oystercard::CARD_LIMIT} limit reached!")
    end
  end
  describe '#deduct' do
    it 'balance decreases by amount withdrawn' do
      initial_balance = subject.balance
      expect(subject.deduct(50)).to eq initial_balance - 50
    end
  end
  describe '#in_journey?' do
    it 'returns true when in transit' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in
      expect(subject.in_journey?).to eq true
    end
    it 'returns false when not in transit' do
      expect(subject.in_journey?).to eq false
    end
  end
  describe '#touch_in' do
    it 'when you touch in you are in transit' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in
      expect(subject.in_transit).to eq true
    end
    it 'throw error for insufficient funds' do
      expect{ subject.touch_in }.to raise_error("Insufficient funds, minimum £1")
    end
  end
  it '#touch_out' do
    subject.top_up(Oystercard::MINIMUM_FARE)
    subject.touch_in
    subject.touch_out
    expect(subject.in_transit).to eq false
  end
end

# Assume that the minimum fare is £1 and raise an exception unless the balance is at least £1 on touch in.
