class HomeController < ApplicationController

  def index
    # TODO: get real data for this
    Struct.new("SocialFeedItem", :avatar, :author_handle, :author_name, :author_url, :url, :content, :time, :icon_class)
    @social_feed = []
    @social_feed.push Struct::SocialFeedItem.new(
      "/images/blank_avatar.png",
      "Joe Bruin",
      "Joe Bruin",
      "#",
      "#",
      "NeXt is still the best!",
      "5 minutes ago",
      "facebook"
    )
    @social_feed.push Struct::SocialFeedItem.new(
      "/images/blank_avatar.png",
      "@joebruin",
      "Joe Bruin",
      "#",
      "#",
      "NeXt is the best!",
      "yesterday",
      "twitter"
    )

    return welcome
    # TODO: differentiate between welcome and dashboard once we have a dashboard design
    # return current_user ? dashboard : welcome
  end

  private

  def dashboard
    render 'dashboard'
  end

  def welcome
    render 'welcome'
  end

end
