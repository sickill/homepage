module Nanoc3::Helpers::Blogging
  def articles
    (@items || items).select { |item| item[:kind] == 'article' && !item[:draft] }
  end
end

include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::LinkTo

# Returns the item with the given identifier.
def item(identifier)
  @items.find { |item| item.identifier == identifier }
end

def download_link(label, filename=nil)
  %Q("#{label}":http://counter.sickill.net?f=http://drop.sickill.net/blog/#{filename || label})
end
