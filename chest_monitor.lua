local function centerText(monitor, text, y)
    local width, height = monitor.getSize()
    local x = math.floor((width - #text) / 2) + 1
    monitor.setCursorPos(x, y)
    monitor.write(text)
end

local function printInventoryOnMonitor(chest, monitor)
    monitor.clear()
    local items = chest.list()

    local width, height = monitor.getSize()
    local startY = math.floor((height - (#items * 2)) / 2) + 1

    local y = startY
    for slot, item in pairs(items) do
        local itemName = item.name:gsub("minecraft:", "")
        centerText(monitor, itemName, y)
        y = y + 1
        monitor.setTextColor(colors.gray)
        centerText(monitor, tostring(item.count) .. "x", y)
        monitor.setTextColor(colors.white)
        y = y + 1
    end
end

while true do
    local monitor = peripheral.find("monitor")
    local chest = peripheral.find("minecraft:chest")

    if monitor and chest then
        printInventoryOnMonitor(chest, monitor)
    else
        print("Error: Monitor or Chest not found")
        sleep(1)
    end

    sleep(10)
end
