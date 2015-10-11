class SearchController < ApplicationController

  def default

    p = params

    @results = perform_search { |query|

      query.match p[:query]

      if p[:type] and p[:type] != 'all'
        query.type p[:type]
      end

      if p.include?(:limit)
        query.limit = p[:limit]
      end

      if p.include?(:offset)
        query.offset = p[:offset]
      end

    }

    render 'results'

  end

end
