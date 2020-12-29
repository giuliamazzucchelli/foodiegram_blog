require "selenium-webdriver"
require 'rubygems'
require 'test_helper'
require 'database_cleaner/active_record'


class AdminTest < ActionDispatch::SystemTestCase
    include Devise::Test::IntegrationHelpers

    
    def setup 
        @caps = Selenium::WebDriver::Remote::Capabilities.new
        @caps['desired_capailities'] ='chrome'
        @caps['javascriptEnabled'] = 'true'
        @driver = Selenium::WebDriver.for(:remote, :url => 'http://localhost:9515',:desired_capabilities => @caps)
        @driver.manage.timeouts.implicit_wait = 15

    end



    test "should signup as admin" do

        @driver.navigate.to "http://localhost:3000/admin/signup"

        assert(@driver.find_element(:id, "admin_email").displayed?)
        @driver.find_element(:id, "admin_email").send_keys("appo0po8@example.com")

        assert(@driver.find_element(:id,"admin_password").displayed?)
        @driver.find_element(:id, "admin_password").send_keys("password")

        assert(@driver.find_element(:name, "commit").displayed?)

        @driver.find_element(:name, "commit").click

        assert(@driver.find_element(:xpath, "/html/body/div[3]/div/div[2]/div/div[2]").text.include?("Welcome! You have signed up successfully"))

    end


end