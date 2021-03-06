# self-explanatory
class Tag < ActiveRecord::Base
  has_and_belongs_to_many :posts

  validates :name, presence: true, uniqueness: true

  def to_param
    name
  end
end
