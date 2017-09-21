  -- ----------------------------------------------------------------------------------------------------------------------
    -- -- This program is free software: you can redistribute it and/or modify
    -- -- it under the terms of the GNU General Public License as published by
    -- -- the Free Software Foundation, either version 3 of the License, or
    -- -- (at your option) any later version.
	
    -- -- This program is distributed in the hope that it will be useful,
    -- -- but WITHOUT ANY WARRANTY; without even the implied warranty of
    -- -- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    -- -- GNU General Public License for more details.

    -- -- You should have received a copy of the GNU General Public License
    -- -- along with this program.  If not, see <http://www.gnu.org/licenses/>.
-- ----------------------------------------------------------------------------------------------------------------------

local addonName, AM = ...
if not AM then return end


--- Table containing the default task entries
local defaults = {
	
	display = {
		
		activeStyle = "Default",
		groupSize = 40,
		taskSize = 32,
		objectiveSize = 24,
		iconSize = 20,
		
	}
	
}


--- Return the table containing default task entries
function GetDefaultSettings()
	return defaults
end


AM.Settings.GetDefaultSettings = GetDefaultSettings


return AM