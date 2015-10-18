module Commitchamp
  class GitHubStuff

    include HTTParty
    base_uri "https://api.github.com"
    attr_reader :repo_name, :repo_owner

    def initialize(auth_token)
      @auth = {
          "Authorization" => "token #{auth_token}",
          "User-Agent"    => "HTTParty"
      }
    end

    def get_repo_info
      # prompt for owner and repo
      puts "What is the name of the repository you would like to \"hack\"?"
      puts "Leave blank to hack all repositories from an owner."
      @repo_name = [gets.chomp]
      puts "And who is the unfortunate owner you'd like to hack?"
      @repo_owner = gets.chomp
    end

    def get_owner_repos
      @repo_name = []
      get_repo = GitHubStuff.get("/users/#{@repo_owner}/repos", :headers => @auth)
      get_repo.each do |r|
        @repo_name.push(r["name"])
      end
    end

    def get_repo_contributions(repo)
      # return a hash of all the repo contributions
      GitHubStuff.get( "/repos/#{@repo_owner}/#{repo}/stats/contributors",
                       :headers => @auth)
    end

  end
end