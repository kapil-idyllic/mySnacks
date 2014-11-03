class Order < ActiveRecord::Base
  belongs_to :snack
  belongs_to :user
  strip_attributes
end
