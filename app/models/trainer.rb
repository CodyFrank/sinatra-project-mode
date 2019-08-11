class Trainer < ActiveRecord::Base
    validates_presence_of :email, :tranier_name, :password
    has_secure_password
    has_many :pokemon
end