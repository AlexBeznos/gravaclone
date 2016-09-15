class PagesController < ApplicationController
  def show
    path = File.join(Rails.root, "#{params[:name]}.md")
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    render inline: @markdown.render(File.read(path)), layout: 'application'
  end
end
