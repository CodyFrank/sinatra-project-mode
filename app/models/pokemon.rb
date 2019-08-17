class Pokemon < ActiveRecord::Base
    validates_presence_of :name, :nickname, :element
    belongs_to :trainer
end