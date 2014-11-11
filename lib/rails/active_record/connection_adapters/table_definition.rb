module ActiveRecord
  module ConnectionAdapters #:nodoc:
    class TableDefinition

      # Adds a deleted_at column when timestamps is called from a migration.
      def timestamps_with_deleted_at
        timestamps_without_deleted_at
        column(:deleted_at, :datetime)
      end

      alias_method_chain :timestamps, :deleted_at

    end
  end
end