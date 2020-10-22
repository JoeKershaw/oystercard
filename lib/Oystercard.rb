class Oystercard
attr_reader :balance, :in_transit, :entry_station
CARD_LIMIT = 90
MINIMUM_FARE = 1
  def initialize
    @balance = 0
    @in_transit = false
  end
  def top_up(amount)
    raise("#{CARD_LIMIT} limit reached!") if @balance + amount > CARD_LIMIT
    @balance += amount
  end
  def touch_in(entry_station)
    raise("Insufficient funds, minimum £1") if @balance < MINIMUM_FARE
    @entry_station = entry_station
    @in_transit = true
  end
  def in_journey?
    @in_transit
  end
  def touch_out
    @in_transit = false
    @balance -= MINIMUM_FARE
  end
  private
  def deduct(withdraw)
    @balance -= withdraw
  end
end
