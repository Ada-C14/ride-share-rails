require "test_helper"

xdescribe HomepagesController do
  it "can get the homepage" do
  get root_path

must_respond_with :success

end
