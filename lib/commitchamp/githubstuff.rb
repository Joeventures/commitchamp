module Commitchamp
  class GitHubStuff

    def initialize(auth_token)
      @auth = {
          "Authorization" => "token #{auth_token}",
          "User-Agent"    => "HTTParty"
      }
    end

    def get_repo_name
      # prompt for and return repo name
    end

    def get_repo_contributions
      # return a hash of all the repo contributions
    end

    def sort_repo_contributions
      # prompt for what to sort by
      # sort the repo contributions
      # return a hash of the contributions, properly sorted
    end

    def show_sorted_repo_contributions
      # puts the sorted list of contributions
    end
  end
end