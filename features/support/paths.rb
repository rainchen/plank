module NavigationHelpers
  def path_to(page_name)
    case page_name

    when /the homepage/i
      root_path
    when /the sign up page/i
      new_user_path
    when /the sign in page/i
      login_path
    when /the password reset request page/i
      new_password_reset_path

    # Add more page name => path mappings here

    else
      if (/^the (.+) page$/ =~ page_name)
        begin
          send($1+"_path")
        rescue
          raise "Can't find mapping from \"#{page_name}\" to a path."
        end
      end
    end
  end
end

World(NavigationHelpers)
