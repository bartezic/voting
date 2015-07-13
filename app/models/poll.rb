class Poll < ActiveRecord::Base
  belongs_to :user
  has_many :options, dependent: :destroy
  has_many :answers, through: :options

  validates :question, presence: true
  #validates :options, presence: true

  accepts_nested_attributes_for :options, reject_if: :all_blank, allow_destroy: true

  scope :opened, -> {where(public: true)}

  before_create :generate_uniq_token

  def answers_by(user, ip)
    Answer.where(
      <<-SQL
        option_id IN (SELECT id FROM options WHERE poll_id = #{self.id})
        AND (ip = inet '#{ip}' #{"OR user_id = #{user.id}" if user})
      SQL
    )
  end

  private

    def generate_uniq_token
      return if self.token.present?
      digest = loop do
        temp = SecureRandom.urlsafe_base64(nil, false).first(6)
        break temp unless self.class.exists?(token: temp)
      end
      self.token = digest
    end
end