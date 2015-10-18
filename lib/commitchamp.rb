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
      session = GitHubStuff.new(get_auth_token)
      session.get_repo_info
      session.get_owner_repos if session.repo_name[0].empty?
      session.repo_name.each do |repo| contributions = session.get_repo_contributions(repo)
        author_info = compile_repo_contributions(contributions)
        author_info = sort_repo_contributions(author_info, repo)
        puts_repo_contributions(author_info, repo)
      end
      puts "That's enough hacking for one day. Get some cough medicine and rest."
    end

    private

    def puts_repo_contributions(author_info, repo_name)
      puts "\n" * 5
      puts "Reporting for Repo: #{repo_name}"
      puts "Username             Additions  Deletions    Changes"
      author_info.each do |author|
        printf("%-20s %9d  %9d  %9d \n", author[:author], author[:a], author[:d], author[:c])
      end
    end

    def sort_repo_contributions(author_info, repo_name)
      puts "\n" * 5
      puts "Hacking of #{repo_name} successful! How would you like to sort the thing?"
      puts "(A)dditions, (D)eletions, (C)hanges, or (T)otal commits?"
      sort_by = gets.chomp.downcase.to_sym
      author_info.sort_by{ |a| a[sort_by]}
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
