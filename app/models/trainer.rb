class Trainer < ActiveRecord::Base

    validates_presence_of :email, :trainer_name, :password_confirmation
    validates_uniqueness_of :email, :trainer_name
    has_secure_password
    validates :password, length: { in: 5..20 }, on: :create
    validates :password_confirmation, presence: true, on: :create
    has_many :pokemon
end


