module Application
  module IndexAdapter
    module Elasticsearch

      def index_name
        Rails.application.config.elasticsearch_config[:index_name]
      end

      def index_client
        Rails.application.config.elasticsearch_client
      end

    end
  end
end