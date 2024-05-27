local url = "https://raw.githubusercontent.com/DonealPique/chest-monitor/main/chest_monitor.lua"

print("Downloading chest_monitor.lua...")
local response = http.get(url)

if response then
    local script = response.readAll()
    response.close()
    
    local file = fs.open("/chest_monitor.lua", "w")
    if file then
        file.write(script)
        file.close()
        print("Downloaded and saved as chest_monitor.lua")

        local startupScript = [[
shell.run("/chest_monitor.lua")
]]
        local startupFile = fs.open("/startup.lua", "w")
        if startupFile then
            startupFile.write(startupScript)
            startupFile.close()
            print("Created startup.lua to run chest_monitor.lua at startup")

            print("Installation complete. Rebooting...")
            os.reboot()
        else
            print("Error: Could not create startup.lua. Please check if the file system is writable.")
        end
    else
        print("Error: Could not save chest_monitor.lua. Please check if the file system is writable.")
    end
else
    print("Failed to download chest_monitor.lua. Check the URL and try again.")
end
