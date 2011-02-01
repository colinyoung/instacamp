class Search
  include Mongoid::Document
  field :search_value, :type => String
  field :response_url, :type => String
  field :found, :type => Boolean
end
