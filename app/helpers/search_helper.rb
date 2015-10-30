module SearchHelper

  class ElasticsearchHelper

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

    def initialize
      @search_body = {}
      @should_queries = []
      index_name = Rails.application.config.elasticsearch_config[:index_name]
      @search_properties = {
          index: index_name
      }
    end

    def match phrase
      @should_queries.push({
        'multi_match' => {
          'query' => phrase,
          'type' => 'phrase_prefix',
          'fields' => ['title', 'description', 'competencies']
        }
      })
    end

    def type val
      @search_properties[:type] = val
    end

    def limit val
      @search_body['size'] = val
    end

    def offset val
      @search_body['from'] = val
    end

    def generate_body!
      @search_body['query'] = {
        "function_score" => {
            "query" => {
                'bool' => {
                    'should' => @should_queries
                }
            },
            "functions" => [
                {
                    "exp" => {
                        "created_at" => {
                            "origin" => Time.now.strftime('%Y-%m-%dT%H:%M:%S%:z'), #"2015-09-27T23:50:00",
                            "scale" => "180d",
                            "offset" => "90d",
                            "decay" => 0.6
                        }
                    }
                },
                {
                    "field_value_factor" => {
                        "field" => "votes",
                        "factor" => 4, # gives ideas and projects as 3x weight over users
                        "modifier" => "sqrt",
                        "missing" => 0.25
                    }
                }
            ],
            "score_mode" => "multiply" # default
        }
      }
    end

    def finalize_search_properties!
      generate_body!
      @search_properties[:body] = @search_body
    end

    def results

      finalize_search_properties!

      res = Rails.application.config.elasticsearch_client.search @search_properties

      res['hits']['hits'].map { |r|
        begin
          model = TYPE_MAP[r['_type']][:class].find(r['_id'])
          OpenStruct.new({
                             :model => model,
                             :title => model.send(TYPE_MAP[r['_type']][:title_method]),
                             :type => TYPE_MAP[r['_type']][:type_name],
                             :score => r['_score'],
                             :description => TYPE_MAP[r['_type']][:description_proc].call(model),
                             :r => r
                         })
        rescue => e
          puts e
          nil
        end
      }.delete_if { |o| o.nil? }

    end

  end

  def perform_search &block

    helper = ElasticsearchHelper.new
    helper.instance_exec helper, &block
    helper.results

  end

end
