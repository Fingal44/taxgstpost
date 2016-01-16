module HeaderHelper
  
#end

=begin
def login_box(title, count, recent)
  content_tag :div, :class => title.downcase do # оборачиваем все в div
    raw(
      title + 
      content_tag(:span, count) + # создаем span
      recent.collect do |user|  # собираем линки на юзеров
        link_to user do
          image_tag(user.avatar.url(:thumb))
        end
      end.join
      )   # собираем все в кучу и в сыром виде возвращаем во вьюху
  end
end
=end

@lll = 88

def set_logo
  image_tag("serg.png", alt: 'Hren vam!',  size: "75x65")
end

def set_language(ll)
  $CurrentLanguage = ll
end

def show_title(title)
 content_tag(:span, text_field_tag(:h2,title, :class => "kk"))
end

def show_title_h1(title)
 content_tag(text_field_tag(:h1,title))
end

def show_text(title)
  content_tag(:span, title)
end

def show_contacts
  show_text(simple_format($contactperson)) +
  show_text(simple_format($contactphone)) +
  show_text(simple_format($contactmobile)) +
  show_text(simple_format($contactEmail))
end

def show_mk
  text_field_tag(:h1,"Mk1" ) +
      text_field_tag(:h1,"Mk2") +
      text_field_tag(:h1,"Mk3" )
end

def show_title3
  content_tag(:ul) do
    show_text("h1") +
        show_text("h2") +
        show_text("h3") +
 show_title("h4") +
 show_title("h5") +
  show_title("h6") +
  show_mk
  end
end

def show_logo
  set_logo +
      set_logo +
      set_logo
end

 def show_id(title)
   content_tag(:h4, title)
 end

def show_nav

  content_tag(:ul) do
    link_to( "Home" , root_path)  +
    link_to( "Users" , users_path)  +
        link_to( "Profile" , current_user)
  end
end

def show_nav_header

  content_tag(:ul) do
    link_to( "Home " , root_path)  +
    link_to( "Help " , help_path)  +
    link_to( "Sign in " , signin_path)
  end
end

  def fill_header(title)
    content_tag :header, :class => "round" do
      image_tag("logo_120_dark.png", :alt => "Platon", :id => "logo")  +
     form_tag('/users') do

          content_tag(:br, email_field_tag( 'idemail', '', :placeholder => 'Username or Email', :size => 20))   +

             password_field_tag( 'pwd', '',options = { :placeholder => 'Password', :size => '10'})  +
              content_tag( :button, value = 'Sign in')

     end  +
          content_tag(:div, content_tag(:h1,"Storytime"))
    end
  end

def fill_form
    form_tag do

          content_tag(:br, email_field_tag( 'idemail', '', :placeholder => 'Username or Email', :size => 20))   +

             password_field_tag( 'pwd', '',options = { :placeholder => 'Password', :size => '10'})  +
              content_tag( :button, value = link_to( "Sign in " , signin_path))

     end  
end
=begin
  def Sign_in
     content_tag(:bro, email_field_tag( 'idemail', '', :placeholder => 'Username or Email', :size => 20))   +

      password_field_tag( 'pwd', '',options = { :placeholder => 'Password', :size => '10'})  +
          content_tag( :button, value = 'Sign in')
  end
#     ( :header, content_tag(:h1, title), :class => 'round' )
=end



  def login_box(title)
    content_tag( :div, content_tag(:h1, title), :class => 'logss' )
   
  end
  
  def radio_button_tag(name, value, checked = false, options = {})
        html_options = { "type" => "radio", "name" => name, "id" => "#{sanitize_to_id(name)}_#{sanitize_to_id(value)}", "value" => value }.update(options.stringify_keys)
        html_options["checked"] = "checked" if checked
        tag :input, html_options
  end
end
