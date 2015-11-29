class Post < ActiveRecord::Base
  validates :author, presence: true
  validates :title, presence: true
  validates :body, presence: true

  has_and_belongs_to_many :tags
  validates :tags, presence: true

  #ve _form -> <%= f.unput :tags_string %> -> <input name="post[tags_string]" id="post_tags_string" value="to co vrati metoda tags_string"
  def tags_string
    self.tags.map(&:name).join(",")
  end

  def tags_string=(names)
    self.tags = names.split(/\s?,\s?|\s/).map do |name| # (/\s?,\s?|\s/)
        Tag.where(name: name.strip).first_or_create!
    end
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end
end
