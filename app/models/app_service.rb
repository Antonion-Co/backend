class AppService < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1, maximum: 50 }
  has_many :services
end
