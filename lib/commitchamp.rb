require "httparty"
require "pry"

require "commitchamp/version"
# Probably you also want to add a class for talking to github.

module Commitchamp
  class App
    include HTTParty
    base_uri "https://api.github.com"
    def initialize
    end

    def run
      until sort_another == 'N' do
        get_auth_token
        @repo_name = get_repo_name
        @contributions = get_repo_contributions
        @contributions = sort_repo_contributions
        show_sorted_repo_contributions
        puts "Would you like to get another list of contributions?"
        puts "Enter \"N\" if no, or any other key for yes."
        sort_another = gets.chomp.upcase
      end

    end

    private

    def get_auth_token
      # prompt for the auth token and set @auth
      puts "Please enter your auth token: "
      auth_token = gets.chomp
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

app = Commitchamp::App.new
app.run
