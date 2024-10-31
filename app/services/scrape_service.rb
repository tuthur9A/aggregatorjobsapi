class ScrapeService
  def initialize
  end

# TODO
# covid
# economie circulaire
# intelligence artificielle
# informatique
# technologie

def scrapperHelloWork (url)
    # bddUrl = "https://arthurcargnelli.eu/news/add"
    # uri = URI(bddUrl)
    unparse_page = HTTParty.get(url)
    parse_page = Nokogiri::HTML(unparse_page.body)
    actus = Array.new
    counter = 0
    limit = 30
    if parse_page != nil
        test = parse_page.search("div.tw-grid", "//li//div")
        test.each do |elem|
            counter += 1
            if counter <= limit
                actu = {
                    title: nil,
                    description: nil,
                    url: nil
                }
                if elem.css("p.tw-typo-l")[0] != nil
                    actu[:title] = elem.css("p.tw-typo-l")[0].content
                end
                if elem.search("//header//div//a") != nil
                    # articleUrl = elem.css(a).attributes["href"].value
                    actu[:url] = "https://www.hellowork.com" + elem.css("a.tw-no-underline")[0].attributes["href"]
                end
                if actu[:title] != nil
                    # HTTParty.post(uri, body: { news: actu })
                    actus << actu
                end
            end
        end
    end
    # print actus.to_json
    # print actus.count.to_s + " " + search + " news send to "+ bddUrl + " ok" + "\n"
    actus
end

def scrapperIndeed (url)
    # bddUrl = "https://arthurcargnelli.eu/news/add"
    # uri = URI(bddUrl)
    unparse_page = HTTParty.get(url, headers: {
        "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) bruno/v1.30.1 Chrome/126.0.6478.127 Electron/31.2.1 Safari/537.36"
      })
    parse_page = Nokogiri::HTML(unparse_page.body)
    actus = Array.new
    # counter = 0
    # limit = 30
    if parse_page != nil
        test = parse_page
        print test
      # test.each do |elem|
      #     counter += 1
      #     if counter <= limit
      #         actu = {
      #             title: nil,
      #             description: nil,
      #             url: nil
      #         }
      #         if elem.css("p.tw-typo-l")[0] != nil
      #             actu[:title] = elem.css("p.tw-typo-l")[0].content
      #         end
      #         if elem.search("//header//div//a") != nil
      #             # articleUrl = elem.css(a).attributes["href"].value
      #             actu[:url] = "https://www.hellowork.com" + elem.css("a.tw-no-underline")[0].attributes["href"]
      #         end
      #         if actu[:title] != nil
      #             # HTTParty.post(uri, body: { news: actu })
      #             actus << actu
      #         end
      #     end
      # end
    end
    # print actus.to_json
    # print actus.count.to_s + " " + search + " news send to "+ bddUrl + " ok" + "\n"
    actus
end

def scrapperFreeWork (url)
    unparse_page = HTTParty.get(url, headers: {
        "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) bruno/v1.30.1 Chrome/126.0.6478.127 Electron/31.2.1 Safari/537.36"
      })
    parse_page = Nokogiri::HTML(unparse_page.body)
    actus = Array.new
    counter = 0
    limit = 30
    if parse_page != nil
        test = parse_page.css('#content > div.flex-1 > div.w-full.mx-auto.px-4.md\:px-8.py-4.bg-dot.min-h-screen > div > div > div.col-span-3.lg\:col-span-2 > div > div:nth-child(1)')
      # print test
      test.each do |elem|
          counter += 1
          if counter <= limit
              actu = {
                  title: nil,
                  description: nil,
                  url: nil
              }
              if elem.search("a") != nil
                  link = elem.search("a")[0]
                  actu[:title] = link.content
                  actu[:url] = "https://www.free-work.com" + link.attributes["href"]
              end
              #   if elem.search("//header//div//a") != nil
              #     # articleUrl = elem.css(a).attributes["href"].value
              #     #   actu[:url] = "https://www.hellowork.com" + elem.css("a.tw-no-underline")[0].attributes["href"]
              #   end
              if actu[:title] != nil
                  # HTTParty.post(uri, body: { news: actu })
                  actus << actu
              end
          end
      end
    end
    # print actus.to_json
    # print actus.count.to_s + " " + search + " news send to "+ bddUrl + " ok" + "\n"
    actus
end


  # scrapper("intelligence artificielle","https://news.google.com/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRGRqTVhZU0FtWnlHZ0pHVWlnQVAB/sections/CAQiQ0NCQVNMQW9JTDIwdk1EZGpNWFlTQW1aeUdnSkdVaUlOQ0FRYUNRb0hMMjB2TUcxcmVpb0pFZ2N2YlM4d2JXdDZLQUEqKggAKiYICiIgQ0JBU0Vnb0lMMjB2TURkak1YWVNBbVp5R2dKR1VpZ0FQAVAB?hl=fr&gl=FR&ceid=FR%3Afr")
  # scrapper("technologie","https://news.google.com/search?q=technologie&hl=fr&gl=FR&ceid=FR%3Afr")
  # scrapper("informatique","https://news.google.com/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRGRqTVhZU0FtWnlHZ0pHVWlnQVAB/sections/CAQiRkNCQVNMZ29JTDIwdk1EZGpNWFlTQW1aeUdnSkdVaUlPQ0FRYUNnb0lMMjB2TURGc2NITXFDaElJTDIwdk1ERnNjSE1vQUEqKggAKiYICiIgQ0JBU0Vnb0lMMjB2TURkak1YWVNBbVp5R2dKR1VpZ0FQAVAB?hl=fr&gl=FR&ceid=FR%3Afr")
  # scrapper("economie circulaire","https://news.google.com/search?q=economie%20circulaire&hl=fr&gl=FR&ceid=FR%3Afr")
  # scrapper("covid","https://news.google.com/search?q=Coronavirus&hl=fr&gl=FR&ceid=FR%3Afr")
end
