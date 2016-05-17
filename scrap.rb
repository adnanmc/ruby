require "rubygems"
require "nokogiri"
require "mechanize"
require "csv"

# This script is for gathering publicly available information about people who
# joined both Hacker Hours and Beginner Programmers meetup group on meetup.com


agent = Mechanize.new

hackerHours = [] # all the member id who joined hackerhours group

beginnerProgrammer = [] #all the member id who joined beginner programmer group

CSV.open("scrap.csv", "wb") do |csv| # saving information in csv file
  csv << ['Common_Member_ID']




  # getting all the member id from the Hacker Hours group

  # finding last page offset value for loop

  basePage = agent.get('http://www.meetup.com/hackerhours/member/')
  offsetMax = basePage.search('.nav-next')[0].attributes['href'].text

  offsetMax = offsetMax.split('http://www.meetup.com/hackerhours/members/?offset=')
  offsetMax = offsetMax[1].split('&sort=last_visited&desc=1')
  offsetMax = offsetMax[0]
  offsetMax = offsetMax.to_i


  # offset value on first page is 0 therefore
  offset = 0

  puts "Getting member id from Hacker Hours group......"

  while offset <= offsetMax

      offset = offset.to_s

      page = agent.get('http://www.meetup.com/hackerhours/members/?offset=' + offset)
      count = page.search('.memName').count
      offset = offset.to_i

      for j in 0...count
        name1 = page.search('.memName')[j].text
        # puts page.search('.memName')[j].attributes['href'].text
        memberId = page.search('.memName')[j].attributes['href'].text
        memberId = memberId.split("http://www.meetup.com/hackerhours/members/")
        memberId = memberId[1].split('/')
        memberId = memberId.to_s
        hackerHours << memberId
      end

      offset += 20
  end
  #
  puts "done"
  puts ".............."
  #
  # # getting all member id from beginer programmers group
  #
  puts "Getting member id from Beginner Programmers group......"
  
  # finding last page offset value for loop

  basePage = agent.get('http://www.meetup.com/BeginnerProgrammers/member/')
  offsetMax = basePage.search('.nav-next')[0].attributes['href'].text

  offsetMax = offsetMax.split('http://www.meetup.com/BeginnerProgrammers/members/?offset=')
  offsetMax = offsetMax[1].split('&sort=last_visited&desc=1')
  offsetMax = offsetMax[0]
  offsetMax = offsetMax.to_i
  
  while offset <= offsetMax
    offset = offset.to_s
    page = agent.get('http://www.meetup.com/BeginnerProgrammers/members/?offset=' + offset)
    count = page.search('.memName').count
    offset = offset.to_i
    
      for k in 0...count
  
        memberId = page.search('.memName')[k].attributes['href'].text
        memberId = memberId.split('http://www.meetup.com/BeginnerProgrammers/members/')
        memberId = memberId[1].split('/')
        memberId = memberId.to_s
        beginnerProgrammer << memberId
      end
    offset += 20
  
  end
  puts "done"
  puts hackerHours.count 
  puts
  puts beginnerProgrammer.count
  
  common = hackerHours & beginnerProgrammer
  
  puts common.count
  csv << common
  

end
