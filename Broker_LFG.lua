--[[--------------------------------------------------------------------
	Broker_LFG
	Basic LFG button for your DataBroker display.
	Copyright (c) 2010-2014 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info16710-BrokerLFG.html
	http://www.curse.com/addons/wow/broker-lfg
----------------------------------------------------------------------]]

local L = {
	AltClickRaids = "Alt-click to open the Raid Finder.",
	ClickDungeons = "Click to open the Dungeon Finder.",
	CtrlClickScenarios = "Ctrl-Click to open the Scenarios window.",
	LFG = "LFG",
	RightClickPVP = "Right-Click to open the PVP window.",
	ShiftClickPets = "Middle-Click or Shift-click to open the Pet Journal.",
}

local LOCALE = GetLocale()
if LOCALE == "deDE" then
	L.LFG = "SNG"
	L.ClickDungeons = "Klicken, um Dungeonbrowser aktivieren."
	L.RightClickPVP = "Rechtsklicken, um PvP-Fenster aktivieren."
	L.AltClickRaids = "ALT-Klicken, um Schlachtzugsbrowser aktivieren."
	L.CtrlClickScenarios = "STRG-Klicken, um Szenarienfenster aktivieren."
	L.ShiftClickPets = "Mittelklicken oder SHIFT-Klicken, um Wildtierführer aktivieren."

elseif LOCALE == "esES" then
	L.LFG = "BDG"
	L.ClickDungeons = "Haz clic para mostrar o ocultar el buscador de mazmorras."
	L.RightClickPVP = "Haz clic derecho para mostrar o ocultar el cuadro de JcJ."
	L.AltClickRaids = "Alt+clic para mostrar o ocultar el buscador de bandas."
	L.CtrlClickScenarios = "Ctrl+clic para mostrar o ocultar el cuadro de gestas."
	L.ShiftClickPets = "Haz clic media o Mayús+clic para mostrar o ocultar la guía de mascotas."

elseif LOCALE == "esMX" then
	L.LFG = "BDG"
	L.ClickDungeons = "Haz clic para mostrar o ocultar el buscador de calabozos."
	L.RightClickPVP = "Haz clic derecho para mostrar o ocultar el cuadro de JcJ."
	L.AltClickRaids = "Alt-clic para mostrar o ocultar el buscador de bandas."
	L.CtrlClickScenarios = "Ctrl+clic para mostrar o ocultar el cuadro de gestas."
	L.ShiftClickPets = "Haz clic media o Mayús+clic para mostrar o ocultar la guía de mascotas."

elseif LOCALE == "frFR" then
	L.LFG = "RdG"
	L.ClickDungeons = "Cliquer pour afficher ou fermer la Cadre des donjons"
	L.RightClickPVP = "Clic droit pour afficher ou fermer le Panneau JcJ."
	L.AltClickRaids = "Clic-alt pour afficher ou fermer la Formation de raid."
	L.CtrlClickScenarios = "Clic-ctrl pour afficher/fermer le Panneau des Scénarios."
	L.ShiftClickPets = "Clic milieu ou clic-maj pour afficher/fermer le Codex des mascottes."

elseif LOCALE == "itIT" then
	L.LFG = "CG"
	L.ClickDungeons = "Clicca per mostrare o nascondere il ricerca delle istanze."
	L.RightClickPVP = "Clicca destro per mostrare o nascondere l'interfaccia del PvP."
	L.AltClickRaids = "Alt-clicca per mostrare o nascondere il ricerca delle incursioni."
	L.CtrlClickScenarios = "Ctrl-clicca per mostrare o nascondere il pannello delle scenari."
	L.ShiftClickPets = "Clicca medio o Maiusc-clicca per mostrare o nascondere il diario delle mascotte."

elseif LOCALE == "ptBR" or LOCALE == "ptPT" then
	L.LFG = "PG"
	L.RightClickPVP = "Direito-clique para mostrar ou ocultar o quadro de JxJ."
	L.ClickDungeons = "Clique para mostrar ou ocultar o Localizador de masmorras."
	L.AltClickRaids = "Alt-clique para mostrar ou ocultar o Localizador de raides."
	L.CtrlClickScenarios = "Ctrl-clique para mostrar ou ocultar o Localizador de cenários."
	L.ShiftClickPets = "Meio-clique ou shift-clique para mostrar ou ocultar o Diário de Mascotes."

elseif LOCALE == "ruRU" then
	L.LFG = "ПГ"
	L.ClickDungeons = "Щелкните для открытия Поиск подземелий."
	L.RightClickPVP = "Щелкните правой кнопкой мыши для открытия Окно PvP."
	L.AltClickRaids = "Alt-клик для открытия Поиск рейда."
	L.CtrlClickScenarios = "Ctrl-клик для открытия Сценарии."
	L.ShiftClickPets = "Щелкните средней кнопкой мыши или Shift-клик для открытия Транспорт и питомцы."

elseif LOCALE == "koKR" then
	-- Last updated 2012-09-21 by nayuki87
	L.LFG = "던전 찾기"
	L.ClickDungeons = "클릭 하면 던전 찾기 창을 켜거나 끕니다."
	L.RightClickPVP = "오른쪽클릭 하면 명예창 창을 켜거나 끕니다."
	L.AltClickRaids = "ALT클릭 하면 공격대 찾기 창을 켜거나 끕니다."
	L.CtrlClickScenarios = "CTRL클릭 하면 시나리오 창을 켜거나 끕니다."
	L.ShiftClickPets = "가운데클릭 또는 쉬프트클릭 하면 애완동물 도감 창을 켜거나 끕니다."

elseif LOCALE == "zhCN" then
	-- Last updated 2012-12-06 by okaydud
	-- Previous contributors: tss1398383123, lsjyzjl
	L.LFG = "寻求组队"
	L.ClickDungeons = "左键点击进入副本工具窗口。"
	L.RightClickPVP = "右键点击打开PVP窗口。"
	L.AltClickRaids  = "Alt+左键点击进入团队浏览器窗口。"
	L.CtrlClickScenarios = "按住Ctrl键单击打开/关闭场景战役查找。"
	L.ShiftClickPets = "中键点击或Shift+左键点击打开宠物手册。"

elseif LOCALE == "zhTW" then
	-- Last updated 2012-07-15 by lsjyzjl
	L.LFG = "尋求組隊"
	L.ClickDungeons = "點擊顯示地城搜尋視窗。"
	L.RightClickPVP = "右键单击打开/关闭PVP窗口。"
	L.AltClickRaids = "按住Alt键单击打开/关闭瀏覽團隊窗口。"
	L.CtrlClickScenarios = "按住Ctrl键单击打开/关闭场景战役查找。"
--	L.ShiftClickPets = ""

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
			GameTooltip:SetOwner(self, GetScreenHalf() == "TOP" and "ANCHOR_BOTTOM" or "ANCHOR_TOP")
			GameTooltip:SetText(L.LFG)
			GameTooltip:AddLine(L.ClickDungeons, 1, 1, 1) -- Click for LFD
			GameTooltip:AddLine(L.RightClickPVP, 1, 1, 1) -- Right-click for PVP
			GameTooltip:AddLine(L.ShiftClickPets, 1, 1, 1) -- Middle/Shift-click for Pet Journal
			GameTooltip:AddLine(L.AltClickRaids, 1, 1, 1) -- Alt-click for LFR
			GameTooltip:AddLine(L.CtrlClickScenarios, 1, 1, 1) -- Ctrl-click for Scenarios
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
				TogglePVPUI()
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