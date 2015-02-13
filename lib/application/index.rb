module Application

  # To use this module, you must:
  # -> INCLUDE Application::IndexAdapter::??
  # -> DEFINE index_identity
  # -> DEFINE index_body

  module Index

    def index_data
      index_identity.merge({body: index_body})
    end

    def create_index!
      index_client.create index_data
    end

    def prepare_index_body &block
      body = instance_exec(&block)
      body['created_at_esdate'] = created_at.to_formatted_s(:db)
      body['created_at_unixtime'] = created_at.to_i
      body
    end

    def destroy_index!
      index_client.delete index_identity
    end

    def index_exists?
      index_client.exists index_identity
    end

  end
end