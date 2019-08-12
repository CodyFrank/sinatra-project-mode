class Trainer < ActiveRecord::Base
    validates_presence_of :email, :trainer_name, :password
    validates_uniqueness_of :email, :trainer_name
    has_secure_password
    has_many :pokemon
end