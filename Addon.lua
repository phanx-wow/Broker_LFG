--[[--------------------------------------------------------------------
	Broker_LFG
	Basic LFG button for your DataBroker display.
	Copyright (c) 2010-2016 Phanx <addons@phanx.net>. All rights reserved.
	https://www.wowinterface.com/downloads/info16710-BrokerLFG.html
	https://www.curseforge.com/wow/addons/broker-lfg
	https://github.com/Phanx/Broker_LFG
----------------------------------------------------------------------]]

local ADDON, L = ...

local actions = {
	{
		text     = L["Click to open the Dungeon Finder."],
		enabled  = function() return UnitLevel("player") >= SHOW_LFD_LEVEL end,
		selected = function(button) return button == "LeftButton" and not IsModifierKeyDown() end,
		func     = function() PVEFrame_ToggleFrame("GroupFinderFrame", LFDParentFrame) end,
	},
	{
		text     = L["Alt-Click to open the Raid Finder."],
		enabled  = function() return UnitLevel("player") >= RAID_FINDER_SHOW_LEVEL end,
		selected = function(button) return button == "LeftButton" and IsAltKeyDown() end,
		func     = function() PVEFrame_ToggleFrame("GroupFinderFrame", RaidFinderFrame) end,
	},
	{
		text     = L["Ctrl-Click to open the Premade Groups window."],
		enabled  = function() return not IsTrialAccount() end,
		selected = function(button) return button == "LeftButton" and IsControlKeyDown() end,
		func     = function() PVEFrame_ToggleFrame("GroupFinderFrame", LFGListPVEStub) end,
	},
	{
		text     = L["Right-Click to open the PVP window."],
		enabled  = function() return UnitLevel("player") >= SHOW_PVP_LEVEL end,
		selected = function(button) return button == "RightButton" end,
		func     = function() TogglePVPUI() end,
	},
	{
		text     = L["Middle-Click or Shift-Click to open the Pet Journal."],
		enabled  = function() return C_PetJournal.IsFindBattleEnabled() and C_PetJournal.IsJournalUnlocked() end,
		selected = function(button) return button == "MiddleButton" or (button == "LeftButton" and IsShiftKeyDown()) end,
		func     = function() ToggleCollectionsJournal(2) end,
	},
}

------------------------------------------------------------------------

for queueType, t in pairs(LFG_EYE_TEXTURES) do
	local cols = floor(t.width / t.iconSize)
	local colWidth = t.iconSize / t.width
	local rowHeight = t.iconSize / t.height

	local iconCoords = { }
	for i = 1, t.frames do
		local L = mod(i - 1, cols) * colWidth
		local R = L + colWidth
		local T = ceil(i / cols) * rowHeight
		local B = T - rowHeight

		iconCoords[i] = { L, R, B, T }
	end
	t.iconCoords = iconCoords
end

------------------------------------------------------------------------

local queueTypes = {
	"dungeon",  -- Dungeon Finder
	"raid",     -- Other Raids
	"raid",     -- Raid Finder
	"scenario", -- Scenarios
	"raid",     -- Flex Raid
	"pvp"       -- World PVP
}

local function GetQueueInfo()
	for i = 1, NUM_LE_LFG_CATEGORYS do -- FFS Blizz, learn to spell.
		local mode, submode = GetLFGMode(i)
		if mode then
			return queueTypes[i], mode, submode, i
		end
	end

	for i = 1, GetMaxBattlefieldID() do
		local status = GetBattlefieldStatus(i)
		if status and status ~= "none" then
			return "pvp", status
		end
	end

	for i = 1, MAX_WORLD_PVP_QUEUES do
		local status = GetWorldPVPQueueStatus(i)
		if status and status ~= "none" then
			return "pvp", status
		end
	end

	local status = C_PetBattles.GetPVPMatchmakingInfo()
	if status then
		return "petbattle", status
	end
end

------------------------------------------------------------------------

local addon = CreateFrame("Frame")

QueueStatusFrame_OnLoad(addon)
addon.StatusEntries = nil

QueueStatusMinimapButton:Hide()
QueueStatusMinimapButton.Show = QueueStatusMinimapButton.Hide

------------------------------------------------------------------------

local function GetScreenHalf()
	local _, y = GetCursorPosition()
	if y * 2 > UIParent:GetHeight() then
		return "TOP"
	else
		return "BOTTOM"
	end
end

addon.feed = LibStub("LibDataBroker-1.1"):NewDataObject("LFG", {
	type = "launcher",
	icon = "Interface\\LFGFrame\\LFG-Eye",
	label = L.LFG,
	iconCoords = LFG_EYE_TEXTURES.default.iconCoords[1],
	OnEnter = function(self)
		if GetQueueInfo() then
			QueueStatusFrame:Show()
			QueueStatusFrame:SetParent(UIParent)
			QueueStatusFrame:SetClampedToScreen(true)
			QueueStatusFrame:SetFrameStrata("TOOLTIP")
			QueueStatusFrame:ClearAllPoints()
			if GetScreenHalf() == "TOP" then
				QueueStatusFrame:SetPoint("TOP", self, "BOTTOM", 0, -5)
			else
				QueueStatusFrame:SetPoint("BOTTOM", self, "TOP", 0, 5)
			end
		else
			local level = UnitLevel("player")
			GameTooltip:SetOwner(self, GetScreenHalf() == "TOP" and "ANCHOR_BOTTOM" or "ANCHOR_TOP")
			GameTooltip:SetText(L["LFG"])
			for i = 1, #actions do
				if actions[i].enabled() then
					GameTooltip:AddLine(actions[i].text, 1, 1, 1)
				end
			end
			GameTooltip:Show()
		end
	end,
	OnLeave = function(self)
		QueueStatusFrame:Hide()
		GameTooltip:Hide()
	end,
	OnClick = function(self, button)
		if button == "RightButton" and GetQueueInfo() and not IsShiftKeyDown() then
			PlaySound(SOUNDKIT.IG_MAINMENU_OPEN)
			local screenHalf = GetScreenHalf()
			QueueStatusMinimapButtonDropDown.point = screenHalf == "TOP" and "TOPLEFT" or "BOTTOMLEFT"
			QueueStatusMinimapButtonDropDown.relativePoint = screenHalf == "TOP" and "BOTTOMLEFT" or "TOPLEFT"
			ToggleDropDownMenu(1, nil, QueueStatusMinimapButtonDropDown, self:GetName() or self, 0, 0)
		else
			for i = 1, #actions do
				local action = actions[i]
				if action.selected(button) then
					if action.enabled() then
						action.func()
					end
					break
				end
			end
		end
	end,
})

------------------------------------------------------------------------

local currentQueueType
local currentFrame = 1

local currentIcon = LFG_EYE_TEXTURES.default
local iconCoords = currentIcon.iconCoords
local updateDelay = currentIcon.delay

local counter = 0
local function UpdateIconCoords(self, elapsed)
	counter = counter + elapsed
	if counter > updateDelay then
		if currentFrame > currentIcon.frames then
			currentFrame = 1
		end
		self.feed.iconCoords = iconCoords[currentFrame] or iconCoords[1]
		currentFrame = currentFrame + 1
		counter = 0
	end
end

addon:SetScript("OnEvent", function(self, event)
	local queueType, queueStatus = GetQueueInfo()

	if queueType and queueStatus ~= "queued" then
		queueType = nil
	end

	if queueType == currentQueueType then
		return
	end

	currentQueueType = queueType

	currentIcon = queueType and LFG_EYE_TEXTURES[queueType] or LFG_EYE_TEXTURES.default
	iconCoords = currentIcon.iconCoords
	updateDelay = currentIcon.delay
	self.feed.icon = currentIcon.file

	if queueType then
		currentFrame = 1
		self:SetScript("OnUpdate", UpdateIconCoords)
	else
		self:SetScript("OnUpdate", nil)
		currentFrame = 1
		self.feed.iconCoords = iconCoords[1]
	end
end)
