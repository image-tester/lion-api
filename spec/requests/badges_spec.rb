require 'spec_helper'

describe 'Tasks Requests' do
  describe 'GET /tasks' do
    it 'responds with a json containing the current list of tasks' do
      tasks = []
      2.times { tasks << current_user.tasks.create(title: 'lol') }

      tasks.each do |task|
        2.times { create(:comment, task: task) }
      end

      get api_tasks_path

      expect(last_response.status).to eq(200)
      parsed_response = JSON.parse(last_response.body)

      expect(parsed_response['tasks']).to eq(
        tasks.map do |task|
          {
            'id' => task.id,
            'title' => task.title,
            'created_at' => task.created_at.iso8601(3),
            'client_id' => task.client_id,
            'completed' => false,
            'user_id' => task.user.id,
            'assignee_id' => task.assignee.try(:id),
            'comment_ids' => task.comment_ids
          }
        end
      )

      expect(parsed_response['users']).to eq(
        tasks.map do |task|
          {
            'id' => task.user.id,
            'avatar_url' => task.user.avatar_url,
            'nickname' => task.user.nickname
          }
        end.uniq
      )

      expect(parsed_response['comments']).to eq(
        tasks.map(&:comments).flatten.map do |comment|
          {
            'id' => comment.id,
            'body' => comment.body,
            'created_at' => comment.created_at.iso8601(3),
            'client_id' => comment.client_id,
            'user_id' => comment.user_id,
            'task_id' => comment.task_id
          }
        end.uniq
      )
    end
  end
end