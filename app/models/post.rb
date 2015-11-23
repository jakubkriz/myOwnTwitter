class Post < ActiveRecord::Base
  validates :author,  :presence => true
  validates :title, :presence => true,
                    :length => { :minimum => 5 }

  has_many :taggings
  has_many :tags, through: :taggings
  validates_presence_of :tags


  def all_tags=(names)
    self.tags = names.split(",").map do |name|
        Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end
end
