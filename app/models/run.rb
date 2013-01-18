class Run < ActiveRecord::Base
  belongs_to :contestant
  belongs_to :heat

  scope :complete, -> { joins(:heat).where(heats: {status: 'complete'}) }
  scope :upcoming, -> { joins(:heat).where(heats: {status: 'upcoming'}) }

  validates :contestant_id, presence: true
  validates :heat_id,       presence: true
  validates :lane,          presence: true

  def set_time(time)
    update_attributes! time: time
  end

  # Round times to 3 decimal places
  def time
    self[:time].try :round, 3
  end

  def postpone
    update_attributes contestant: Contestant.next_suitable(lane: lane, exclude: heat.contestants)
    if contestant
      return contestant
    else
      destroy
      return nil
    end
  end
end
