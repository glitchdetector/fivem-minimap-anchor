--[[
    MINIMAP ANCHOR BY GLITCHDETECTOR (Feb 16 2018 version)
    Modify and redistribute as you please, just keep the original credits in.
    You're free to distribute this in any project where it's used.
]]

--[[
    Returns a Minimap object with the following details:
    x, y: Top left origin of minimap
    width, height: Size of minimap (not pixels!)
    left_x, right_x: Left and right side of minimap on x axis
    top_y, bottom_y: Top and bottom side of minimap on y axis
]]
function GetMinimapAnchor()
    -- Safezone goes from 1.0 (no gap) to 0.9 (5% gap (1/20))
    -- 0.05 * ((safezone - 0.9) * 10)
    local safezone = GetSafeZoneSize()
    local safezone_x = 1.0 / 20.0
    local safezone_y = 1.0 / 20.0
    local aspect_ratio = GetAspectRatio(0)
    local res_x, res_y = GetActiveScreenResolution()
    local xscale = 1.0 / res_x
    local yscale = 1.0 / res_y
    local Minimap = {}
    Minimap.width = xscale * (res_x / (4 * aspect_ratio))
    Minimap.height = yscale * (res_y / 5.674)
    Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.right_x = Minimap.left_x + Minimap.width
    Minimap.top_y = Minimap.bottom_y - Minimap.height
    Minimap.x = Minimap.left_x
    Minimap.y = Minimap.top_y
    Minimap.xunit = xscale
    Minimap.yunit = yscale
    return Minimap
end

--[[
Calculations I made while researching this:

Resolution: 2560x1440: (16:9 | 1,778)
Minimap: 360x256 = 7,111 x 5,625 (14,063% x 17,778%)
Safezone 0.90 = 128x73 = 20 x 19,726 (5% x 5,069%)
Safezone 0.95 = 64x37 = 40 x 38,919 (2,5% x 2,569%)
Safezone 1.00 = 0x0 = 0 x 0 (0% x 0%)
Minimap width / Aspect ratio = ~4

Resolution: 1280x960: (4:3 | 1,333)
Minimap: 240x170 = 5,333 x 5,647 (18,751% x 17,809%)
Safezone 0.90 = 64x48 = 20 x 20 = (5% x 5%)
Minimap width / Aspect ratio = ~4

Minimap width divided by aspect ratio is always ~4
Minimap height seems to be around ~17,8% of screen height
Safezone seems to be 5% of screen size per -0.10 safezone setting

THIS IS NOT TESTED ON ANYTHING WIDER THAN 16:10
I HAVE ABSOLUTELY NO IDEA WHAT THE NATIVES RETURN ON MULTI MONITOR SETUPS (3*1920 x 1080p etc.)
]]
