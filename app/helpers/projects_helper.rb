# frozen_string_literal: true

module ProjectsHelper
  def index_page_links(project)
    if current_user.user_type == 'developer'
      return "<td><a href='#{project_bugs_path(project)}'>See Bugs</a></td>".html_safe
    end
    return managers_link(project) if current_user.user_type == 'manager'
    return qa_links(project) if current_user.user_type == 'qa'
  end

  def managers_link(project)
    "<td><a href='#{edit_project_path(project)}'>Edit</a></td>" \
    "<td><a href='#{project_path(project)}' data-method='delete' data-confirm='Are you sure?'>Delete</a></td>" \
    "<td><a href='#{project_add_developer_qa_path(project)}'>Add/Remove Developer/Qa</a></td>".html_safe
  end

  def qa_links(project)
    "<td><a href='#{project_bugs_path(project)}'>See all bugs in project</a></td>" \
    "<td><a href='#{new_project_bug_path(project)}'>Report Bug</a></td>".html_safe
  end
end
