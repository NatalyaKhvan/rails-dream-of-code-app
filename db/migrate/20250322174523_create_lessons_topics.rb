class CreateLessonsTopics < ActiveRecord::Migration[8.0]
  def change
    create_table :lessons_topics do |t|
      t.references :topic
      t.references :lesson
      t.timestamps
    end
  end
end
