require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  doc = Nokogiri::HTML(html)

  project = {}
  
  doc.css("li.project.grid_4").each do |pro|
    
    title = pro.css('h2.bbcard_name strong a').text
    project[title.to_sym] = {
      :image_link => pro.css("div.project-thumbnail a img").attribute("src").value,
      :description => pro.css("p.bbcard_blurb").text,
      :location => pro.css("span.location-name").text,
      :percent_funded => pro.css("li.first strong").text.to_i
    }
  end
  project
end

create_project_hash