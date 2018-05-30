class User < ApplicationRecord
  belongs_to :role
  belongs_to :account
  has_many :sales

  has_secure_password

  validates :name, :email, :role_id, presence: true
  #validates :email, uniqueness: true, scope: :account_id
  validates_uniqueness_of :email, scope: :account_id

  has_attached_file :avatar, styles: { medium: "300x300#"}
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  default_scope { where(account_id: Account.current_id) }

  def generate_token
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_pasword_reset
    generate_token(password_reset_token)
    UserMailer.password_reset(self).deliver
    self.password_reset_sent_at = Time.zone.now
    save!
  end
end
