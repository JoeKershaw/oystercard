require 'Oystercard'

describe Oystercard do
  let (:entry_station) {double :entry_station}
  let (:exit_station) {double :exit_station}
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
  # describe '#deduct' do
  #   it 'balance decreases by amount withdrawn' do
  #     initial_balance = subject.balance
  #     expect(subject.deduct(50)).to eq initial_balance - 50
  #   end
  # end
  describe '#in_journey?' do
    it 'returns true when in transit' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq true
    end
    it 'returns false when not in transit' do
      expect(subject.in_journey?).to eq false
    end
  end
  describe '#touch_in' do
    it 'when you touch in you are in transit' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq true
    end
    it 'throw error for insufficient funds' do
      expect{ subject.touch_in(entry_station) }.to raise_error("Insufficient funds, minimum £1")
    end
    it 'remember entry station when touching in' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end
  end
  describe '#touch_out' do
    it 'not in transit' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.in_journey?).to eq false
    end
    it 'sets entry_station to nil' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.entry_station).to eq nil
    end
  end
  it 'a charge is made when touching out' do
    subject.top_up(Oystercard::MINIMUM_FARE)
    subject.touch_in(entry_station)
    expect{ subject.touch_out(exit_station) }.to change{subject.balance}.by(-Oystercard::MINIMUM_FARE)
  end
  it 'touching in and out is 1 journey' do
    subject.top_up(Oystercard::MINIMUM_FARE)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journey.length).to eq 1

  end
end
