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
      puts "Leave blank to get all repositories from an owner."
      @repo_name = gets.chomp
      puts "And who is the unfortunate owner of this repo?"
      @repo_owner = gets.chomp
    end

    def get_repo_contributions
      if @repo_name.strip.empty?
        @repo_name = []
        get_repo = GitHubStuff.get("/users/#{@repo_owner}/repos", :headers => @auth)
        get_repo.each do |r|
          @repo_name.push(r[:name])
        end
      end

      # return a hash of all the repo contributions
      GitHubStuff.get( "/repos/#{@repo_owner}/#{@repo_name}/stats/contributors",
        :headers => @auth)
    end

  end
end