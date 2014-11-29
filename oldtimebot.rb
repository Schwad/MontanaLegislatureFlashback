require 'rubygems'
require 'oauth'
require 'json'
require 'mechanize'

while true 
  selector = 1 #(1..3).sample

  if selector == 1
    bill_data = Hash.new
    agent = Mechanize.new
    bills_page = agent.get("http://laws.leg.mt.gov/legprd/LAW0217W$BAIV.return_all_bills?P_SESS=20131")
    bill_year = "2013"

    bill_number = bills_page.search(':nth-child(6)').each do |value|
      bill_data[value.text.strip] = {} #intialize 
    end
  end

  puts bill_data.to_a.sample
  exit
end


# TODO: create section for each year to randomly select after done
#TODO: incorporate link, bill number and title into same array.
#
#
#
#
