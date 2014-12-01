require 'rubygems'
require 'oauth'
require 'json'
require 'mechanize'
length_avg = []
longest_one = 0
while true 
  selector = (1..8).to_a.sample
  bill_data = Hash.new { |h, k| h[k] = []}
  agent = Mechanize.new

  if selector == 1
    bills_page = agent.get("http://laws.leg.mt.gov/legprd/LAW0217W$BAIV.return_all_bills?P_SESS=20131")
    bill_year = "2013"
  end

  if selector == 2
    bills_page = agent.get("http://laws.leg.mt.gov/legprd/LAW0217W$BAIV.return_all_bills?P_SESS=20111")
    bill_year = "2011"
  end

  if selector == 3
    bills_page = agent.get("http://laws.leg.mt.gov/legprd/LAW0217W$BAIV.return_all_bills?P_SESS=20091")
    bill_year = "2009"
  end

  if selector == 4
    bills_page = agent.get("http://laws.leg.mt.gov/legprd/LAW0217W$BAIV.return_all_bills?P_SESS=20071")
    bill_year = "2007"
  end

  if selector == 5
    bills_page = agent.get("http://laws.leg.mt.gov/legprd/LAW0217W$BAIV.return_all_bills?P_SESS=20051")
    bill_year = "2005"
  end

  if selector == 6
    bills_page = agent.get("http://laws.leg.mt.gov/legprd/LAW0217W$BAIV.return_all_bills?P_SESS=20031")
    bill_year = "2003"
  end

  if selector == 7
    bills_page = agent.get("http://laws.leg.mt.gov/legprd/LAW0217W$BAIV.return_all_bills?P_SESS=20011")
    bill_year = "2001"
  end

  if selector == 8
    bills_page = agent.get("http://laws.leg.mt.gov/legprd/LAW0217W$BAIV.return_all_bills?P_SESS=19991")
    bill_year = "1999"
  end


###PUT FURTHER SELECTORS HERE

    i = 0
    z = 0
    #DEBUG CODE
    puts "this is the selector: #{selector}"
  #BILL TITLE SCRAPE
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
  #BILL NAME SCRAPE
  bills_page.search(':nth-child(6)').each do |value|
        bill_data[i] << value.text.strip
        i += 1
  end

  i= 0

  #BILL SELECTOR
  result = (0..z).to_a.sample
  
  #LINK SCRAPER
  bills_page.links_with(:text => bill_data[result][0]).each do |link|
    next_page = link.click
    bill_data[result] << next_page.uri.to_s #WILL I NEED A LINK SHORTENER?
  end

  tweet_data = bill_data[result]
  
  length_tracker = "#{tweet_data[0]} (#{bill_year}), an act to #{tweet_data[1]} laws.leg.mt.gov/legprd/#{tweet_data[2]} #pastmtleg"

  puts length_tracker

  #everything below is for debugging and testing lengths. delete when done.

  if length_tracker.length > longest_one
    longest_one = length_tracker.length
  end
  puts "longest so far is #{longest_one}"
  
  length_avg << length_tracker.length
  length_sum = length_avg.inject{|sum,x| sum + x}
  total_avg = length_sum / length_avg.length
  puts "average is #{total_avg}"

end

    #fromline16  bill_data[value.text.strip] = {} #intialize 
# TODO: create section for each year to randomly select after done
#TODO: incorporate link, bill number and title into same array.
#BULK OUT AND DO TWITTER AUTH
#LINK SCRAPE
#BULK OUT PAST SESSIONS
#TWITTER AUTH
