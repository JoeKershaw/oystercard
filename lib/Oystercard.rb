class Oystercard
attr_reader :balance, :in_transit, :entry_station, :exit_station, :journey, :history
CARD_LIMIT = 90
MINIMUM_FARE = 1
  def initialize
    @balance = 0
    @history = []
  end
  def top_up(amount)
    raise("#{CARD_LIMIT} limit reached!") if @balance + amount > CARD_LIMIT
    @balance += amount
  end
  def touch_in(entry_station)
    raise("Insufficient funds, minimum £1") if @balance < MINIMUM_FARE
    @entry_station = entry_station
    @journey = {}
  end
  def in_journey?
    !!@entry_station
  end
  def touch_out(exit_station)
    @exit_station = exit_station
    @journey[@entry_station] = @exit_station
    # @History << @journey
    @entry_station = nil
    @balance -= MINIMUM_FARE
  end
  private
  def deduct(withdraw)
    @balance -= withdraw
  end
end
