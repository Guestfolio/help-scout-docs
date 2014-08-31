module HelpScoutDocs
  class Category < HelpScoutDocs::Method
    # List categories
    #
    def list(collection_id, options={})
      get_request("collections/#{collection_id}/categories", options)
    end
    alias :by_collection :list

    # Get a category
    #
    def get(id, options={})
      get_request("categories/#{id}", options)
    end
  end
end
