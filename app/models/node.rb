class Node < ApplicationRecord
  belongs_to :trend
  has_many :node_links
  has_many :links, through: :node_links
end
