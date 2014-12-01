require 'rubygems'
require 'oauth'
require 'json'
require 'mechanize'

while true 
  selector = 1 #(1..3).sample
  time1 = Time.now
  if selector == 1
    bill_data = Hash.new { |h, k| h[k] = []}
    agent = Mechanize.new
    bills_page = agent.get("http://laws.leg.mt.gov/legprd/LAW0217W$BAIV.return_all_bills?P_SESS=20131")
    bill_year = "2013"
  end

    i = 0
    z = 0
  bills_page.search('a').each do |x|
    if x.text.strip.split('')[0..1].join('') == "HB"
      bill_data[i] << x.text.strip
      i += 1
      z += 1
    elsif x.text.strip.split('')[0..1].join('') == "LC"
      bill_data[i] << x.text.strip
      i += 1
      z += 1
    elsif x.text.strip.split('')[0..1].join('') == "SB"
      bill_data[i] << x.text.strip
      i += 1
      z += 1
    else 
      next
    end 
  end

    i = 0
  bills_page.search(':nth-child(6)').each do |value|
        bill_data[i] << value.text.strip
        i += 1
  end
  result = (0..z).to_a.sample
  tweet_data = bill_data[result]
  
  puts "#{tweet_data[0]} (#{bill_year}), an act to #{tweet_data[1]} #pastmtleg"
  time2 = Time.now
  real_time = time2 - time1
  puts real_time
end

    #fromline16  bill_data[value.text.strip] = {} #intialize 
# TODO: create section for each year to randomly select after done
#TODO: incorporate link, bill number and title into same array.
#BULK OUT AND DO TWITTER AUTH
#
#
#
