class Image < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :skills, :interests

  validates :remote_id, presence: true, uniqueness: true
  validates :url, presence: true

  belongs_to :user

  def default_tags
    ["Barn", "Fest", "Konsert", "Selfie", "Ben", "Blommor", "Mat", "Solnedgång", "Soluppgång", "Övrigt"].collect{|t| Tag.new(name: t)}
  end
end
