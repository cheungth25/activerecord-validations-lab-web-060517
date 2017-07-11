class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w(Fiction Non-Fiction), message: "%{value} is not a valid category"}
  validate :click_bait?


  def click_bait?
    click_bait = [/Won't Believe/i, /Secret/i, /Top [0-9]*/i, /Guess/i]
    click_bait_check = click_bait.map { |test| title =~ test}
    errors.add(:title, "looks like clickbait") if !(click_bait_check.compact.size > 0)
  end
end
