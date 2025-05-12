class User < ApplicationRecord
    attr_accessor :remember_token

    validates :username, 
            presence: true, 
            uniqueness: true, 
            length: { minimum: 7, maximum: 30 }

    validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

    validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

    has_many :comments, dependent: :destroy	# if a user is deleted, also delete their microposts
	has_many :documents, dependent: :destroy	# if a user is deleted, also delete their likes
	before_save { self.email = email.downcase }
	validates :username, presence: true, length: { maximum: 50 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 250 },
				format: {with: VALID_EMAIL_REGEX },
				#uniqueness: true
				uniqueness: {case_sensitive: false}

	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }



	def details
		"Joined on #{self.created_at.strftime("%m/%d/%Y at %H:%M")}"
	end

	# Returns the hash digest of the given string.
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
													BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end
	
	# Returns a random token.
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	# Remembers a user in the database for use in persistent sessions.
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# Returns true if the given token matches the digest.
	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	# Forgets a user.
	def forget
		update_attribute(:remember_digest, nil)
	end

end


