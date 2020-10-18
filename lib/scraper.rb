require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
      html = open(index_url)
      response = Nokogiri::HTML(html)
      
      profiles = response.css('.student-card')

      profiles.map do |profile|
        {
          :name => "#{profile.css(".student-name").text}",
          :location => "#{profile.css(".student-location").text}",
          :profile_url => "#{profile.css('a').attr('href')}"
        }
      end
      #  binding.pry
      
  end


#   {
#   :twitter=>"http://twitter.com/flatironschool",
#   :linkedin=>"https://www.linkedin.com/in/flatironschool",
#   :github=>"https://github.com/learn-co",
#   :blog=>"http://flatironschool.com",
#   :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
#   :bio=> "I'm a school"
# } 
  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    response = Nokogiri::HTML(html)
    blog = "#{response.css('a[href^="http:"]').attr('href')}"
    twitter = "#{response.css('a[href*="twitter"]').attr('href')}"
    hash = {
      :linkedin => "#{response.css('a[href*="linkedin"]').attr('href')}",
      :github => "#{response.css('a[href*="github"]').attr('href')}",
      :profile_quote => "#{response.css('.profile-quote').text}",
      :bio => "#{response.css('.description-holder p').text}"
    }
    hash[:blog] = blog if !blog.empty?
    hash[:twitter] = twitter  if !twitter.empty?
    
    hash
    
  end

end

