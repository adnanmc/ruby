require "rubygems"
require "nokogiri"
require "mechanize"
require "csv"

# This script is for gathering publicly available information about people who
# joined both Hacker Hours and Beginner Programmers meetup group on meetup.com


agent = Mechanize.new

hackerHours = [] # all the member id who joined hackerhours group

beginnerProgrammer = [] #all the member id who joined beginner programmer group

CSV.open("scrap.csv", "wb") do |csv| # we sre saving information in csv file
  csv << ['HH_Member_ID', 'BP_Member_ID', 'Common_Member_ID']


  offset = 0

  while offset < 3780

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

  for i in 0..271
    i = i.to_s
    page2 = agent.get('http://www.meetup.com/BeginnerProgrammers/members/?offset=' + i)
    count2 = page.search('.memName').count
    i = i.to_i
    i = i*20
      for k in 0...count2

        memberId = page2.search('.memName')[k].attributes['href'].text
        memberId = memberId.split('http://www.meetup.com/BeginnerProgrammers/members/')
        memberId = memberId[1].split('/')
        memberId = memberId.to_s
        beginnerProgrammer << memberId
      end


  end
  puts hackerHours
  puts
  puts beginnerProgrammer

end
