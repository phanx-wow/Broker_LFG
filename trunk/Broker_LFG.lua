--[[------------------------------------------------------
	Broker_LFG
	Basic LFG button for your DataBroker display.
	Written by Phanx <addons@phanx.net>
	See the accompanying README file for more information.
	http://www.wowinterface.com/downloads/info16710-BrokerLFG.html
	http://www.curse.com/addons/wow/broker-lfg
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
	CLICK_TOGGLE_DUNGEONS = "Haz clic para mostraro ocultar el panel Buscador de calabozos."
	CLICK_TOGGLE_RAIDS = "Haz clic derecho para mostraro ocultar el panel Buscador de bandas."
	CLICK_TOGGLE_SCENARIOS = "Haz clic media o Mayús+clic para mostrar/ocultar el panel Gestas."
elseif locale == "frFR" then
	LFG = "RdG"
	CLICK_TOGGLE_DUNGEONS = "Cliquer pour afficher ou fermer la fenêtre Donjons."
	CLICK_TOGGLE_RAIDS = "Clic droit pour afficherou fermer la la fenêtre Raids."
	CLICK_TOGGLE_SCENARIOS = "Clic milieu ou clic-maj pour afficher/fermer la fenêtre Scénarios."
elseif locale == "itIT" then
	LFG = "CG"
	CLICK_TOGGLE_DUNGEONS = "Clicca per mostrare o nascondere il pannello Ricerca delle istanze."
	CLICK_TOGGLE_RAIDS = "Clicca col tasto destro per mostrare o nascondere il pannello Ricerca delle incursioni."
	CLICK_TOGGLE_SCENARIOS = "Clicca col tasto medio o Maiusc-clic per mostrare o nascondere il pannello Scenari."
elseif locale == "ptBR" then
	LFG = "PG"
	CLICK_TOGGLE_DUNGEONS = "Clique para mostrar ou ocultar o painel Localizador de masmorras."
	CLICK_TOGGLE_RAIDS = "Direito-clique para mostrarou ocultar o painel Localizador de raides."
	CLICK_TOGGLE_SCENARIOS = "Meio-clique ou shift-clique para mostrarou ocultar o painel Cenários."
elseif locale == "ruRU" then
	LFG = "ПГ"
	CLICK_TOGGLE_DUNGEONS = "Щелкните для открытия окно поиска подземелий."
	CLICK_TOGGLE_RAIDS = "Щелкните правой кнопкой мыши для открытия окно поиск рейда."
	CLICK_TOGGLE_SCENARIOS = "Щелкните средней кнопкой мыши или Shift-клик для открытия окно сценарий."
elseif locale == "koKR" then
--	LFG = ""
--	CLICK_TOGGLE_DUNGEONS = ""
--	CLICK_TOGGLE_RAIDS = ""
--	CLICK_TOGGLE_SCENARIOS = ""
elseif locale == "zhCN" then -- Last updated 2011-04-28 by lsjyzjl @ CurseForge
	LFG = "寻求组队"
	CLICK_TOGGLE_DUNGEONS = "左键点击进入副本工具窗口。"
	CLICK_TOGGLE_RAIDS = "右键点击进入团队浏览器窗口。"
	CLICK_TOGGLE_SCENARIOS = "中单击或按住Shift键单击打开/关闭场景战役查找。" -- Needs review
elseif locale == "zhTW" then -- Last updated 2011-04-28 by lsjyzjl @ CurseForge
	LFG = "尋求組隊"
	CLICK_TOGGLE_DUNGEONS = "點擊顯示地城搜尋視窗。"
	CLICK_TOGGLE_RAIDS = "右鍵點擊顯示瀏覽團隊窗口。"
	CLICK_TOGGLE_SCENARIOS = "中鍵單擊或按住Shift鍵單擊打開/關閉場景框架。" -- Needs review
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
local queueTypes = {
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
			return queueTypes[i], mode, submode, queueTypeIndex
		end
	end

	for i = 1, GetMaxBattlefieldID() do
		local status = GetBattlefieldStatus(i)
		if status == "queued" then
			return "pvp", "queued"
		end
	end

	for i = 1, MAX_WORLD_PVP_QUEUES do
		local status = GetWorldPVPQueueStatus(i)
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
				QueueStatusMinimapButtonDropDown.point = screenHalf == "TOP" and "TOPLEFT" or "BOTTOMLEFT"
				QueueStatusMinimapButtonDropDown.relativePoint = screenHalf == "TOP" and "BOTTOMLEFT" or "TOPLEFT"
				ToggleDropDownMenu(1, nil, QueueStatusMinimapButtonDropDown, self:GetName() or self, 0, 0)
			else
				PVEFrame_ToggleFrame("GroupFinderFrame", queueFrames[queueType])
			end
		elseif button == "MiddleButton" or IsShiftKeyDown() then
			PVEFrame_ToggleFrame("GroupFinderFrame", ScenarioFinderFrame)
		elseif button == "RightButton" then
			PVEFrame_ToggleFrame("GroupFinderFrame", RaidFinderFrame)
		else
			PVEFrame_ToggleFrame("GroupFinderFrame", LFDParentFrame)
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
	local queueType, mode, submode, queueTypeIndex = GetQueueInfo()

	if mode == "queued" and queueTypeIndex and not GetLFGQueueStats(queueTypeIndex) then
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

QueueStatusFrame_OnLoad(BrokerLFG) -- Register all useful events.
BrokerLFG.StatusEntries = nil -- Clean up.

-- Hide default minimap button.
QueueStatusMinimapButton:Hide()
QueueStatusMinimapButton.Show = QueueStatusMinimapButton.Hide