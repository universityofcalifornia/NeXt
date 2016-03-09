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

    def is_viewable_by? user
      privacies = self.try :privacies

      # Object is viewable if it has no privacy conditions or doesn't support them
      if privacies.blank?
        return true
      # Object is always viewable to its owner
      elsif respond_to?(:is_owner?) && is_owner?(user)
        return true
      # Anonymous users can't view anything with privacy conditions
      elsif user.nil?
        return false
      # Super admins can view anything
      elsif user.super_admin
        return true
      else
        orgs = privacies.map(&:organization_id).compact

        # If any campuses are listed, only members of that campus can view it
        if orgs.any?
          return orgs.include? user.primary_organization.try(:id)
        # Otherwise, anyone with a profile can view it
        else
          return true
        end
      end
    end
  end
end
