class Link < ApplicationRecord
  has_many :node_links
  has_many :nodes, through: :node_links
end
