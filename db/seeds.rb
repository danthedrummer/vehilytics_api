# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

# Creating sensors
# Sensor.create(name: "", shortname: "", unit: "")
# Sensor.create(name: "Calculated Load Value", shortname: "load", unit: "%")
Sensor.create(name: "Coolant Temperature", shortname: "temp", unit: "C")
# Sensor.create(name: "Fuel Rail Pressure", shortname: "fuel_pressure", unit: "kPa")
# Sensor.create(name: "Intake manifold Pressure", shortname: "manifold_pressure", unit: "kPa")
Sensor.create(name: "Engine RPM", shortname: "rpm", unit: "rpm")
Sensor.create(name: "Vehicle Speed", shortname: "speed", unit: "km/h")
# Sensor.create(name: "Timing Advance", shortname: "timing_advance", unit: "degrees")
Sensor.create(name: "Intake Air Temp", shortname: "intake_air_temp", unit: "C")
Sensor.create(name: "Air Flow Rate", shortname: "maf", unit: "g/s")
# Sensor.create(name: "Throttle Position", shortname: "throttle_pos", unit: "%")
# Sensor.create(name: "Time Since Engine Start", shortname: "engine_time", unit: "min")
# Sensor.create(name: "Distance w/ MIL on", shortname: "distance_w_mil", unit: "km")
# Sensor.create(name: "Fuel Rail Pressure (VAC)", shortname: "fuel_rail_pressure_vac", unit: "kPa")
# Sensor.create(name: "Fuel Rail Pressure DI", shortname: "fuel_rail_pressure_direct", unit: "kPa")
# Sensor.create(name: "Commanded EGR", shortname: "commanded_egr", unit: "%")
# Sensor.create(name: "EGR error", shortname: "egr_error", unit: "%")
# Sensor.create(name: "Commanded evap purge", shortname: "evaporative_purge", unit: "%")
Sensor.create(name: "Fuel Level Input", shortname: "fuel_level", unit: "%")
# Sensor.create(name: "Warm-ups Since Codes CLD", shortname: "warmups_since_dtc_clear", unit: "")
# Sensor.create(name: "Distance Since Codes CLD", shortname: "distance_since_dtc_clear", unit: "km")
# Sensor.create(name: "Evap. System Vapor Pres", shortname: "evap_vapor_pressure", unit: "Pa")
# Sensor.create(name: "Barometric pressure", shortname: "barometric_pressure", unit: "kPa")
Sensor.create(name: "Control Module Voltage", shortname: "control_module_voltage", unit: "V")
# Sensor.create(name: "Absolute Load Value", shortname: "absolute_load", unit: "%")
# Sensor.create(name: "Command Equivalence Ratio", shortname: "command_equiv_ratio", unit: "")
# Sensor.create(name: "Relative Throttle Pos", shortname: "relative_throttle_pos", unit: "%")
Sensor.create(name: "Ambient Air Temperature", shortname: "ambient_air_temp", unit: "C")
# Sensor.create(name: "Absolute Throttle Pos B", shortname: "throttle_pos_b", unit: "%")
# Sensor.create(name: "Absolute Throttle Pos C", shortname: "throttle_pos_c", unit: "%")
# Sensor.create(name: "Absolute Throttle Pos D", shortname: "throttle_pos_d", unit: "%")
# Sensor.create(name: "Absolute Throttle Pos E", shortname: "throttle_pos_e", unit: "%")
# Sensor.create(name: "Absolute Throttle Pos F", shortname: "throttle_pos_f", unit: "%")
# Sensor.create(name: "Commanded Throttle Actuator", shortname: "throttle_actuator", unit: "%")
# Sensor.create(name: "Time run with MIL on", shortname: "run_time_mil", unit: "min")
# Sensor.create(name: "Time since trb cds cld", shortname: "time_since_dtc_cleared", unit: "min")
# Sensor.create(name: "Max Val eqRat, O2, InPre", shortname: "max_values", unit: "na, V, mA, kPa")
# Sensor.create(name: "Max Vals mass air flow", shortname: "max_maf", unit: "g/s, g/s, g/s, g/s")
# Sensor.create(name: "Fuel Type", shortname: "fuel_type", unit: "")
# Sensor.create(name: "Ethanol Fuel", shortname: "ethanol_percent", unit: "%")
Sensor.create(name: "Absolute Vapor Pres", shortname: "evap_vapor_pressure_abs", unit: "kPa")
# Sensor.create(name: "Evap Vapor Pres", shortname: "evap_vapor_pressure_alt", unit: "Pa")
# Sensor.create(name: "Fuel Rail Pressure (absolute)", shortname: "fuel_rail_pressure_abs", unit: "kPa")
# Sensor.create(name: "Hybrid battery pack remaining life", shortname: "hybrid_battery_remaining", unit: "%")
Sensor.create(name: "Engine oil temperature", shortname: "oil_temp", unit: "C")
# Sensor.create(name: "Fuel injection timing", shortname: "fuel_inject_timing", unit: "degrees")
Sensor.create(name: "Engine fuel rate", shortname: "fuel_rate", unit: "L/h")

# Seeding reminders
Reminder.create("Check Tyres", 4, "Check the pressure in your tyres and the amount of tread.")
Reminder.create("Check Fluids", 26, "Check the engine coolant, transmission fluid, and brake fluid. Watch the level and cleanliness of the fluid.")
Reminder.create("Check Battery", 13, "Check the current charge level of the battery and clean the contacts if necessary.")
Reminder.create("Change Engine Air Filter", 52, "Change the engine air filter if it is dirty. This may not be necessary if the car is not driven often.")
Reminder.create("Have Tyres Balanced", 26, "Have your tyres balanced and rotated to increase the life of your tyres.")
Reminder.create("Change Spark Plugs", 156, "Change out your spark plugs to improve the efficiency of your engine.")
Reminder.create("Inspect Timing Belts", 208, "Have the timing and serpentine belts inspected and replaced if necessary.")

# Seeding devices
(0..10).each do |x|
  Device.create(email: "device_test_#{x}@vehilytics.com", device_name: "TEST_#{x}", password: "device_pass", password_confirmation: "device_pass")
end

# Seeding users
dan = User.create(email: "dan@example.com", password: "password", password_confirmation: "password", device: Device.find(1))
paul = User.create(email: "paul@example.com", password: "password", password_confirmation: "password", device: Device.find(2))

@fuel_sensor = Sensor.find_by_shortname("fuel_level")
@battery_sensor = Sensor.find_by_shortname("control_module_voltage")
@air_temp_sensor = Sensor.find_by_shortname("ambient_air_temp")
@coolant_temp_sensor = Sensor.find_by_shortname("temp")

dan.sensors << @fuel_sensor << @battery_sensor << @coolant_temp_sensor
paul.sensors << @fuel_sensor << @air_temp_sensor

def generate_reports(user)
  reports = []
  days = 1 
  hours = 13
  minutes = 0
  (0..100).each do
    reports << Report.create(device: user.device, time_reported: Time.new(2018, 5, days, hours, minutes))
    minutes += 10
    if minutes == 60
      minutes = 0
      hours += 1
    end
    if hours == 15
      hours = 17
    elsif hours == 18
      hours = 13
      days += 1
    end
  end
end

def generate_fuel_level_readings(reports)
  fuel_level = 60
  reports.each do |report|
    Reading.create(sensor: @fuel_sensor, value: fuel_level.to_s, report: report)
    fuel_level -= 5
    if fuel_level == 15
      fuel_level = 60
    end
  end
end

def generate_battery_level_readings(reports)
  battery_level = 12.7
  reports.each do |report|
    Reading.create(sensor: @battery_sensor, value: sprintf('%.2f', battery_level), report: report)
    if rand() < 0.5
      battery_level = 12.7 - (rand()/2)
    else
      battery_level = 12.7 + (rand()/2)
    end
  end
end

def generate_coolant_temp_readings(reports)
  coolant_temp = 30.0
  hour = 13
  reports.each do |report|
    if report.time_reported.hour - hour > 1
      coolant_temp = 30.0
    end
    Reading.create(sensor: @coolant_temp_sensor, value: sprintf('%.2f', coolant_temp), report: report)
    coolant_temp += rand()*10
    hour = report.time_reported.hour
  end
end

def generate_air_temp_readings(reports)
  air_temp = 15
  hour = 13
  reports.each do |report|
    if report.time_reported.hour - hour > 1
      air_temp = report.time_reported.hour >= 17 ? 10 : 15
    end
    Reading.create(sensor: @air_temp_sensor, value: sprintf('%.2f', air_temp), report: report)
    air_temp += rand() > 0.5 ? (rand()*1) : (rand()*-1)
    hour = report.time_reported.hour
  end
end

# Seeding reports for dan
generate_reports(dan)

generate_fuel_level_readings(dan.device.reports)
generate_battery_level_readings(dan.device.reports)
generate_coolant_temp_readings(dan.device.reports)

dan.device.sensors << @fuel_sensor
dan.device.sensors << @battery_sensor
dan.device.sensors << @coolant_temp_sensor

# Seeding reports for paul
generate_reports(paul)

generate_fuel_level_readings(paul.device.reports)
generate_air_temp_readings(paul.device.reports)

paul.device.sensors << @fuel_sensor
paul.device.sensors << @air_temp_sensor