--[[------------------------------------------------------
	Broker_LFG
	DataBroker clone of the default UI's LFG button.
	Written by Phanx <addons@phanx.net>
	See the accompanying README file for more information.
	http://www.wowinterface.com/downloads/info16710-BrokerLFG.html
	http://www.curse.com/addons/wow/broker-lfg

	Copyright © 2010–2012 Phanx
	I, the copyright holder of this work, hereby release it into the public
	domain. This applies worldwide. In case this is not legally possible: I
	grant anyone the right to use this work for any purpose, without any
	conditions, unless such conditions are required by law.
----------------------------------------------------------------------]]

local LFG = "LFG"
local CLICK_TOGGLE_DUNGEONS = "Click to toggle the Dungeon Finder window."
local CLICK_TOGGLE_RAIDS = "Right-click to toggle the Raid Browser window."
local CLICK_TOGGLE_SCENARIOS = "Middle-click or shift-click to toggle the Scenarios window."

local locale = GetLocale()
if locale == "deDE" then
	LFG = "SNG"
	CLICK_TOGGLE_DUNGEONS = "Klicken, um Dungeonbrowser aktivieren."
	CLICK_TOGGLE_RAIDS = "Rechtsklicken, um Schlachtzugsbrowser aktivieren."
	CLICK_TOGGLE_SCENARIOS = "Mittleren klicken oder Shift-klicken, um Szenarienfenster aktivieren."
elseif locale == "esES" or locale == "esMX" then
	LFG = "BDG"
	CLICK_TOGGLE_DUNGEONS = "Haz clic para mostrar/ocultar el panel Buscador de calabozos."
	CLICK_TOGGLE_RAIDS = "Haz clic derecho para mostrar/ocultar el panel Buscador de bandas."
	CLICK_TOGGLE_SCENARIOS = "Haz clic media o Mayús+clic para mostrar/ocultar el panel Gestas"
elseif locale == "frFR" then
	LFG = "RdG"
	CLICK_TOGGLE_DUNGEONS = "Cliquer pour afficher/fermer la fenêtre Donjons."
	CLICK_TOGGLE_RAIDS = "Clic droit pour afficher/fermer la la fenêtre Raids."
	CLICK_TOGGLE_SCENARIOS = "Clic milieu ou clic-maj pour afficher/fermer la fenêtre Scénarios."
elseif locale == "itIT" then
--	LFG = ""
--	CLICK_TOGGLE_DUNGEONS = ""
--	CLICK_TOGGLE_RAIDS = ""
--	CLICK_TOGGLE_SCENARIOS = ""
elseif locale == "ptBR" then
--	LFG = ""
	CLICK_TOGGLE_DUNGEONS = "Clique para mostrar/ocultar o painel localizador de masmorras."
	CLICK_TOGGLE_RAIDS = "Clique com o botão direito do mouse para mostrar/ocultar o painel localizador de raides"
--	CLICK_TOGGLE_SCENARIOS = ""
elseif locale == "ruRU" then
	LFG = "ЛФГ"
	CLICK_TOGGLE_DUNGEONS = "Щелкните, чтобы открыть окно поиска подземелий."
	CLICK_TOGGLE_RAIDS = "Щелкните правой кнопкой мыши, чтобы открыть список рейдов."
--	CLICK_TOGGLE_SCENARIOS = ""
elseif locale == "koKR" then
--	LFG = ""
--	CLICK_TOGGLE_DUNGEONS = ""
--	CLICK_TOGGLE_RAIDS = ""
--	CLICK_TOGGLE_SCENARIOS = ""
elseif locale == "zhCN" then -- Last updated 2011-03-04 by tss1398383123 @ CurseForge
--	LFG = ""
	CLICK_TOGGLE_DUNGEONS = "左键点击进入FB工具窗口。"
	CLICK_TOGGLE_RAIDS = "右键点击进入团队浏览器窗口。"
--	CLICK_TOGGLE_SCENARIOS = ""
elseif locale == "zhTW" then
--	LFG = ""
--	CLICK_TOGGLE_DUNGEONS = ""
--	CLICK_TOGGLE_RAIDS = ""
--	CLICK_TOGGLE_SCENARIOS = ""
end

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

-- see LFG_CATEGORY_NAMES in Constants.lua
local queueType = {
	"dungeon",	-- Dungeon Finder
	"raid",		-- Other Raids
	"raid",		-- Raid Finder
	"scenario"	-- Scenarios
}

local queueFrames = {
	LFDParentFrame,
	RaidFinderFrame,
	RaidFinderFrame,
	ScenarioFinderFrame
}

-- see QueueStatusFrame_Update in QueueStatusFrame.lua
local function GetQueueInfo()
	for i = 1, NUM_LE_LFG_CATEGORYS do -- FFS Blizz, learn to spell.
		local mode, submode = GetLFGMode(i)
		if mode then
			return queueType[i], mode, submode
		end
	end

	for i = 1, GetMaxBattlefieldID() do
		local status = GetBattlefieldStatus(i)
		if status == "queued" then
			return "pvp", "queued"
		end
	end

	for i = 1, MAX_WORLD_PVP_QUEUES do
		lcoal status = GetWorldPVPQueueStatus(i)
		if status == "queued" then
			return "pvp", "queued"
		end
	end
end

------------------------------------------------------------------------

local function GetScreenHalf()
	local _, y = GetCursorPosition()
	if y * 2 > UIParent:GetHeight() then
		return "TOP"
	else
		return "BOTTOM"
	end
end

------------------------------------------------------------------------

local BrokerLFG = CreateFrame("Frame")

BrokerLFG.feed = LibStub("LibDataBroker-1.1"):NewDataObject("LFG", {
	type = "launcher",
	icon = "Interface\\LFGFrame\\LFG-Eye",
	label = LFG,
	iconCoords = LFG_EYE_TEXTURES.default.iconCoords[1],
	OnClick = function(self, button)
		local queueType, mode, submode = GetQueueInfo()
		if mode then
			if button == "RightButton" or mode == "lfgparty" or mode == "abandonedInDungeon" then
				PlaySound("igMainMenuOpen")
				local screenHalf = GetScreenHalf()
				MiniMapLFGFrameDropDown.point = screenHalf == "TOP" and "TOPLEFT" or "BOTTOMLEFT"
				MiniMapLFGFrameDropDown.relativePoint = screenHalf == "TOP" and "BOTTOMLEFT" or "TOPLEFT"
				ToggleDropDownMenu(1, nil, QueueStatusMinimapButtonDropDown, self:GetName() or self, 0, 0)
			else
				PVEFrame_ToggleFrame("GroupFinderFrame", queueFrames[queueType])
			end
		elseif button == "MiddleButton" or IsShiftKeyDown() then
			PVEFrame_ToggleFrame("GroupFinderFrame", LFDParentFrame)
		elseif button == "RightButton" then
			PVEFrame_ToggleFrame("GroupFinderFrame", RaidFinderFrame)
		else
			PVEFrame_ToggleFrame("GroupFinderFrame", ScenarioFinderFrame)
		end
	end,
	OnEnter = function(self)
		local queueType, mode, submode = GetQueueInfo()
		if mode then
			local screenHalf = GetScreenHalf()
			QueueStatusFrame:SetParent(UIParent)
			QueueStatusFrame:SetClampedToScreen(true)
			QueueStatusFrame:ClearAllPoints()
			QueueStatusFrame:SetPoint(screenHalf, self, screenHalf == "TOP" and "BOTTOM" or "TOP")
			QueueStatusFrame:SetFrameStrata("TOOLTIP")
			QueueStatusFrame:Show()
	--[[
		if mode == "queued" then
			local screenHalf = GetScreenHalf()
			QueueStatusFrame:SetParent(UIParent)
			QueueStatusFrame:SetClampedToScreen(true)
			QueueStatusFrame:ClearAllPoints()
			QueueStatusFrame:SetPoint(screenHalf, self, screenHalf == "TOP" and "BOTTOM" or "TOP")
			QueueStatusFrame:SetFrameStrata("TOOLTIP")
			QueueStatusFrame:Show()
		elseif mode == "proposal" then
			GameTooltip:SetOwner(self, GetScreenHalf() == "TOP" and "ANCHOR_BOTTOM" or "ANCHOR_TOP")
			GameTooltip:SetText(queueType == "raid" and RAID_FINDER or LOOKING_FOR_DUNGEON)
			GameTooltip:AddLine(DUNGEON_GROUP_FOUND_TOOLTIP, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(CLICK_HERE_FOR_MORE_INFO, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
			GameTooltip:Show()
		elseif mode == "rolecheck" then
			GameTooltip:SetOwner(self, GetScreenHalf() == "TOP" and "ANCHOR_BOTTOM" or "ANCHOR_TOP")
			GameTooltip:SetText(queueType == "raid" and RAID_FINDER or LOOKING_FOR_DUNGEON)
			GameTooltip:AddLine(ROLE_CHECK_IN_PROGRESS_TOOLTIP, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
			GameTooltip:Show()
		elseif mode == "listed" then
			GameTooltip:SetOwner(self, GetScreenHalf() == "TOP" and "ANCHOR_BOTTOM" or "ANCHOR_TOP")
			GameTooltip:SetText(queueType == "raid" and RAID_FINDER or LOOKING_FOR_DUNGEON)
			GameTooltip:AddLine(YOU_ARE_LISTED_IN_LFR, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
			GameTooltip:Show()
		elseif mode == "lfgparty" then
			GameTooltip:SetOwner(self, GetScreenHalf() == "TOP" and "ANCHOR_BOTTOM" or "ANCHOR_TOP")
			GameTooltip:SetText(queueType == "raid" and RAID_FINDER or LOOKING_FOR_DUNGEON)
			GameTooltip:AddLine(YOU_ARE_IN_DUNGEON_GROUP, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)

			local dungeon = GetPartyLFGID()
			local encounters, completed = GetLFGDungeonNumEncounters(dungeon)
			if completed > 0 then
				GameTooltip:AddLine(" ")
				GameTooltip:AddLine(string.format(BOSSES_KILLED, completed, encounters))
				for i = 1, encounters do
					local boss, _, killed = GetLFGDungeonEncounterInfo(dungeon, i)
					if killed then
						GameTooltip:AddLine(boss, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b)
					else
						GameTooltip:AddLine(boss, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
					end
				end
			end

			GameTooltip:Show()
		elseif mode == "suspended" then
			GameTooltip:SetOwner(self, GetScreenHalf() == "TOP" and "ANCHOR_BOTTOM" or "ANCHOR_TOP")
			GameTooltip:SetText(queueType == "raid" and RAID_FINDER or LOOKING_FOR_DUNGEON)
			GameTooltip:AddLine(IN_LFG_QUEUE_BUT_SUSPENDED, nil, nil, nil, 1)
			GameTooltip:Show()
	]]
		else
			GameTooltip:SetOwner(self, GetScreenHalf() == "TOP" and "ANCHOR_BOTTOM" or "ANCHOR_TOP")
			GameTooltip:SetText("Broker LFG")
			GameTooltip:AddLine(CLICK_TOGGLE_DUNGEONS)
			GameTooltip:AddLine(CLICK_TOGGLE_RAIDS)
			GameTooltip:AddLine(CLICK_TOGGLE_SCENARIOS)
			GameTooltip:Show()
		end
	end,
	OnLeave = function(self)
		QueueStatusFrame:Hide()
		GameTooltip:Hide()
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

------------------------------------------------------------------------

BrokerLFG:SetScript("OnEvent", function(self, event)
	local queueType, mode, submode = GetQueueInfo()

	if mode == "queued" and not GetLFGQueueStats() then
		queueType = "unknown"
	end

	if queueType ~= currentQueueType then
		currentQueueType = queueType
		currentIcon = LFG_EYE_TEXTURES[queueType] or LFG_EYE_TEXTURES.default
		iconCoords = currentIcon.iconCoords
		updateDelay = currentIcon.delay
		self.feed.icon = currentIcon.file
	end

	if mode == "queued" then
		currentFrame = 1
		self:SetScript("OnUpdate", UpdateIconCoords)
	else
		self:SetScript("OnUpdate", nil)
		currentFrame = 1
		self.feed.iconCoords = iconCoords[1]
	end
end)

QueueStatusFrame_OnLoad(Broker_LFG) -- Register all useful events.
Broker_LFG.StatusEntries = nil -- Clean up.

-- Hide default minimap button.
QueueStatusMinimapButton:Hide()
QueueStatusMinimapButton.Show = QueueStatusMinimapButton.Hide