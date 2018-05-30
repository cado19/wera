class Contact < MailForm::Base
	attribute :name,      :validate => true
	attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
	attribute :message
	
	#validates :name, presence: true
	#validates :email, presence: true
	#validates :message, presence: true

	def headers
	  {
	    :subject => "Contact You",
	    :to => "cyberhaventech@gmail.com",
	    :from => %("#{name}" <#{email}>)
	  }
	end
end
