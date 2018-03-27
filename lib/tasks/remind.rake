require 'httparty'

desc "Remind users to water their plant"
task :remind  => [ :environment ] do
  User.all.each do |user|
    # get all the device ids we want to send the notifications to
    device_ids = []
    user.pushies.each do |pushy|
      device_ids.push(pushy.token)
    end
    if device_ids.empty?
      next
    end

    # plant names and types to be watered
    # [['Orchid','Bob']...]
    plant_names = []
    user.user_plants.each do |up|
      # If they've never watered a plant before, remind them
      if up.last_watered.nil?
        plant_names.push([up.plant.name, up.nickname])
      # If the last watered date at midnight + # days between waterings is on
      # or before today, the plant needs water --> notify
      elsif up.last_watered + up.water_frequency.days <= Date.today
        plant_names.push([up.plant.name, up.nickname])
      end
    end

    notification = "Time to water your "

    if plant_names.size == 0
      next
    end
    
    # Time to water your Orchid (John)
    if plant_names.size == 1
      notification = notification + plant_names[0][0] + " (" + plant_names[0][1] + ")"
    else
      # Time to water your Orchid (John), Jade (Crystal), and Money Tree (Bob)
      plant_names.each_with_index do |plant_name, i|
        # if it's the last plant, add 'and' and no comma
        if i == plant_names.size - 1
          notification = notification + " and " + plant_name[0] + " (" + plant_name[1] + ")"
        else
        notification = notification + plant_name[0] + " (" + plant_name[1] + "), "
        end
      end
    end
    
    puts notification
    puts device_ids
    req_body = {
      "to": device_ids,
      "data": {
        "title": "Floradorable",
        "message": notification,
        "url": "https://floradorable.demifili.com",
        "image": "https://floradorable.demifili.com/favicon-32x32.png"
      }
    }
    puts req_body
    HTTParty.post("https://api.pushy.me/push?api_key=#{ENV["PUSHY_TOKEN"]}", body: req_body)
  end
end
