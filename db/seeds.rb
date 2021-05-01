# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'HTTParty'
require 'Nokogiri'
require 'watir'
require 'webdrivers/chromedriver'
require 'byebug'

puts "Running seed..."
puts "Destroying Job table..."
Job.delete_all

puts "Running Doors Open..."
browser = Watir::Browser.new
browser.goto 'https://www.doorsopen.co/jobs/?q=uk'

puts "Clicking load more..."
while browser.button(text: 'Load more').present?
  browser.button(text: 'Load more').click
  sleep 1
end

parse_page = Nokogiri::HTML(browser.html)
job_listings = parse_page.css('.listing-item') # 36

job_listings.each do |job_listing|
  job = Job.create!(
    title: job_listing.css('.media-heading').text.strip,
    employer: job_listing.css('.listing-item__info--item-company').text.strip,
    location: job_listing.css('.listing-item__info--item-location').text.strip,
    short_desc: job_listing.css('.listing-item__desc').text,
    long_desc: Nokogiri::HTML(HTTParty.get(job_listing.css('.media-body').css('a')[0].attributes['href'].value).body).css('.container').css('.details-body__content').text,
    link: job_listing.css('.media-body').css('a')[0].attributes['href'].value,
    source: "Doors Open"
  )
end


puts "Running Festicket..."
browser = Watir::Browser.new
browser.goto 'https://apply.workable.com/festicket/?lng=en'

puts "Clicking show more..."
while browser.button(text: 'Show more').present?
  browser.button(text: 'Show more').click
  sleep 1
end

puts "Parsing the page..."
parse_page = Nokogiri::HTML(browser.html)
job_listings = parse_page.css('.careers-jobs-list-styles__job--3Cb9F') # 36

job_listings.each do |job_listing|

  puts "Opening jobs page and copying the description..."
  browser.goto 'https://apply.workable.com' + job_listing.css('a')[0]['href']
  sleep 2
  parse_page = Nokogiri::HTML(browser.html)
  desc = parse_page.css('.job-preview-styles__description--2BkR3').text

  puts "Saving job..."
  job = Job.create!(
    title: job_listing.css('.careers-jobs-list-styles__title--1cN5S').text.strip,
    employer: 'Festicekt',
    location: job_listings.css('.job-details-styles__details--11P0z').css('span')[1].text,
    short_desc: '',
    long_desc: desc,
    link: 'https://apply.workable.com' + job_listing.css('a')[0]['href'],
    source: "Festicket"
    )
end


