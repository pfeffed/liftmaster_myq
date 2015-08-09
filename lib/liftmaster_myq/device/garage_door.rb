require 'liftmaster_myq/device'

module LiftmasterMyq::Device
  class GarageDoor < Base

    attr_accessor :gateway

    def initialize(device_hash, parent_system)
      super
      @gateway = device_hash["ParentMyQDeviceId"]
    end

    def open
      change_door_state("open")
    end

    def close
      change_door_state("close")
    end

    def status
      response = check_door_state("doorstate").parsed_response
      state = response["AttributeValue"]
      if state == "1"
        return "open"
      elsif state == "2"
        return "closed"
      elsif state == "3"
        return "stopped"
      elsif state == "4"
        return "opening"
      elsif state == "5"
        return "closing"
      else
        return "#{state} is an unknown state for the door."
      end
    end

    private

    def change_door_state_uri
      uri = "https://#{LiftmasterMyq::HOST_URI}/"
      uri << "#{LiftmasterMyq::DEVICE_SET_ENDPOINT}"
    end

    def check_door_state_uri(command)
      uri = "https://#{LiftmasterMyq::HOST_URI}/"
      uri << "#{LiftmasterMyq::DEVICE_STATUS_ENDPOINT}"
      uri << "?appId=#{LiftmasterMyq::APP_ID}"
      uri << "&securityToken=#{self.parent_system.security_token}"
      uri << "&devId=#{self.id}"
      uri << "&name=#{command}"
    end

    def change_door_state(command)
      open_close_state = command.to_s.downcase == "open" ? 1 : 0
      HTTParty.put(change_door_state_uri,
        :body => {
          :AttributeName  => "desireddoorstate",
          :DeviceId       => self.id,
          :ApplicationId  => LiftmasterMyq::APP_ID,
          :AttributeValue => open_close_state,
          :SecurityToken  => self.parent_system.security_token
        }
      )
    end

    def check_door_state(command)
      uri = check_door_state_uri(command)
      HTTParty.get(uri)
    end

  end
end