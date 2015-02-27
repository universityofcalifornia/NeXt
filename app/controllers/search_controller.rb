class SearchController < ApplicationController

  TYPE_MAP = {
    'ideas' => {
        :class => Idea,
        :type_name => 'Idea',
        :title_method => :name,
        :description_proc => Proc.new(){ |idea| idea.pitch }
    },
    'projects' => {
        :class => Project,
        :type_name => 'Project',
        :title_method => :name,
        :description_proc => Proc.new(){ |project| project.pitch }
    },
    'users' => {
        :class => User,
        :type_name => 'Person',
        :title_method => :display_name,
        :description_proc => Proc.new(){ |user|
          if user.primary_position
            "#{user.primary_position.title}, #{user.primary_position.department} ( #{user.primary_position.organization.shortname} )"
          else
            nil
          end
        }
    }
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

    search_properties = {
      index: index_name,
      body: search_body
    }

    if params[:type] and params[:type] != 'all'
      search_properties[:type] = params[:type]
    end

    res = Rails.application.config.elasticsearch_client.search search_properties

    @results = res['hits']['hits'].map { |r|
      begin
        model = TYPE_MAP[r['_type']][:class].find(r['_id'])
        OpenStruct.new({
          :model => model,
          :title => model.send(TYPE_MAP[r['_type']][:title_method]),
          :type => TYPE_MAP[r['_type']][:type_name],
          :score => r['_score'],
          :description => TYPE_MAP[r['_type']][:description_proc].call(model)
        })
      rescue => e
        puts e
        nil
      end
    }.delete_if { |o| o.nil? }

    render 'results'

  end

end
