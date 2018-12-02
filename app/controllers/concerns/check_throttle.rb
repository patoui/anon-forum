class CheckThrottle
  def self.before(controller)
    activityCount = Activity.where(ip_address: controller.request.remote_ip)
      .where(created_at: (Time.now.ago(300))..Time.now)
      .count

    if activityCount >= 5
      controller.flash[:error] = "You've exhausted your activity limit."
      controller.redirect_to action: 'index' and return
    end
  end
end
