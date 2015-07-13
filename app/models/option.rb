class Option < ActiveRecord::Base
  belongs_to :poll
  has_many :answers, dependent: :destroy
  
  validates :name, presence: true, uniqueness: { scope: :poll_id }
end
