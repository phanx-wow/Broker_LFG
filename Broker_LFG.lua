--[[------------------------------------------------------
	Broker_LFG
	Basic LFG button for your DataBroker display.
	Written by Phanx <addons@phanx.net>
	See the accompanying README file for more information.
	http://www.wowinterface.com/downloads/info16710-BrokerLFG.html
	http://www.curse.com/addons/wow/broker-lfg
----------------------------------------------------------------------]]

local L_QUEUE_STATUS = "LFG"
local L_CLICK_LFD = "Click to open the Dungeon Finder."
local L_CLICK_PVP = "Right-Click to open the PVP window."
local L_CLICK_LFR = "Alt-click to open the Raid Finder."
local L_CLICK_SCENARIOS = "Ctrl-Click to open the Scenarios window."
local L_CLICK_PETJOURNAL = "Middle-Click or Shift-click to open the Pet Journal."

local LOCALE = GetLocale()
if LOCALE == "deDE" then
	L_QUEUE_STATUS = "SNG"
	L_CLICK_LFD = "Klicken, um Dungeonbrowser aktivieren."
	L_CLICK_PVP = "Rechtsklicken, um ### aktivieren."
	L_CLICK_LFR = "###, um Schlachtzugsbrowser aktivieren."
	L_CLICK_SCENARIOS = "###, um Szenarienfenster aktivieren."
	L_CLICK_PETJOURNAL = "Mittleren klicken oder Shift-klicken, um ### aktivieren."

elseif LOCALE == "esES" then
	L_QUEUE_STATUS = "BDG"
	L_CLICK_PVP = "Haz clic derecho para mostrar o ocultar el panel ###."
	L_CLICK_LFD = "Haz clic para mostrar o ocultar el panel Buscador de calabozos."
	L_CLICK_LFR = "### para mostrar o ocultar el panel Buscador de bandas."
	L_CLICK_SCENARIOS = "### para mostrar o ocultar el panel Gestas."
	L_CLICK_PETJOURNAL = "Haz clic media o Mayús+clic para mostrar o ocultar el panel ###."

elseif LOCALE == "esMX" then
	L_QUEUE_STATUS = "BDG"
	L_CLICK_LFD = "Haz clic para mostrar o ocultar el panel Buscador de mazmorras."
	L_CLICK_PVP = "Haz clic derecho para mostrar o ocultar el panel ###."
	L_CLICK_LFR = "### para mostrar o ocultar el panel Buscador de bandas."
	L_CLICK_SCENARIOS = "### para mostrar o ocultar el panel Gestas."
	L_CLICK_PETJOURNAL = "Haz clic media o Mayús+clic para mostrar o ocultar el panel ###."

elseif LOCALE == "frFR" then
	L_QUEUE_STATUS = "RdG"
	L_CLICK_LFD = "Cliquer pour afficher ou fermer la fenêtre Donjons"
	L_CLICK_PVP = "Clic droit pour afficherou fermer la la fenêtre ###."
	L_CLICK_LFR = "### pour afficherou fermer la la fenêtre Raids."
	L_CLICK_SCENARIOS = "### pour afficher/fermer la fenêtre Scénarios."
	L_CLICK_PETJOURNAL = "Clic milieu ou clic-maj pour afficher/fermer la fenêtre ###."

elseif LOCALE == "itIT" then
	L_QUEUE_STATUS = "CG"
	L_CLICK_LFD = "Clicca per mostrare o nascondere il pannello Ricerca delle istanze."
	L_CLICK_PVP = "Clicca col tasto destro per mostrare o nascondere il pannello ###."
	L_CLICK_LFR = "### per mostrare o nascondere il pannello Ricerca delle incursioni."
	L_CLICK_SCENARIOS = "### per mostrare o nascondere il pannello Scenari."
	L_CLICK_PETJOURNAL = "Clicca col tasto medio o Maiusc-clic per mostrare o nascondere il pannello ###."

elseif LOCALE == "ptBR" or LOCALE == "ptPT" then
	L_QUEUE_STATUS = "PG"
	L_CLICK_PVP = "Direito-clique para mostrar ou ocultar o painel ###."
	L_CLICK_LFD = "Clique para mostrar ou ocultar o painel Localizador de masmorras."
	L_CLICK_LFR = "### para mostrar ou ocultar o painel Localizador de raides."
	L_CLICK_SCENARIOS = "### para mostrar ou ocultar o painel Cenários."
	L_CLICK_PETJOURNAL = "Meio-clique ou shift-clique para mostrar ou ocultar o painel ###."

elseif LOCALE == "ruRU" then
	L_QUEUE_STATUS = "ПГ"
	L_CLICK_LFD = "Щелкните для открытия окно поиска подземелий."
	L_CLICK_PVP = "Щелкните правой кнопкой мыши для открытия окно ###."
	L_CLICK_LFR = "### для открытия окно поиск рейда."
	L_CLICK_SCENARIOS = "### для открытия окно сценарий."
	L_CLICK_PETJOURNAL = "Щелкните средней кнопкой мыши или Shift-клик для открытия окно ###."

elseif LOCALE == "koKR" then
--	L_QUEUE_STATUS = ""
--	L_CLICK_LFD = ""
--	L_CLICK_PVP = ""
--	L_CLICK_LFR = ""
--	L_CLICK_SCENARIOS = ""
--	L_CLICK_PETJOURNAL = ""

elseif LOCALE == "enCN" or LOCALE == "zhCN" then -- Last updated 2011-04-28 by lsjyzjl @ CurseForge
	L_QUEUE_STATUS = "寻求组队"
	L_CLICK_LFD = "左键点击进入副本工具窗口。"
--	L_CLICK_PVP = ""
--	L_CLICK_LFR = ""
--	L_CLICK_SCENARIOS = ""
--	L_CLICK_PETJOURNAL = ""

elseif LOCALE == "enTW" or LOCALE == "zhTW" then -- Last updated 2011-04-28 by lsjyzjl @ CurseForge
	L_QUEUE_STATUS = "尋求組隊"
	L_CLICK_LFD = "點擊顯示地城搜尋視窗。"
--	L_CLICK_PVP = ""
--	L_CLICK_LFR = ""
--	L_CLICK_SCENARIOS = ""
--	L_CLICK_PETJOURNAL = ""

end
LOCALE = nil

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

addon.feed = LibStub("LibDataBroker-1.1"):NewDataObject("QueueStatus", {
	type = "launcher",
	icon = "Interface\\LFGFrame\\LFG-Eye",
	label = "Queue Status",
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
			GameTooltip:SetOwner(self, GetScreenHalf() == "TOP" and "ANCHOR_BOTTOM" or "ANCHOR_TOP")
			GameTooltip:SetText(L_QUEUE_STATUS)
			GameTooltip:AddLine(L_CLICK_LFD) -- Click for LFD
			GameTooltip:AddLine(L_CLICK_PVP) -- Right-click for PVP
			GameTooltip:AddLine(L_CLICK_PETJOURNAL) -- Middle/Shift-click for Pet Journal
			GameTooltip:AddLine(L_CLICK_LFR) -- Alt-click for LFR
			GameTooltip:AddLine(L_CLICK_SCENARIOS) -- Ctrl-click for Scenarios
			GameTooltip:Show()
		end
	end,
	OnLeave = function(self)
		QueueStatusFrame:Hide()
		GameTooltip:Hide()
	end,
	OnClick = function(self, button)
		local queueType = GetQueueInfo()
		if button == "RightButton" then
			if queueType and not IsShiftKeyDown() then
				PlaySound("igMainMenuOpen")
				local screenHalf = GetScreenHalf()
				QueueStatusMinimapButtonDropDown.point = screenHalf == "TOP" and "TOPLEFT" or "BOTTOMLEFT"
				QueueStatusMinimapButtonDropDown.relativePoint = screenHalf == "TOP" and "BOTTOMLEFT" or "TOPLEFT"
				ToggleDropDownMenu(1, nil, QueueStatusMinimapButtonDropDown, self:GetName() or self, 0, 0)
			else
				TogglePVPFrame()
			end
		elseif button == "MiddleButton" or IsShiftKeyDown() then
			TogglePetJournal(2)
		elseif IsControlKeyDown() then
			PVEFrame_ToggleFrame("GroupFinderFrame", ScenarioFinderFrame)
		elseif IsAltKeyDown() then
			PVEFrame_ToggleFrame("GroupFinderFrame", RaidFinderFrame)
		else
			PVEFrame_ToggleFrame("GroupFinderFrame", queueType and queueTypes[queueType] or LFDParentFrame)
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