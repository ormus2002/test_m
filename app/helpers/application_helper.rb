# -*- encoding : utf-8 -*-
module ApplicationHelper

  def bootstrap_class_for flash_type
    case flash_type
      when :success
        "alert-success"
      when :error
        "alert-error"
      when :alert
        "alert-block"
      when :notice
        "alert-info"
      else
        flash_type.to_s
    end
  end

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
