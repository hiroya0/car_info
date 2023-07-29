class NewsController < ApplicationController
    require 'news-api'
    def index
        newsapi = News.new(ENV['NEWS_API_KEY'])

        parameters = {
            q: URI.encode('車'),
            language: 'jp'
        }

        response = 
        newsapi.get_top_headlines(parameters)

        data = if response.is_a?(String)
                    JSON.parse(response)
                else
                    response
                end

        if data[status] == 'ok'
            @articles = data['articles']
        else
            @error = 'ニュースの取得に失敗しました。'
        end
       

    end
end
