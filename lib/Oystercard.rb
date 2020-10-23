class Oystercard
attr_reader :history
attr_accessor :balance
CARD_LIMIT = 90
  def initialize(journey = Journey.new)
    @balance = 0
    @history = []
    @journey = journey
  end
  def top_up(amount)
    raise("#{CARD_LIMIT} limit reached!") if @balance + amount > CARD_LIMIT
    @balance += amount
  end
  def touch_in(entry_station)
    @journey.touch_in(entry_station, self)
  end
  def in_journey?
    @journey.in_journey?
  end
  def touch_out(exit_station)
    @journey.touch_out(exit_station)
  end
  private
  def deduct(withdraw)
    @balance -= withdraw
  end
end
