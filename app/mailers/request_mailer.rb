class RequestMailer < ApplicationMailer
  default from: 'info@inverge.us'
  
  
  
  
  def community_invitation(request)
    send_invitation(
      request: request,
      subject: 'You have been invited to join the ' + request.community.name + ' community on inverge!'
    )
  end
  
  
  def community_admin_invitation(request)
    send_invitation(
      request: request,
      subject: 'You have been invited to be an administrator for the ' + request.community.name + ' community on inverge!'
    )
  end
  
  
  def team_invitation(request)
    send_invitation(
      request: request,
      subject: 'You have been invited to join ' + request.team.name + ' on inverge!'
    )
  end
  
  
  
  
  protected
    def send_invitation(hash)
      @request = hash[:request]
      @url     = request_url(@request) + '?email=' + @request.email + '&token=' + @request.token
      mail(
        to:      @request.email,
        subject: hash[:subject]
      )
    end
end
