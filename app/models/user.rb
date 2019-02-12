class User < ApplicationRecord
  belongs_to :role
  belongs_to :account
  has_many :sales
  has_many :purchases

  has_secure_password

  validates :name, :email, :role_id, presence: true
  #validates :email, uniqueness: true, scope: :account_id
  validates_uniqueness_of :email, scope: :account_id

  has_attached_file :avatar, styles: { medium: "300x300#"}
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  default_scope { where(account_id: Account.current_id) }

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def self.deleted
    where(deleted: true)
  end

  def self.notDeleted
    where(deleted: false)
  end
end
