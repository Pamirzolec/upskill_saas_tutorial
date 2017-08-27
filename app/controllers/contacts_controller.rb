class ContactsController < ApplicationController
  
  
  # GET request to /contact-us 
  #Show new contact form
def new
  @contact = Contact.new
end

#Post request /contacts 
def create
  #Mass assaigments of form fields into Contact Object
  @contact = Contact.new(contact_params)
  #Save the Contact object to the Database
  if @contact.save
    #Store form fields via paramaters, into viarables
    name = params[:contact][:name]
    email = params[:contact][:email]
    body = params[:contact][:comments]
    #Plug variables into Contact Mailer email method and send email
    flash[:success] = "Message Sent"
    ContactMailer.contact_email(name, email, body).deliver
    #Store success message in flash hash and 
    #redirect to new action
     redirect_to new_contact_path
  else
    #If contact object dosen't save store errors
    #in flash hash and redirect to new action
    flash[:danger] = @contact.errors.full_messages.join(", ")
     redirect_to new_contact_path 
     
  end
end
private
#To collect data from form we need to use
#Strong parametres and whitelist the form fields
  def contact_params
     params.require(:contact).permit(:name, :email, :comments)
  end
    
end
