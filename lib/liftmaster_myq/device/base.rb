module LiftmasterMyq::Device
  class Base

    attr_reader :id, :name, :myq_id, :myq_name, :parent_system, :cached_hash

    def initialize(device_hash, parent_system)
      @cached_hash = device_hash
      @parent_system = parent_system
      @id = device_hash["DeviceId"]
      device_hash["Attributes"].each do |elem|
        @name = elem["Value"] if elem["Name"] == "desc"
      end
      @myq_id = device_hash["MyQDeviceId"]
      @myq_name = device_hash["DeviceName"]
      @device_type = device_hash["MyQDeviceTypeName"]
    end

  end
end