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

local AceGUI = LibStub("AceGUI-3.0") -- TODO: meh

local usedFrames = {}
local minimizedGroups = {} -- Groups that are minimized -> Default is shown (for all Groups that don't have an entry here)
local trackedTasks = {} -- Similar to the default Quest tracker, mark tasks to show their objectives (toggled by clicking on their name) -> Default is hide (for all Tasks that don't have an entry here)

local function ReleaseAllChildren(self)
end
--- Clears the Tracker and displays some info text so it isn't entirely blank
local function ClearGroups(self)
end
--- Adds all tasks of the given Group to the tracker
-- Also adds all nested Groups (and their Tasks) -> Up to a limit of X levels? (TODO)
local function AddGroup(self, Group)
end

local function UpdateGroups(self)
end
local TrackerPane = {

	usedFrames = usedFrames,
	Create = Create,

	UpdateGroups = UpdateGroups,
	ClearGroups = ClearGroups,
	
	ReleaseAllChildren = ReleaseAllChildren,
	
	-- TODO
	AddGroup = AddGroup,
	MinimizeGroup = MinimizeGroup,
	MaximizeGroup = MaximizeGroup,
	RemoveGroup = RemoveGroup,
	MoveGroup = MoveGroup,
	ShowObjectives = ShowObjectives, -- TrackTask / UntrackTask?
	HideObjectives = HideObjectives,
	-- Needs a table to keep currently used group frames etc in?
}

AM.TrackerPane = TrackerPane

return AM
