module ActiveRecord
  class Base
    def self.truncate
      case ActiveRecord::Base.connection.adapter_name
        when 'SQLite'
          self.destroy_all
          update_seq_sql = "update sqlite_sequence set seq = 0 where name = '#{table_name}';"
          ActiveRecord::Base.connection.execute(update_seq_sql)
        when 'Mysql2'
          self.destroy_all
          update_seq_sql = "truncate #{table_name};"
          ActiveRecord::Base.connection.execute(update_seq_sql)
        else
          raise "ActiveRecord::Base#truncate not implemented for DB adapter #{ActiveRecord::Base.connection.adapter_name}"
      end
    end
  end
end