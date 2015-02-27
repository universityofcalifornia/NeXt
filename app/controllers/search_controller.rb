class SearchController < ApplicationController

  TYPE_MAP = {
    'ideas' => Idea,
    'projects' => Project,
    'users' => User
  }

  def default

    search_body = {}

    search_body['size'] = params[:limit] if params.include?(:limit)
    search_body['from'] = params[:offset] if params.include?(:offset)
    search_body['query'] = {
      'bool' => {
        'must' => [
          {
            'multi_match' => {
              'query' => params[:query],
              'type' => 'phrase_prefix',
              'fields' => ['_all']
            }
          }
        ]
      }
    }

    index_name = Rails.application.config.elasticsearch_config[:index_name]

    res = Rails.application.config.elasticsearch_client.search index: index_name,
                                                               body: search_body

    results = res['hits']['hits'].map { |r|
      begin
      {
        :object => TYPE_MAP[r['_type']].find(r['_id']),
        :score => r['_score']
      }
      rescue
        nil
      end
    }.delete_if { |o| o.nil? }

    render plain: results

  end

end
