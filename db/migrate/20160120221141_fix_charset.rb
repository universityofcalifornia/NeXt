class FixCharset < ActiveRecord::Migration
  def change

    case ActiveRecord::Base.connection.adapter_name
    when "MySQL", "Mysql2"
      execute "ALTER DATABASE next DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_unicode_ci"
      execute("ALTER TABLE badges MODIFY `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin")
      execute("ALTER TABLE badge_categories MODIFY `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin")
      #execute("ALTER TABLE comments CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin")
      execute("ALTER TABLE comments MODIFY `body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin")
      execute("ALTER TABLE events MODIFY `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin")
      execute("ALTER TABLE events MODIFY `short_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin")
      execute("ALTER TABLE groups MODIFY `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin")
      execute("ALTER TABLE ideas MODIFY `pitch` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin")
      execute("ALTER TABLE ideas MODIFY `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin")
      execute("ALTER TABLE idea_statuses MODIFY `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin")
      execute("ALTER TABLE idea_statuses MODIFY `icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin")
      execute("ALTER TABLE positions MODIFY `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin")
      execute("ALTER TABLE projects MODIFY `pitch` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin")
      execute("ALTER TABLE projects MODIFY `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin")
      execute("ALTER TABLE project_statuses MODIFY `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin")
      execute("ALTER TABLE project_statuses MODIFY `icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin")
      execute("ALTER TABLE users MODIFY `biography` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin")
    when "SQLite"
      # do nothing since SQLite does not support changing the database encoding and only supports unicode charsets
    end

  end
end
