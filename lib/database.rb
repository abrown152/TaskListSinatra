require 'sqlite3'

module TaskList
  class Database
    attr_reader :db

    def initialize(dbname = "task_list")
      @db = SQLite3::Database.new("database/#{dbname}.db")
      create_schema!
    end

    private

    def create_schema!
      query = <<-CREATESTATEMENT
        CREATE TABLE task_list (
          id INTEGER PRIMARY KEY,
          title TEXT NOT NULL,
          description TEXT,
          completed_at TEXT,
          status TEXT
        );
      CREATESTATEMENT

      # @db.execute("DROP TABLE IF EXISTS task_list;")
      @db.execute(query) # runs one and only one query
    end

  end

  class TaskRecord
    attr_reader :db

    def initialize(dbname = "task_list")
      @db = SQLite3::Database.new("database/#{dbname}.db")
    end

    def new_task(task)

      insert_statement = <<-INSERTSTATEMENT
        INSERT INTO task_list (
        title, description, completed_at, status
        ) VALUES (
        "#{task["title"]}", "#{task["description"]}", "#{task["completed_at"]}", "no"
        );
      INSERTSTATEMENT

       @db.execute(insert_statement)

    end

  end
end
