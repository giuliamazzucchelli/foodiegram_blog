require "selenium-webdriver"
require 'rubygems'

class UsersIntegrationTest < ActionDispatch::IntegrationTest

setup do
    @caps = Selenium::WebDriver::Remote::Capabilities.new
    @caps['desired_capailities'] ='chrome'
    @caps['javascriptEnabled'] = 'true'
    @driver = Selenium::WebDriver.for(:remote, :url => 'http://localhost:9515',:desired_capabilities => @caps)
    @driver.manage.timeouts.implicit_wait = 15

end

teardown do

    @driver.quit

end

    test "should signin and edit then logout" do
        @driver.navigate.to "http://localhost:3000/users/sign_in"

        assert(@driver.find_element(:id, "user_email").displayed?)
        @driver.find_element(:id, "user_email").send_keys("user18@example.com")
    
        assert(@driver.find_element(:id,"user_password").displayed?)
        @driver.find_element(:id, "user_password").send_keys("password")
    
        assert(@driver.find_element(:name, "commit").displayed?)

        @driver.find_element(:name, "commit").click
        
        #verifico feedback successo
        assert(@driver.find_element(:xpath, "").text.include?("Signed in successfully"))

        assert(@driver.find_element(:id,"navbarDropdown-user").displayed?)
        @driver.find_element(:id,"navbarDropdown-user").click
        assert(@driver.find_element(:id,"dropdown-editprofile").displayed?)
        @driver.find_element(:id,"dropdown-editprofile").click

        assert(@driver.find_element(:xpath,"//*[@id='user_avatar']").displayed?)

        @driver.find_element(:xpath,"//*[@id='user_avatar']").send_keys("C:/Users/fabio/Downloads/avatar_test.jpg")
        assert(@driver.find_element(:xpath,"//*[@id='user_bio']").displayed?)
        @driver.find_element(:xpath,"//*[@id='user_bio']").send_keys("Hello foodies!")

        #commit

        assert(@driver.find_element(:xpath,"").displayed?)
        @driver.find_element(:xpath,"").click

        #verifico feedback successo
        assert(@driver.find_element(:xpath, "").text.include?("Your account information was successfully updated"))

        assert(@driver.find_element(:id,"navbarDropdown-user").displayed?)
        @driver.find_element(:id,"navbarDropdown-user").click
        assert(@driver.find_element(:id,"dropdown-logout").displayed?)
        @driver.find_element(:id,"dropdown-logout").click
        
        #verifico feedback successo
        assert(@driver.find_element(:xpath, "").text.include?("Signed out successfully."))


    end

    test "should signup and logout" do
        @driver.navigate.to "http://localhost:3000/users/sign_up"

        #compilo form
        assert(@driver.find_element(:id, "user_email").displayed?)
        @driver.find_element(:id, "user_email").send_keys("food11@example.com")
    
        assert(@driver.find_element(:id,"user_password").displayed?)
        @driver.find_element(:id, "user_password").send_keys("password")

        assert(@driver.find_element(:id,"user_password_confirmation").displayed?)
        @driver.find_element(:id, "user_password_confirmation").send_keys("password")

        assert(@driver.find_element(:id,"user_username").displayed?)
        @driver.find_element(:id, "user_username").send_keys("VeganCooking")


        assert(@driver.find_element(:name, "commit").displayed?)

        @driver.find_element(:name, "commit").click
   
        assert(@driver.find_element(:xpath, "").text.include?("Welcome! You have signed up successfully"))

        assert(@driver.find_element(:id,"navbarDropdown-user").displayed?)
        @driver.find_element(:id,"navbarDropdown-user").click
        assert(@driver.find_element(:id,"dropdown-logout").displayed?)
        @driver.find_element(:id,"dropdown-logout").click

        #verifico feedback successo
        assert(@driver.find_element(:xpath, "").text.include?("Signed out successfully."))
   


    end

    test "should visit index and a profile" do
        
        #verifico presenza pulsante food blooger su nav bar

        assert(@driver.find_element(:id,"nav-bloggers").displayed?)

        @driver.find_element(:id,"nav-bloggers").click

        #verifico presenza h1 food bloggers

        assert(@driver.find_element(:xpath,"").displayed?)

        #clicco sul primo nome e verifico di arrivare su profilo utente

        test = @driver.find_element(:xpath,"").text

        @driver.find_element(:xpath,"").click

        assert(@driver.find_element(:xpath,"").text.include?(test ++ "'s profile"))


    end


end