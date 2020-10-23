require 'journey'

describe Journey do
let (:entry_station) {double :entry_station}
let (:exit_station) {double :exit_station}
describe '#in_journey?' do
  it 'returns true when in transit' do
    card = Oystercard.new
    card.top_up(Journey::MINIMUM_FARE)
    subject.touch_in(entry_station, card)
    expect(subject.in_journey?).to eq true
  end
  it 'returns false when not in transit' do
    expect(subject.in_journey?).to eq false
  end
end
describe '#touch_in' do
  it 'when you touch in you are in transit' do
    card = Oystercard.new
    card.top_up(Journey::MINIMUM_FARE)
    subject.touch_in(entry_station, card)
    expect(subject.in_journey?).to eq true
  end
  it 'throw error for insufficient funds' do
    card = Oystercard.new
    expect{ subject.touch_in(entry_station, card) }.to raise_error("Insufficient funds, minimum £1")
  end
  it 'remember entry station when touching in' do
    card = Oystercard.new
    card.top_up(Journey::MINIMUM_FARE)
    subject.touch_in(entry_station, card)
    expect(subject.entry_station).to eq entry_station
  end
end
describe '#touch_out' do
  it 'not in transit' do
    card = Oystercard.new
    card.top_up(Journey::MINIMUM_FARE)
    subject.touch_in(entry_station, card)
    subject.touch_out(exit_station)
    expect(subject.in_journey?).to eq false
  end
  it 'sets entry_station to nil' do
    card = Oystercard.new
    card.top_up(Journey::MINIMUM_FARE)
    subject.touch_in(entry_station, card)
    subject.touch_out(exit_station)
    expect(subject.entry_station).to eq nil
  end
end
it 'a charge is made when touching out' do
  card = Oystercard.new
  card.top_up(Journey::MINIMUM_FARE)
  subject.touch_in(entry_station, card)
  expect{ subject.touch_out(exit_station) }.to change{card.balance}.by(-Journey::MINIMUM_FARE)
end
it 'touching in and out is 1 journey' do
  card = Oystercard.new
  card.top_up(Journey::MINIMUM_FARE)
  subject.touch_in(entry_station, card)
  subject.touch_out(exit_station)
  expect(subject.journey.length).to eq 1
end
end
