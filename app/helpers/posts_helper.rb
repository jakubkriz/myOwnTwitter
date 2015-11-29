module PostsHelper
  def tag_links(tags)
    tags.split(",").map{|tag| link_to tag.strip, filter_posts_path(tag.strip), class: 'filter-by-tag'  }.join(", ")
  end
end
