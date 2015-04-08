class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_user

  helper_method :current_user


  WillPaginate.per_page = 20

  def check_authorize
  	token = params[:token]
  	if OauthAccessToken.where('token = ?', token).empty?
  		false
  	else
  		user_id = OauthAccessToken.where('token = ?', token).first.resource_owner_id
  		@user = User.find(user_id)
  		if @user
  			true
  		else
  			false
  		end
  	end
  end

  def current_user
    if !cookies[:user_id] || cookies[:user_id].empty?
      nil
    else
      if User.where('id = ?', cookies[:user_id]).any?
        User.find(cookies[:user_id])
      else
        User.new
      end
    end
  end

  def set_user
    if current_user
      @current_user = current_user
    else
      @current_user = User.new
    end
  end

  def check_power
    if !current_user
      redirect_to :controller => :index, :action => :login
    else
      #check_action
    end
  end
end


# A custom renderer class for WillPaginate that produces markup suitable for use with Semantic.
  class SemanticPagination < WillPaginate::ActionView::LinkRenderer
    ELLIPSIS = "&hellip;"

    def to_html
      list_items = pagination.map do |item|
        case item
          when Fixnum
            page_number(item)
          else
            send(item)
        end
      end.join(@options[:link_separator])

      tag("div", list_items, class: "fenye")
    end

    def container_attributes
      super.except(*[:link_options])
    end

    protected

    def page_number(page)
      link_options = @options[:link_options] || {}

      if page == current_page
        link(page, nil, :class => "active")
        #tag("li", link(page, nil), :class => "active")
      else
        link(page, page)
        #tag("li", link(page, page))
      end
    end

    def previous_or_next_page(page, text, classname)
      link_options = @options[:link_options] || {}

      if page
        #tag("li", link(text, page, link_options))
        link(text, page, link_options)
        #link(tag("i", nil, class: classname), page, class: "icon item")
      else
        #tag("li", tag("span", text), class: "%s disabled" % classname)
        #tag("li", link(text, nil), class: "active")
        link(text, nil)
        #link(tag("i", nil, class: classname), nil, class: "icon item")
      end
    end

    def gap
      tag("li", link(ELLIPSIS, "#"), class: "disabled")
    end

    def previous_page
      num = @collection.current_page > 1 && @collection.current_page - 1
      #previous_or_next_page(num, @options[:previous_label], "")
      previous_or_next_page(num, "上一页", "")
    end

    def next_page
      num = @collection.current_page < @collection.total_pages && @collection.current_page + 1
      #previous_or_next_page(num, @options[:next_label], "")
      previous_or_next_page(num, "下一页", "")
    end
  end