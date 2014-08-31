module HelpScoutDocs
  class Article < HelpScoutDocs::Method

    # List all articles
    def list(id, type=:category, options={})
      public_send(:"list_by_#{type}", id, options)
    end

    # List all articles
    #
    def list_by_category(category_id, options={})
      get_request("categories/#{category_id}/articles", options)
    end

    # List all articles
    #
    def list_by_collection(collection_id, options={})
      get_request("collections/#{collection_id}/articles", options)
    end

    # Get an article
    #
    def get(id, options={})
      get_request("articles/#{id}", options)
    end

    # Get a related articles
    #
    def related(id, options={})
      get_request("articles/#{id}/related", options)
    end

    # Get a article's revisions
    #
    def revisions(id, options={})
      get_request("articles/#{id}/revisions", options)
    end

    # Get a article's revision
    #
    def get_revision(id, options={})
      get_request("revisions/#{id}", options)
    end
  end
end
