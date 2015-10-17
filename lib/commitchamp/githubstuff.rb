module Commitchamp
  class GitHubStuff

    include HTTParty
    base_uri "https://api.github.com"

    def initialize(auth_token)
      @auth = {
          "Authorization" => "token #{auth_token}",
          "User-Agent"    => "HTTParty"
      }
    end

    def get_repo_info
      # prompt for and return repo name
      puts "What is the name of the repository you would like to \"hack\"?"
      @repo_name = gets.chomp
      puts "And who is the unfortunate owner of this repo?"
      @repo_owner = gets.chomp
    end

    def get_repo_contributions
      # return a hash of all the repo contributions
      GitHubStuff.get( "/repos/#{@repo_owner}/#{@repo_name}/stats/contributors",
        :headers => @auth)
    end

  end
end