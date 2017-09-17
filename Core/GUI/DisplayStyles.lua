  ----------------------------------------------------------------------------------------------------------------------
    -- This program is free software: you can redistribute it and/or modify
    -- it under the terms of the GNU General Public License as published by
    -- the Free Software Foundation, either version 3 of the License, or
    -- (at your option) any later version.

    -- This program is distributed in the hope that it will be useful,
    -- but WITHOUT ANY WARRANTY; without even the implied warranty of
    -- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    -- GNU General Public License for more details.

    -- You should have received a copy of the GNU General Public License
    -- along with this program.  If not, see <http://www.gnu.org/licenses/>.
---------------

local addonName, AM = ...
if not AM then return end

-- TODO: Try different fonts to see which works best and use those for the default style (after key features are done)
-- TODO: Recognize fonts from LibSharedMedia3-.0? (allow user to pick them for custom styles)
 
 
 
-- HexToRGB() Taken from TotalAP's Utils module (already tested for robustness, but not useful enough to be its own library)
-- TODO: Move to Utils; new param
--- Translates HTML colour codes to RGB values
-- @param hexString A string representing a colour code in hexadecimal/HTML notation (the leading '#' symbol is optional)
-- @return Red value; 0 if invalid string was given
-- @return Green value; 0 if invalid string was given
-- @return Blue value; 0 if invalid string was given
-- @usage HexToRGB("#FFFEFD") -> { 255, 254, 253 }
-- @usage HexToRGB("FFFEFD") -> { 255, 254, 253 }
-- @usage HexToRGB("asdf") -> { 0, 0, 0 }
local function HexToRGB(hexString, divisor)
	
	local R = { 0, 0, 0 } -- This is used for invalid parameters and as a default value

	if not hexString or type(hexString) ~= "string" then return R end

	local r, g, b = hexString:match("^#?(%x%x)(%x%x)(%x%x)$")
	
	if not (r and g and b) then return R end
	
	return tonumber("0x" .. r) / divisor or 1, tonumber("0x" .. g) / divisor or 1, tonumber("0x" .. b) / divisor or 1
	
end


 
-- Default style for the display (TODO: It's the only one, as others are NYI)
local defaultStyle = {
	
	fonts = {
		
		headers = "Fonts\\ARIAL.TTF",  -- For group headers
		text = "Interface\\Addons\\AltMastery\\Media\\Ubuntu-C.ttf", -- For most regular text
		code = "Fonts\\ARIAL.TTF", -- For the criteria/code editor (TODO: Pick a different one)
		
	},
	
	fontSizes = {
	
		small = 11,
		medium = 11,
		normal = 12,
		large = 16,
	
	},
	
	fontColours = {
	
		completed = "#00FF00", -- bright green - completed/confirmation
		incomplete = "#FF2020", -- red - incomplete/invalid/error
	
	},
	
	frameColours = {
	-- TODO: Borders and inline elements/widgets
	
		-- TODO: Not sure which looks best in the final design (check FrameXML colours also)
		-- TODO: Hex2RGB from TAP/Utils (already tested)
		test1 = "#828296", -- blue-ish grey
		test2 = "#55B408", -- "Legion-like" green (but brighter)
		Window = { backdrop = "#1A1A1A", border = "#9398A1", alpha = 0.9}, -- Identical style for all top-level windows
		test4 = "#666666", -- grey (IT button bg)
		test5 = "#4D4D4D", -- dark grey (IT scrollbar bg)
		test6 = "#404040", -- dark grey (IT active button bg)
		test7 = "#E6CC80", -- artifact colour
		
	},
	
	edgeSize = 1.5,
	
}

}


-- Update all stored display styles with their most current value (in case the user has changed it)
-- TODO: Only relevant later, as the default style is static and cannot be changed by the user
local function UpdateStyles()

	AM.GUI.Styles.Default = defaultStyle
	
	--TODO: <Update user-edited styles from AceConfig here>

end

--- Retrieves the currently active style (TODO; Right now, this is always the default style)
-- @return A table containing styling info that can be applied to the display
local function GetActiveStyle(self)

	-- Update styles in case the user edited them in the meantime (TODO: NYI)
	self:UpdateStyles()

	local style = AM.db.profile.settings.display.activeStyle or AM.GUI:GetDefaultSettings().display.activeStyle
	return AM.GUI.Styles[style] or defaultStyle
	
end

-- Sets the backdrop (and border) colour(s) for a given frame or texture
-- @param frameObject A reference to the frame object
-- @colours A table containing the frame colours in hexadecimal #rrggbb representation (HTML style)
local function SetFrameColour(self, frameObject, colours)

	local backdrop = { HexToRGB(colours.backdrop, 255) }
	tinsert(backdrop, colours.alpha)
	
	if not frameObject then return colours end
	
	local edgeSize = AM.GUI:GetActiveStyle().edgeSize
	
	if frameObject:IsObjectType("Frame") then -- Set backdrop via Frame API
		frameObject:SetBackdrop({bgFile="Interface\\Buttons\\WHITE8X8", edgeFile="Interface\\Buttons\\WHITE8X8", edgeSize = edgeSize}) 
		frameObject:SetBackdropColor(unpack(backdrop)) -- TODO: alpha?
		
		if colours.border then -- Set border (this is optional)
			local border = { HexToRGB(colours.border, 255) }
			frameObject:SetBackdropBorderColor(unpack(border))
		end
		
	else -- Frame is texture -> Set backdrop by simply colouring it differently
		frameObject:SetColorTexture(backdrop) -- TODO: Not currently used anywhere? (No textures exist)
	end
	
end


AM.GUI.GetActiveStyle = GetActiveStyle
AM.GUI.UpdateStyles = UpdateStyles

AM.GUI.SetFrameColour = SetFrameColour

return AM