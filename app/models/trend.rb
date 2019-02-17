class Trend < ApplicationRecord
  has_many :nodes, dependent: :destroy
end
