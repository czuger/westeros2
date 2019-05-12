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

  house_data = nil
  begin
    house_data = Nokogiri(open(page))
  rescue
    next
  end

  house_info = house_data.xpath("//tr[@class='entete']")

  # p house_info

  next if house_info.empty?

  next if house_info.at('i:contains("Blason inconnu")')
  next unless house_data.xpath("//a[@title='Blason inconnu']").empty?

  name = house_info.children.children.text.strip.gsub('Maison ', '')

  p page
  house_info = house_info.first.parent.parent.parent.parent.parent
  # p house_info
  # p house_info.xpath('.//img')
  # puts

  blason = house_info.at('.//img').attribute('src').text
  `wget #{'https://www.lagardedenuit.com'+blason}`
  `mv *.png ../../app/assets/images/blasons/`
  blason = File.basename(blason)

  vo = house_info.at('b:contains("V.O.")').parent.next_element.children.text.strip.gsub(/.ouse /, '')

  location = house_info.at('b:contains("Demeure")')
  location = location.parent.next_element.children.text.strip if location

  rang = house_info.at('b:contains("Rang")')
  rang = rang.parent.next_element.children.text.strip if rang

  vassal_of = house_info.at('b:contains("Vassale de")')
  vassal_of = vassal_of.parent.next_element.children.text.strip.gsub(/.aison /, '') if vassal_of

  h_db[name] = { name: name, vo: vo, location: location, rang: rang, vassal_of: vassal_of, blason: blason, url: page }

  File.open('db.yaml', 'w') do |f|
    f.write(h_db.to_yaml)
  end

end