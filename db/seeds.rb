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

browser = Watir::Browser.new
browser.goto 'https://www.doorsopen.co/jobs/?q=uk'

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
    link: job_listing.css('.media-body').css('a')[0].attributes['href'].value,
    long_desc: Nokogiri::HTML(HTTParty.get(job_listing.css('.media-body').css('a')[0].attributes['href'].value)).css('.container').css('.details-body__content').text
    source: "Doors Open"
  )
end




