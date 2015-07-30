require 'uri'
require 'httparty'

module LiftmasterMyq
  class System

  	attr_reader :username, :password, :garage_doors, :gateways, 
  		:lights, :security_token, :userId, :cached_login_response

  	@@failed_endpoint_discovery_count = 0
  	
  	def initialize(user, pass)
  		@username = URI.encode(user)
  		@password = URI.encode(pass)
  		login
  		discover_endpoints
  	end

  	def discover_endpoints
  		empty_device_arrays
  		response = request_device_list
  		devices = response["Devices"]
  		devices.each do |device|
 				instantiate_device(device)
  		end
  		if @gateways.size > 0
  			@@failed_endpoint_discovery_count = 0
  			return "endpoint discovery complete"
  		elsif @@failed_endpoint_discovery_count < 3
  			@@failed_endpoint_discovery_count += 1
  			sleep 15
  			login
  			discover_endpoints
  		else
  			raise RuntimeError, "The Liftmaster MyQ API failed to return any devices under your account" 
  		end
  	end

  	def find_door_by_id(id)
  		id = id.to_s
  		@garage_doors.each do |door|
  			return door if door.id == id
  		end
  		nil
    end

    def find_door_by_name(name)
  		@garage_doors.each do |door|
  			return door if door.name == name
  		end
  		nil
    end

  	# private

  	def login_uri
  		uri = "https://#{LiftmasterMyq::HOST_URI}/"
			uri << "#{LiftmasterMyq::LOGIN_ENDPOINT}"
			uri << "?appId=#{LiftmasterMyq::APP_ID}"
			uri << "&securityToken=null"
			uri << "&username=#{@username}"
			uri << "&password=#{@password}"
  		uri << "&culture=#{LiftmasterMyq::LOCALE}"
  	end

  	def device_list_uri
  		uri = "https://#{LiftmasterMyq::HOST_URI}/"
  		uri << "#{LiftmasterMyq::DEVICE_LIST_ENDPOINT}"
  		uri << "?appId=#{LiftmasterMyq::APP_ID}"
  		uri << "&securityToken=#{@security_token}"
  	end

  	def login
  		response = HTTParty.get(login_uri)
  		puts response
  		response = response.parsed_response
  		@userId = response["UserId"]
  		@security_token = response["SecurityToken"]
  		@cached_login_response = response
  		"logged in successfully"
  	end

  	def request_device_list
  		HTTParty.get(device_list_uri).parsed_response
  	end

  	def empty_device_arrays
  		@gateways = []
  		@garage_doors = []
  		@lights = []
  	end

  	def instantiate_device(device)
  			# VGDO = Virtual Garage Door Opener, it's the type for the 
  			# Universal Smartphone Garage Door Controller
  			opener_types = %w(GarageDoorOpener VGDO)
  		 	if opener_types.include?(device["MyQDeviceTypeName"])
  				@garage_doors << LiftmasterMyq::Device::GarageDoor.new(device, self)
  			elsif device["MyQDeviceTypeName"] == "Gateway"
  		 		@gateways << LiftmasterMyq::Device::Gateway.new(device, self)
  			#elsif device["MyQDeviceTypeName"]=="???"
  				# I need a MyQ light switch to implement this feature
  				#@lights << LiftmasterMyq::Device::LightSwitch.new(device)
  			end
  	end

  end
end