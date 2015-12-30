# self-explanatory
class Post < ActiveRecord::Base
  # validates :author, presence: true
  # validates :title, presence: true
  # validates :body, presence: true

  has_and_belongs_to_many :tags

  validate :author?
  validate :title?
  validate :body?

  validate :tags?

  def author?
    errors.add(:author, 'Author can\'t be blank') if author.blank?
  end

  def title?
    errors.add(:title, 'Title can\'t be blank') if title.blank?
  end

  def body?
    errors.add(:body, 'Body can\'t be blank') if body.blank?
  end

  def tags?
    errors.add(:tags_string,
               'Tags string must have at least one tag') if tags.blank?
  end

  def tags_string
    tags.map(&:name).join(', ')
  end

  def tags_string=(names)
    self.tags = names.split(/\s?,\s?|\s/).map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end
end
