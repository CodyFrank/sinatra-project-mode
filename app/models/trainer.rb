class Trainer < ActiveRecord::Base

    validates_presence_of :email, :trainer_name
    validates_uniqueness_of :email, :trainer_name
    has_secure_password
    validates :password, length: { minimum: 5 }, confirmation: true, 
      unless: Proc.new { |t| t.password.blank? }
    has_many :pokemon
end


