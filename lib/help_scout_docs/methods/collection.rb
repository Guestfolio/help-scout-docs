module HelpScoutDocs
  class Collection < HelpScoutDocs::Method
    # List collections
    #
    def list(options={})
      get_request("collections", options)
    end

    # Get a collection
    #
    def get(id, options={})
      get_request("collections/#{id}", options)
    end
  end
end
