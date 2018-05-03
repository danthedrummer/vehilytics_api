# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# Service.create(name: "X-ray", description: "X-ray services")

# sensor = Sensor.create(name: "Battery Voltage", shortname: "battery", unit: "Volts")
# device = Device.create(device_name: "TEST_123")
# report = Report.create(time_reported: Time.now, device: device)
# Reading.create(value: 12.5, sensor: sensor, report: report)

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

# Seeding users
dan = User.create(email: "dan@example.com", password: "password", password_confirmation: "password")
paul = User.create(email: "paul@example.com", password: "password", password_confirmation: "password")

# Seeding devices
Device.create(email: "device_test_123@vehilytics.com", device_name: "TEST_123", user: dan, password: "device_pass", password_confirmation: "device_pass")
Device.create(email: "device_test_789@vehilytics.com", device_name: "TEST_789", user: paul, password: "device_pass", password_confirmation: "device_pass")

fuel_sensor = Sensor.find_by_shortname("fuel_level")
battery_sensor = Sensor.find_by_shortname("control_module_voltage")
air_temp_sensor = Sensor.find_by_shortname("ambient_air_temp")

dan.sensors << fuel_sensor << battery_sensor
paul.sensors << fuel_sensor << air_temp_sensor

# Seeding reports for dan
rep = Report.create(device: dan.device, time_reported: Time.now)

Reading.create(sensor: fuel_sensor, value: "40", report: rep)
dan.device.sensors << fuel_sensor
Reading.create(sensor: battery_sensor, value: "12.5", report: rep)
dan.device.sensors << battery_sensor

# Seeding reports for paul
rep = Report.create(device: paul.device, time_reported: Time.now)

Reading.create(sensor: fuel_sensor, value: "60", report: rep)
paul.device.sensors << fuel_sensor
Reading.create(sensor: air_temp_sensor, value: "9.3", report: rep)
paul.device.sensors << air_temp_sensor