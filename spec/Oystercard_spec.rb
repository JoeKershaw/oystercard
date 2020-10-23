require 'Oystercard'

describe Oystercard do
    it '#initialize: starting balance is 0' do
      expect(subject.balance).to eq 0
    end
    it 'do we have a History array' do
      expect( subject.history ).to be_an_instance_of Array
    end
    it 'empty list of journeys by default' do
      expect( subject.history ).to eq []
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
end
