class Tag < ActiveRecord::Base
 # has_and_belongs_to_many :posts a to stejne pro post.rb has_and_belongs_to_many :tags
 # a vytvorit join table - najit na netu

  has_and_belongs_to_many :posts

  validates :name, uniqueness: true

  # def to_param  # overridden
  #   name
  # end

  # def self.from_param(name)
  #   find_by_name!(name)
  # end

  # def self.counts
  #   self.select("name, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id, tags.name")
  # end
end
