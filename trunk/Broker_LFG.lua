--[[------------------------------------------------------
	Broker_LFG
	DataBroker clone of the default UI's LFG button.
	by Phanx <addons@phanx.net>
	http://www.wowinterface.com/downloads/info16710-Broker_LFG.html
	http://www.curse.com/addons/wow/broker-lfg

	Copyright © 2010–2011 Phanx
	I, the copyright holder of this work, hereby release it into the public
	domain. This applies worldwide. In case this is not legally possible: I
	grant anyone the right to use this work for any purpose, without any
	conditions, unless such conditions are required by law.
----------------------------------------------------------------------]]

local LFG = "LFG"
local CLICK_TOGGLE_LFD = "Click to toggle the Dungeon Finder window."
local CLICK_TOGGLE_LFR = "Right-click to toggle the Raid Browser window."

local locale = GetLocale()
if locale == "deDE" then
	LFG = "SNG"
	CLICK_TOGGLE_LFD = "Zum Dungeonbrowser aktivieren klicken."
	CLICK_TOGGLE_LFR = "Zum Schlachtzugsbrowser aktivieren rechtsklicken."
elseif locale == "esES" or locale == "esMX" then
	LFG = "BDG"
	CLICK_TOGGLE_LFD = "Haz clic para mostrar/ocultar el buscador de mazmorras."
	CLICK_TOGGLE_LFR = "Haz clic derecho para mostrar/ocultar el buscador de banda."
elseif locale == "frFR" then
	LFG = "RdG"
	CLICK_TOGGLE_LFD = "Cliquer pour afficher/fermer cadre des donjons."
	CLICK_TOGGLE_LFR = "Clic droit pour afficher/fermer la recherche de raid."
elseif locale == "ptBR" then
	LFG = ""
	CLICK_TOGGLE_LFD = "Clique para mostrar/ocultar o painel localizador de masmorras."
	CLICK_TOGGLE_LFR = "Clique com o botão direito do mouse para mostrar/ocultar o painel localizador de raides"
elseif locale == "ruRU" then
	LFG = "ЛФГ"
	CLICK_TOGGLE_LFD = "Щелкните, чтобы открыть окно поиска подземелий."
	CLICK_TOGGLE_LFR = "Щелкните правой кнопкой мыши, чтобы открыть список рейдов."
elseif locale == "koKR" then
--	LFG = ""
--	CLICK_TOGGLE_LFD = ""
--	CLICK_TOGGLE_LFR = ""
elseif locale == "zhCN" then -- Last updated 2011-03-04 by tss1398383123 @ CurseForge
--	LFG = ""
	CLICK_TOGGLE_LFD = "左键点击进入FB工具窗口。"
	CLICK_TOGGLE_LFR = "右键点击进入团队浏览器窗口。"
elseif locale == "zhTW" then
--	LFG = ""
--	CLICK_TOGGLE_LFD = ""
--	CLICK_TOGGLE_LFR = ""
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
		local mode = GetLFGMode()
		if mode then
			if button == "RightButton" or mode == "lfgparty" or mode == "abandonedInDungeon" then
				PlaySound("igMainMenuOpen")
				local screenHalf = GetScreenHalf()
				MiniMapLFGFrameDropDown.point = screenHalf == "TOP" and "TOPLEFT" or "BOTTOMLEFT"
				MiniMapLFGFrameDropDown.relativePoint = screenHalf == "TOP" and "BOTTOMLEFT" or "TOPLEFT"
				ToggleDropDownMenu(1, nil, MiniMapLFGFrameDropDown, self:GetName() or self, 0, 0)
			elseif mode == "proposal" then
				if not LFGDungeonReadyPopup:IsShown() then
					PlaySound("igCharacterInfoTab")
					StaticPopupSpecial_Show(LFDGungeonReadyPopup)
				end
			elseif mode == "queued" or mode == "rolecheck" or mode == "suspended" then
				if select(8, GetLFGInfoServer()) then
					ToggleRaidFrame(1)
				else
					ToggleLFDParentFrame()
				end
			elseif mode == "listed" then
				ToggleFriendsFrame(4)
			end
		elseif button == "RightButton" then
			ToggleRaidFrame(1)
		else
			ToggleLFDParentFrame()
		end
	end,
	OnEnter = function(self)
		local mode, submode = GetLFGMode()
		local queueType = GetLFGModeType()
		if mode == "queued" then
			local screenHalf = GetScreenHalf()
			LFGSearchStatus:SetParent(UIParent)
			LFGSearchStatus:SetClampedToScreen(true)
			LFGSearchStatus:ClearAllPoints()
			LFGSearchStatus:SetPoint(screenHalf, self, screenHalf == "TOP" and "BOTTOM" or "TOP")
			LFGSearchStatus:SetFrameLevel("TOOLTIP")
			LFGSearchStatus:Show()
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
		else
			GameTooltip:SetOwner(self, GetScreenHalf() == "TOP" and "ANCHOR_BOTTOM" or "ANCHOR_TOP")
			GameTooltip:SetText("Broker LFG")
			GameTooltip:AddLine(CLICK_TOGGLE_LFD)
			GameTooltip:AddLine(CLICK_TOGGLE_LFR)
			GameTooltip:Show()
		end
	end,
	OnLeave = function(self)
		GameTooltip:Hide()
		LFGSearchStatus:Hide()
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

BrokerLFG:SetScript("OnEvent", function(self, event)
	local mode = GetLFGMode()
	local queueType
	if mode then
		if mode == "queued" and not GetLFGQueueStats() then
			queueType = "unknown"
		else
			queueType = GetLFGModeType()
		end
	end
	if queueType ~= currentQueueType then
		currentQueueType = queueType
		currentIcon = LFG_EYE_TEXTURES[queueType] or LFG_EYE_TEXTURES.default
		iconCoords = currentIcon.iconCoords
		updateDelay = currentIcon.delay
		self.feed.icon = currentIcon.file
	end
	if mode == "queued" or mode == "listed" or mode == "rolecheck" or mode == "suspended" then
		currentFrame = 1
		self:SetScript("OnUpdate", UpdateIconCoords)
	else
		self:SetScript("OnUpdate", nil)
		currentFrame = 1
		self.feed.iconCoords = iconCoords[1]
	end
end)

BrokerLFG:RegisterEvent("LFG_UPDATE")
BrokerLFG:RegisterEvent("PLAYER_ENTERING_WORLD")
BrokerLFG:RegisterEvent("LFG_ROLE_CHECK_UPDATE")
BrokerLFG:RegisterEvent("LFG_PROPOSAL_UPDATE")

MiniMapLFGFrame:Hide()
MiniMapLFGFrame.Show = MiniMapLFGFrame.Hide