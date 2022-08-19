# frozen_string_literal: true

module BugsHelper
  def developer_links(bug)
    html = ''
    if current_user.user_type == 'developer'

      case bug.status
      when 'started', 'new_bug'

        if bug.developer_id.nil?
          html += link_to 'Assign Bug to Yourself', bug_assign_developer_path(bug), remote: true,
                                                                                    id: "BugNo-#{bug.id}"
        end

        if bug.developer_id == current_user.id
          if bug.type_of_bug == 'bug'
            html += link_to 'Mark bug Resolved', bug_mark_resolved_path(bug, status: 'resolved'), remote: true,
                                                                                                  id: "BugNo-#{bug.id}"
          else
            html += link_to 'Mark feature Completed', bug_mark_resolved_path(bug, status: 'completed'), remote: true,
                                                                                                        id: "BugNo-#{bug.id}"
          end
        end

      when 'resolved'
        html +=   "<span id: 'BugNo-#{bug.id}'>Resolved</span>"
      when 'completed'
        html +=   "<span id: 'BugNo-#{bug.id}'>Completed</span>"
      end
    end
    html.html_safe
  end

  def report_another_bug
    "<td><a href='#{new_project_bug_path}'>Report another Bug</a></td>".html_safe if current_user.user_type == 'qa'
  end

  def qa_link(bug)
    if current_user.user_type == 'qa'
      "<a href='#{edit_bug_path(bug, project_id: bug.project_id)}'>Edit</a></td>" \
      "<td><a href='#{bug_path(bug)}' data-method='delete' data-confirm='Are you sure?'>Delete</a>".html_safe
    end
  end
end
