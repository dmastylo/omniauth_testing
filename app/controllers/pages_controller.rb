class PagesController < ApplicationController

  def index
    if current_user
      @api = LinkedIn::API.new(current_user.identities.first.token)
      puts @api.connections
      # @zb = @api.profile(id: "14287316")
      @job_titles = @api.profile(fields: ["id", {"positions" => ["title"]}])

      puts @job_titles
    end
  end

end
