local url = "https://raw.githubusercontent.com/DonealPique/chest-monitor/main/chest_monitor.lua"

print("Downloading chest_monitor.lua...")
local response = http.get(url)
if response then
    local script = response.readAll()
    response.close()

    local file = fs.open("chest_monitor.lua", "w")
    file.write(script)
    file.close()
    print("Downloaded and saved as chest_monitor.lua")

    local startupScript = [[
    shell.run("chest_monitor.lua")
    ]]
    local startupFile = fs.open("startup.lua", "w")
    startupFile.write(startupScript)
    startupFile.close()
    print("Created startup.lua to run chest_monitor.lua at startup")

    print("Installation complete. Rebooting...")
    os.reboot()
else
    print("Failed to download chest_monitor.lua. Check the URL and try again.")
end
