# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# Service.create(name: "X-ray", description: "X-ray services")

sensor = Sensor.create(name: "Battery Voltage", shortname: "battery", unit: "Volts")

device = Device.create(device_name: "TEST_123")

report = Report.create(time_reported: Time.now, device: device)

Reading.create(value: 12.5, sensor: sensor, report: report)