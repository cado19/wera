class Supplier < ApplicationRecord
	#ASSOCIATIONS
	has_many :products

	#VALIDATIONS
	validates :name, presence: true

	#SCOPES
	default_scope { where(account_id: Account.current_id) }

	def self.deleted
		where(deleted: true)
	end

	def self.notDeleted
		where(deleted: false)
	end
end
