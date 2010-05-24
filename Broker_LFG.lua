--[[------------------------------------------------------
	Broker_LFG
	DataBroker clone of the default UI's LFG button.
	by Phanx < addons@phanx.net >
	http://www.wowinterface.com/downloads/info-BrokerLFG.html
	http://wow.curse.com/downloads/wow-addons/details/broker-lfg.aspx
	Copyright © 2010 Alyssa "Phanx" Kinley

	I, the copyright holder of this work, hereby release it into the
	public domain. This applies worldwide.

	In case this is not legally possible, I hereby grant any entity the
	right to use this work for any purpose, without any conditions,
	unless such conditions are required by law.
----------------------------------------------------------------------]]

local texCoords = setmetatable({}, { __index = function(t, i)
	if type(i) ~= "number" then i = 1 end

	local L = mod(i - 1, 8) * 0.125
	local R = L + 0.125
	local B = ceil(i / 8) * 0.25
	local T = B - 0.25

	local c = { L, R, B, T }
	t[i] = c
	return c
end })

local function GetScreenHalf()
	local _, y = GetCursorPosition()
	if y * 2 > UIParent:GetHeight() then
		return "TOP"
	else
		return "BOTTOM"
	end
end

local BrokerLFG = CreateFrame("Frame")

BrokerLFG.feed = LibStub("LibDataBroker-1.1"):NewDataObject("LFG", {
	type = "launcher",
	icon = "Interface\\LFGFrame\\LFG-Eye",
	label = "LFG",
	texCoords = texCoords[1],
	OnClick = function(self, button)
		local mode = GetLFGMode()
		if mode then
			if button == "RightButton" or mode == "lfgparty" or mode == "abandonedInDungeon" then
				PlaySound("igMainMenuOpen")
				local screenHalf = GetScreenHalf()
				MiniMapLFGFrameDropDown.point = screenHalf == "TOP" and "TOPLEFT" or "BOTTOMLEFT"
				MiniMapLFGFrameDropDown.relativePoint = screenHalf == "TOP" and "BOTTOMLEFT" or "TOPLEFT"
				ToggleDropDownMenu(1, nil, MiniMapLFGFrameDropDown, self:GetName(), 0, 0)
			elseif mode == "proposal" then
				if not LFDDungeonReadyPopup:IsShown() then
					PlaySound("igCharacterInfoTab")
					StaticPopupSpecial_Show(LFDDungeonReadyPopup)
				end
			elseif mode == "queued" or mode == "rolecheck" then
				ToggleLFDParentFrame()
			elseif mode == "listed" then
				ToggleLFRParentFrame()
			end
		elseif button == "RightButton" then
			ToggleLFRParentFrame()
		else
			ToggleLFDParentFrame()
		end
	end,
	OnEnter = function(self)
		local mode = GetLFGMode()
		if mode == "queued" then
			local screenHalf = GetScreenHalf()
			LFDSearchStatus:SetParent(UIParent)
			LFDSearchStatus:SetClampedToScreen(true)
			LFDSearchStatus:ClearAllPoints()
			LFDSearchStatus:SetPoint(screenHalf, self, screenHalf == "TOP" and "BOTTOM" or "TOP")
			LFDSearchStatus:Show()
		elseif mode == "proposal" then
			GameTooltip:SetOwner(self, GetScreenHalf() == "TOP" and "ANCHOR_BOTTOM" or "ANCHOR_TOP")
			GameTooltip:SetText(LOOKING_FOR_DUNGEON)
			GameTooltip:AddLine(DUNGEON_GROUP_FOUND_TOOLTIP, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(CLICK_HERE_FOR_MORE_INFO, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
			GameTooltip:Show()
		elseif mode == "rolecheck" then
			GameTooltip:SetOwner(self, GetScreenHalf() == "TOP" and "ANCHOR_BOTTOM" or "ANCHOR_TOP")
			GameTooltip:SetText(LOOKING_FOR_DUNGEON)
			GameTooltip:AddLine(ROLE_CHECK_IN_PROGRESS_TOOLTIP, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
			GameTooltip:Show()
		elseif mode == "listed" then
			GameTooltip:SetOwner(self, GetScreenHalf() == "TOP" and "ANCHOR_BOTTOM" or "ANCHOR_TOP")
			GameTooltip:SetText(LOOKING_FOR_RAID)
			GameTooltip:AddLine(YOU_ARE_LISTED_IN_LFR, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
			GameTooltip:Show()
		elseif mode == "lfgparty" then
			GameTooltip:SetOwner(self, GetScreenHalf() == "TOP" and "ANCHOR_BOTTOM" or "ANCHOR_TOP")
			GameTooltip:SetText(LOOKING_FOR_DUNGEON)
			GameTooltip:AddLine(YOU_ARE_IN_DUNGEON_GROUP, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
			GameTooltip:Show()
		else
			GameTooltip:SetOwner(self, GetScreenHalf() == "TOP" and "ANCHOR_BOTTOM" or "ANCHOR_TOP")
			GameTooltip:SetText("Broker LFG")
			GameTooltip:AddLine("Click to open the Dungeon Finder window.")
			GameTooltip:AddLine("Right-click to open the Raid Browser window.")
			GameTooltip:Show()
		end
	end,
	OnLeave = function(self)
		GameTooltip:Hide()
		LFDSearchStatus:Hide()
	end,
})

local currentFrame = 1

local counter = 0
local function UpdateIconCoords(self, elapsed)
	counter = counter + elapsed
	if counter > 0.1 then
		if currentFrame > 29 then
			currentFrame = 1
		end
		self.feed.iconCoords = texCoords[currentFrame]
		currentFrame = currentFrame + 1
		counter = 0
	end
end

BrokerLFG:SetScript("OnEvent", function(self)
	local mode = GetLFGMode()
	if mode then
		if mode == "queued" or mode == "listed" or mode == "rolecheck" then
			self:SetScript("OnUpdate", UpdateIconCoords)
		else
			self:SetScript("OnUpdate", nil)
			currentFrame = 1
			self.feed.iconCoords = texCoords[1]
		end
	else
		currentFrame = 1
		self.feed.iconCoords = texCoords[1]
	end
end)

BrokerLFG:RegisterEvent("LFG_UPDATE")
BrokerLFG:RegisterEvent("PLAYER_ENTERING_WORLD")
BrokerLFG:RegisterEvent("LFG_ROLE_CHECK_UPDATE")
BrokerLFG:RegisterEvent("LFG_PROPOSAL_UPDATE")

MiniMapLFGFrame:Hide()
MiniMapLFGFrame.Show = MiniMapLFGFrame.Hide