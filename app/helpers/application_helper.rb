# -*- encoding : utf-8 -*-
module ApplicationHelper

# Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Пример"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def admin?(user)
    !user.role.nil? && user.role.name == "Администратор"
  end

  def manager?(user)
    !user.role.nil? && user.role.name == "Менеджер"
  end

  def worker?(user)
    !user.role.nil? && user.role.name == "Работник"
  end

  def bux?(user)
    !user.role.nil? && user.role.name == "Бухгалтер"
  end

  def current_user?(user)
    user == current_user
  end
end
