class Devise::RegistrationsController < DeviseController
  prepend_before_filter :require_no_authentication, only: [:new, :create, :cancel]
  prepend_before_filter :authenticate_scope!, only: [:edit, :update, :destroy]

  # GET /resource/sign_up
  def new
    build_resource({})
    set_minimum_password_length
    yield resource if block_given?
    respond_with self.resource
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    # if !Chart.all.any?
    #  make_0_chart
    # end
    resource.save
    yield resource if block_given?
 
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
    @charts = Chart.where(users_id: 0)
  # byebug
    if Chart.any?
      make_id_chart
      make_id_datesetting
      init_category
    end
  end

  def edit
    render :edit
  end

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  # DELETE /resource
  def destroy
    # byebug
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_flashing_format?
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    expire_data_after_sign_in!
    redirect_to new_registration_path(resource_name)
  end

    protected

      def update_needs_confirmation?(resource, previous)
        resource.respond_to?(:pending_reconfirmation?) &&
        resource.pending_reconfirmation? &&
        previous != resource.unconfirmed_email
      end

      def update_resource(resource, params)
        resource.update_with_password(params)
      end

      def build_resource(hash=nil)
        self.resource = resource_class.new_with_session(hash || {}, session)
      end

      def sign_up(resource_name, resource)
       sign_in(resource_name, resource)
      end

      def after_sign_up_path_for(resource)
        after_sign_in_path_for(resource)
      end

      def after_inactive_sign_up_path_for(resource)
       scope = Devise::Mapping.find_scope!(resource)
       router_name = Devise.mappings[scope].router_name
       context = router_name ? send(router_name) : self
       context.respond_to?(:root_path) ? context.root_path : "/"
      end

      def after_update_path_for(resource)
       signed_in_root_path(resource)
      end

  # Authenticates the current scope and gets the current resource from the session.
      def authenticate_scope!
       send(:"authenticate_#{resource_name}!", force: true)
       self.resource = send(:"current_#{resource_name}")
      end

      def translation_scope
       'devise.registrations'
      end
  
  # User defined programms
=begin
      def make_0_chart
        file_data = ActionDispatch::Http::UploadedFile("charts.csv")
        # file_data = Rails.root.join('/charts.csv')
        byebug
        if file_data.respond_to?(:read)
          filen = file_data.read
        elsif file_data.respond_to?(:path)
          filen = File.read(file_data.path)
        else
          logger.error "Bad file_data: #{file_data.class.name}: #{file_data.inspect}"
        end
        ssk = Array.new
        rr = filen.split(/\r?\n/)
        i = 0
        while !rr[i].nil?
          ssk[i] = rr[i].split(',')
          i+=1
        end
        rrc = rr.count-1
        @chart = Chart.new
        # ssc = ssk[i].count-1
        for j in 0..rrc

          @chart.glcode= ssk[j].glcode
          @chart.code= ssk[j].code
          @chart.gst= ssk[j].gst
          @chart.header= ssk[j].header
          @chart.content= ssk[j].content
          @chartsn.users_id= 0
        #  byebug
          @chart.save
        end
      end
=end
      def make_id_chart
        @charts = Chart.where(users_id: 0)
      # byebug
        @charts.each do |cc|
          @chartsn = Chart.new
          @chartsn.glcode= cc.glcode
          @chartsn.code= cc.code
          @chartsn.gst= cc.gst
          @chartsn.header= cc.header
          @chartsn.content= cc.content
          @chartsn.users_id= current_user.id
        #  byebug
          @chartsn.save
        end
      end
   
      def make_id_datesetting
        @datest = Datesetting.new
        # byebug
        @datest.users_id = current_user.id
        @datest.startdate = DateTime.now.to_date
        @datest.enddate = DateTime.now.to_date
        @datest.save
      end
  
      def init_category
        @usersf = User.where("id = ?",current_user.id).first
     # byebug
        if @usersf.name == "_Admin2015_"
          @usersf.category = 3
          @usersf.expire_date = Time.now + (156*7*24*60*60)
        else
          @usersf.category = 1
          @usersf.expire_date = Time.now + (1*7*24*60*60)
        end
        @usersf.save
      end
  
      def delete_remains
      
      end

      def sign_up_params
        params.require(:user).permit(:email, :category, :expire_date, :name, :password, :password_confirmation, :current_password)
      end

end #class
