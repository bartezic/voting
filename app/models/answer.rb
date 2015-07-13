class Answer < ActiveRecord::Base
  belongs_to :option
  belongs_to :user

  validates :option_id, presence: true
  validates :ip, presence: true, uniqueness: { scope: :option_id }
end
