require "rubygems"
require "mechanize"
require "csv"


agent = Mechanize.new

# page = agent.get('http://www.meetup.com/hackerhours/members')

# name = page.search('.memName')[0].text

#puts name[0]

 # puts name

#  for i in 0..188
#     i = i.to_s
#     page = agent.get('http://www.meetup.com/hackerhours/members?offset=' + (i)
#     # puts page.to_s
#     count = page.search('.memName').count
#     for j in 0..count-1
#         puts page.search('.memName')[j].text
#     end
#     i = i.to_i
#     i *= 20
# end

CSV.open("scrap.csv", "wb") do |csv|
  csv << ['Member_ID']


offset = 0

while offset < 3780

    offset = offset.to_s

    page = agent.get('http://www.meetup.com/hackerhours/members/?offset=' + offset)
    count = page.search('.memName').count
    offset = offset.to_i
    for j in 0...count
        puts page.search('.memName')[j].text
        name = page.search('.memName')[j].text
        csv << [name]
    end

    offset += 20
end


end
