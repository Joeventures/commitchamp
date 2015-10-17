require "httparty"
require "pry"

require "commitchamp/version"
require "commitchamp/githubstuff"

# Probably you also want to add a class for talking to github.

module Commitchamp
  class App
    #include HTTParty
    #base_uri "https://api.github.com"
    def initialize
    end

    def run
      sort_another = nil
      until sort_another == 'N' do
        session = GitHubStuff.new(get_auth_token)
        session.get_repo_info
        contributions = session.get_repo_contributions
        author_info = compile_repo_contributions(contributions)
        sort_repo_contributions(author_info)
        binding.pry
        puts "Would you like to get another list of contributions?"
        puts "Enter \"N\" if no, or any other key for yes."
        sort_another = gets.chomp.upcase
      end

    end

    private

    def sort_repo_contributions(author_info)
      puts "Hacking successful! How would you like to sort the thing?"
      puts "(A)dditions, (D)eletions, (C)hanges, or (T)otal commits?"
      sort_by = gets.chomp.downcase.to_sym
      author_info.sort_by{ |a| a[sort_by]}
      binding.pry
    end

    def compile_repo_contributions(contributions)
      author_info = []
      contributions.each do |c|
        author = c['author']['login']
        a_sum = c['weeks'].inject(0) { |sum,hash| sum + hash["a"]}
        d_sum = c['weeks'].inject(0) { |sum,hash| sum + hash["d"]}
        c_sum = c['weeks'].inject(0) { |sum,hash| sum + hash["c"]}
        sum_sum = a_sum + d_sum + c_sum
        author_info.push({author: author, a: a_sum, d: d_sum, c: c_sum, t: sum_sum})
      end
      author_info
    end

    def get_auth_token
      # prompt for and return the auth token
      puts "Please enter your auth token: "
      auth_token = gets.chomp
    end

  end
end

app = Commitchamp::App.new
app.run
