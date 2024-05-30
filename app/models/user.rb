class User < ApplicationRecord
  enum role: { user: 0, admin: 1 }
  attribute :role, :integer, default: 0
  
  has_secure_password

  has_many :questions, dependent: :destroy

  validates :email, presence: true, uniqueness: true
   
  has_one :profile, dependent: :destroy

  before_save :downcase_nickname

  def downcase_nickname
    nickname.downcase!
  end

end
