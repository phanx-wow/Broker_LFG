--[[------------------------------------------------------
	Broker_LFG
	Basic LFG button for your DataBroker display.
	Written by Phanx <addons@phanx.net>
	See the accompanying README file for more information.
	http://www.wowinterface.com/downloads/info16710-BrokerLFG.html
	http://www.curse.com/addons/wow/broker-lfg
----------------------------------------------------------------------]]

local LFG = "LFG"
local CLICK_TOGGLE_DUNGEONS = "Click to open the Dungeon Finder."
local CLICK_TOGGLE_PVP = "Right-Click to open the PVP window."
local CLICK_TOGGLE_RAIDS = "Alt-click to open the Raid Finder."
local CLICK_TOGGLE_SCENARIOS = "Ctrl-Click to open the Scenarios window."
local CLICK_TOGGLE_PETJOURNAL = "Middle-Click or Shift-click to open the Pet Journal."

local LOCALE = GetLocale()
if LOCALE == "deDE" then
	LFG = "SNG"
	CLICK_TOGGLE_DUNGEONS = "Klicken, um Dungeonbrowser aktivieren."
	CLICK_TOGGLE_PVP = "Rechtsklicken, um PvP-Fenster aktivieren."
	CLICK_TOGGLE_RAIDS = "ALT-klicken, um Schlachtzugsbrowser aktivieren."
	CLICK_TOGGLE_SCENARIOS = "STRG-klicken, um Szenarienfenster aktivieren."
	CLICK_TOGGLE_PETJOURNAL = "Mittleren klicken oder SHIFT-klicken, um Wildtierführer aktivieren."

elseif LOCALE == "esES" then
	LFG = "BDG"
	CLICK_TOGGLE_PVP = "Haz clic derecho para mostrar o ocultar el cuadro de JcJ."
	CLICK_TOGGLE_DUNGEONS = "Haz clic para mostrar o ocultar el buscador de mazmorras."
	CLICK_TOGGLE_RAIDS = "Alt+clic para mostrar o ocultar el buscador de bandas."
	CLICK_TOGGLE_SCENARIOS = "Ctrl+clic para mostrar o ocultar el cuadro de gestas."
	CLICK_TOGGLE_PETJOURNAL = "Haz clic media o Mayús+clic para mostrar o ocultar la guía de mascotas."

elseif LOCALE == "esMX" then
	LFG = "BDG"
	CLICK_TOGGLE_DUNGEONS = "Haz clic para mostrar o ocultar el buscador de calabozos."
	CLICK_TOGGLE_PVP = "Haz clic derecho para mostrar o ocultar el cuadro de JcJ."
	CLICK_TOGGLE_RAIDS = "Alt-clic para mostrar o ocultar el buscador de bandas."
	CLICK_TOGGLE_SCENARIOS = "Ctrl+clic para mostrar o ocultar el cuadro de gestas."
	CLICK_TOGGLE_PETJOURNAL = "Haz clic media o Mayús+clic para mostrar o ocultar la guía de mascotas."

elseif LOCALE == "frFR" then
	LFG = "RdG"
	CLICK_TOGGLE_DUNGEONS = "Cliquer pour afficher ou fermer la Cadre des donjons"
	CLICK_TOGGLE_PVP = "Clic droit pour afficher ou fermer le Panneau JcJ."
	CLICK_TOGGLE_RAIDS = "Clic-alt pour afficher ou fermer la Formation de raid."
	CLICK_TOGGLE_SCENARIOS = "Clic-ctrl pour afficher/fermer le Panneau des Scénarios."
	CLICK_TOGGLE_PETJOURNAL = "Clic milieu ou clic-maj pour afficher/fermer le Codex des mascottes."

elseif LOCALE == "itIT" then
	LFG = "CG"
	CLICK_TOGGLE_DUNGEONS = "Clicca per mostrare o nascondere il ricerca delle istanze."
	CLICK_TOGGLE_PVP = "Clicca destro per mostrare o nascondere l'interfaccia del PvP."
	CLICK_TOGGLE_RAIDS = "Alt-clicca per mostrare o nascondere il ricerca delle incursioni."
	CLICK_TOGGLE_SCENARIOS = "Ctrl-clicca per mostrare o nascondere il pannello delle scenari."
	CLICK_TOGGLE_PETJOURNAL = "Clicca medio o Maiusc-clicca per mostrare o nascondere il diario delle mascotte."

elseif LOCALE == "ptBR" or LOCALE == "ptPT" then
	LFG = "PG"
	CLICK_TOGGLE_PVP = "Direito-clique para mostrar ou ocultar o quadro de JxJ."
	CLICK_TOGGLE_DUNGEONS = "Clique para mostrar ou ocultar o Localizador de masmorras."
	CLICK_TOGGLE_RAIDS = "Alt-clique para mostrar ou ocultar o Localizador de raides."
	CLICK_TOGGLE_SCENARIOS = "Ctrl-clique para mostrar ou ocultar o Localizador de cenários."
	CLICK_TOGGLE_PETJOURNAL = "Meio-clique ou shift-clique para mostrar ou ocultar o Diário de Mascotes."

elseif LOCALE == "ruRU" then
	LFG = "ПГ"
	CLICK_TOGGLE_DUNGEONS = "Щелкните для открытия Поиск подземелий."
	CLICK_TOGGLE_PVP = "Щелкните правой кнопкой мыши для открытия Окно PvP."
	CLICK_TOGGLE_RAIDS = "Alt-клик для открытия Поиск рейда."
	CLICK_TOGGLE_SCENARIOS = "Ctrl-клик для открытия Сценарии."
	CLICK_TOGGLE_PETJOURNAL = "Щелкните средней кнопкой мыши или Shift-клик для открытия Транспорт и питомцы."

elseif LOCALE == "koKR" then -- Last updated 2012-09-21 by nayuki87 on CurseForge
	LFG = "던전 찾기"
	CLICK_TOGGLE_DUNGEONS = "클릭 하면 던전 찾기 창을 켜거나 끕니다."
	CLICK_TOGGLE_PVP = "오른쪽클릭 하면 명예창 창을 켜거나 끕니다."
	CLICK_TOGGLE_RAIDS = "ALT클릭 하면 공격대 찾기 창을 켜거나 끕니다."
	CLICK_TOGGLE_SCENARIOS = "CTRL클릭 하면 시나리오 창을 켜거나 끕니다."
	CLICK_TOGGLE_PETJOURNAL = "가운데클릭 또는 쉬프트클릭 하면 애완동물 도감 창을 켜거나 끕니다."

elseif LOCALE == "enCN" or LOCALE == "zhCN" then -- Last updated 2011-04-28 by lsjyzjl @ CurseForge
	LFG = "寻求组队"
	CLICK_TOGGLE_DUNGEONS = "左键点击进入副本工具窗口。"
--	CLICK_TOGGLE_PVP = ""
--	CLICK_TOGGLE_RAIDS = ""
--	CLICK_TOGGLE_SCENARIOS = ""
--	CLICK_TOGGLE_PETJOURNAL = ""

elseif LOCALE == "enTW" or LOCALE == "zhTW" then -- Last updated 2011-04-28 by lsjyzjl @ CurseForge
	LFG = "尋求組隊"
	CLICK_TOGGLE_DUNGEONS = "點擊顯示地城搜尋視窗。"
--	CLICK_TOGGLE_PVP = ""
--	CLICK_TOGGLE_RAIDS = ""
--	CLICK_TOGGLE_SCENARIOS = ""
--	CLICK_TOGGLE_PETJOURNAL = ""

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

addon.feed = LibStub("LibDataBroker-1.1"):NewDataObject("LFG", {
	type = "launcher",
	icon = "Interface\\LFGFrame\\LFG-Eye",
	label = "LFG",
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
			GameTooltip:SetText(LFG)
			GameTooltip:AddLine(CLICK_TOGGLE_DUNGEONS) -- Click for LFD
			GameTooltip:AddLine(CLICK_TOGGLE_PVP) -- Right-click for PVP
			GameTooltip:AddLine(CLICK_TOGGLE_PETJOURNAL) -- Middle/Shift-click for Pet Journal
			GameTooltip:AddLine(CLICK_TOGGLE_RAIDS) -- Alt-click for LFR
			GameTooltip:AddLine(CLICK_TOGGLE_SCENARIOS) -- Ctrl-click for Scenarios
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