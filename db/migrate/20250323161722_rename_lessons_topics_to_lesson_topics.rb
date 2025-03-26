class RenameLessonsTopicsToLessonTopics < ActiveRecord::Migration[8.0]
  def change
    rename_table :lessons_topics, :lesson_topics
  end
end
