class Journey
MINIMUM_FARE = 1
attr_reader :journey, :entry_station, :exit_station
  def touch_in(entry_station, card)
    @card = card
    raise("Insufficient funds, minimum £1") if @card.balance < MINIMUM_FARE
    @entry_station = entry_station
    @journey = {}
  end
  def in_journey?
    !!@entry_station
  end
  def touch_out(exit_station)
    @exit_station = exit_station
    @journey[@entry_station] = @exit_station
    @card.history << @journey
    @entry_station = nil
    @card.balance -= MINIMUM_FARE
  end
end
