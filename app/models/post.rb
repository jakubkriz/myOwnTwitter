class Post < ActiveRecord::Base
  validates_presence_of  :author #, :presence => true
  validates_presence_of  :title  #, :presence => true
  validates_presence_of  :body   #, :presence => true

  has_many :taggings
  has_many :tags, through: :taggings

  validates_presence_of :tags


  def all_tags=(names)
    self.tags = names.split(/\s?,\s?|\s/).map do |name| # (/\s?,\s?|\s/)
        Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(",")
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end
end
