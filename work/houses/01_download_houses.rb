require 'open-uri'
require 'nokogiri'
require 'yaml'

f = open('https://www.lagardedenuit.com/wiki/index.php?title=Liste_des_maisons_nobles_de_Westeros#Les_terres_de_la_Couronne')
doc = Nokogiri(f)

# h_db = YAML.load_file('db.yaml')
h_db = {}

doc.xpath('//a[starts-with(@title, "Maison")]').each do |house|
  href = house.attribute('href').value
  page = 'https://www.lagardedenuit.com' + href

  p File.basename(page)
  unless File.exist?( 'data/' + File.basename(page) )
    `wget #{page}`
    `mv index.php* data/`
  end

end