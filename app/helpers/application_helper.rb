module ApplicationHelper
  def edit_and_destroy_buttons(item)
    unless current_user.nil?
      edit = button_to('Edit', url_for([:edit, item]), method: :get, class:"btn btn-primary")
      del = button_to('Destroy', item, method: :delete,
                      data: {confirm: 'Are you sure?' }, class:"btn btn-danger")
      if current_user.admin or item.class == User
        raw("#{edit} #{del}")
      else
        raw("#{edit}")
      end
    end
  end

  def froze_or_reactivate_button(user)
    if not user.froze
      button = button_to 'froze account', toggle_froze_user_path(user.id), method: :post, class:"btn btn-danger"   
    else
      button = button_to 'reactivate account', toggle_froze_user_path(user.id), method: :post, class:"btn btn-danger"
    end
    raw("#{button}")
  end

  def round(param)
    raw(number_with_precision(param, precision: 1))
  end
end
