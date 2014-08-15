class Tag < ActsAsTaggableOn::Tag
  def self.default_tags
    Tag.all
  end
end