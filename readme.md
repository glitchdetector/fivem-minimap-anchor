## Minimap Anchor
This is a utility script for FiveM that can calculate the position of the minimap.
Clashing aspect ratios and safe-zone settings are no longer an issue!

## How to use:
Add the **"MINIANCHOR.lua"** file to your resource.
Add **client_script 'MINIANCHOR.lua'** to your \_\_resouce.lua file **before** the script that uses this.
Honestly if you don't know how to add a script like this, you will most likely not have a use for it.

## Features:
Function **GetMinimapAnchor()** which returns an object with the following entries:

Key | Description
--- | ---
**x** / **left_x** | The X position of the left side of the minimap.
**y** / **top_y** | The Y position of the top side of the minimap.
**width** | The width of the minimap.
**height** | The height of the minimap.
**xunit, yunit** | Base units that should be the same for every screen. Use these for pixel measurement.
**right_x** | The X position of the right side of the minimap. *(Shortcut for x + width)*
**bottom_y** | The Y position of the bottom side of the minimap. *(Shortcut for y + height)*

*Note that all of the values returned are in a range of 0.0 to 1.0*

## Example use:

This code example will draw a black border along the inner edge of the minimap.
```lua
function drawRct(x, y, width, height, r, g, b, a)
    DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local ui = GetMinimapAnchor()
        local thickness = 4 -- Defines how many pixels wide the border is
        drawRct(ui.x, ui.y, ui.width, thickness * ui.yunit, 0, 0, 0, 255)
        drawRct(ui.x, ui.y + ui.height, ui.width, -thickness * ui.yunit, 0, 0, 0, 255)
        drawRct(ui.x, ui.y, thickness * ui.xunit, ui.height, 0, 0, 0, 255)
        drawRct(ui.x + ui.width, ui.y, -thickness * ui.xunit, ui.height, 0, 0, 0, 255)
    end
end)
```
### Result:
![Bordered Minimap](https://i.imgur.com/c4em9KG.png "Bordered Minimap")
