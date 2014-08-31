module HelpScoutDocs
  class Site < HelpScoutDocs::Method
    # List sites
    #
    def list(options={})
      get_request("sites", options)
    end

    # Get a site
    #
    def get(id, options={})
      get_request("sites/#{id}", options)
    end
  end
end
