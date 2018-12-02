module ActivityHelper
  def record_activity (req, item)
    raise "record_activity: Argument 1 must be instance of 'ActionDispatch::Request'" unless req.kind_of?(ActionDispatch::Request)

    if !item.nil?
      raise "record_activity: Argument 2 must be instance of 'ApplicationRecord'" unless item.kind_of?(ApplicationRecord)
    end

    Activity.create(
      ip_address: request.remote_ip,
      user_agent: request.env['HTTP_USER_AGENT'],
      class_name: item.nil? ? nil : item.class.name,
      object_id: item.nil? ? nil : item.id
    )
  end
end
