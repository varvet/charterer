class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :omniauthable, omniauth_providers: [:instagram]

  has_many :images

  acts_as_tagger

  def self.from_omniauth(auth)
    user = where(auth.slice(:provider, :uid)).first_or_initialize
    user.update({
      password: Devise.friendly_token[0,20],
      bio: auth.info.bio,
      image: auth.info.image,
      name: auth.info.name,
      nickname: auth.info.nickname,
      website: auth.info.website,
      token: auth.credentials.token
    })

    user
  end

  def untagged_images
    images.includes(:taggings).where('taggings.id' => nil)
  end

  def tagged_images
    images.joins(:taggings)
  end

  def first_image
    untagged_images.order(created_time: :desc).first
  end

  def last_image
    tagged_images.order(created_time: :asc).first
  end

  def get_more_images(ip, last_image=Image.new)
    f = Feed.new(self, ip)
    image_list = f.get_last_20(last_image)[:data]

    image_list.each do |image|
      Image.find_or_create_by(remote_id: image[:id]) do |i|
        i.filter        = image[:filter]
        i.thumbnail     = image[:images][:thumbnail][:url]
        i.url           = image[:images][:standard_resolution][:url]
        i.user          = self
        i.created_time  = DateTime.strptime(image[:created_time], '%s')
        if image[:caption].present?
          i.caption       = image[:caption][:text]
        end
      end
    end

    first_image
  end

  def tags
    Tag.default_tags + Tag.joins(:taggings).where("taggings.tagger_id" => User.last)
  end

  def tag_statistics
    Tag.all.collect do |tag|
      [tag.name, Tag.joins(:taggings).where("taggings.tagger_id" => self.id, id: tag.id).count]
    end
  end
end
