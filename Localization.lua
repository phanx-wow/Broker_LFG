--[[--------------------------------------------------------------------
	Broker_LFG
	Basic LFG button for your DataBroker display.
	Copyright (c) 2010-2016 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info16710-BrokerLFG.html
	https://mods.curse.com/addons/wow/broker-lfg
	https://github.com/Phanx/Broker_LFG
----------------------------------------------------------------------]]

local ADDON, L = ...

setmetatable(L, { __index = function(t, k)
	local v = tostring(k)
	t[k] = v
	return v
end })

-- THE REST OF THIS FILE IS AUTOMATICALLY GENERATED. SEE:
-- https://wow.curseforge.com/addons/broker-lfg/localization/

------------------------------------------------------------------------
-- English
------------------------------------------------------------------------

L.CLICK_TOGGLE_DUNGEONS = "Click to open the Dungeon Finder."
L.CLICK_TOGGLE_PETJOURNAL = "Middle-Click or Shift-click to open the Pet Journal."
L.CLICK_TOGGLE_PVP = "Right-Click to open the PVP window."
L.CLICK_TOGGLE_RAIDS = "Alt-click to open the Raid Finder."
L.CLICK_TOGGLE_SCENARIOS = "Ctrl-Click to open the Scenarios window."

local CURRENT_LOCALE = GetLocale()
if CURRENT_LOCALE == "enUS" then return end

------------------------------------------------------------------------
-- German
------------------------------------------------------------------------

if CURRENT_LOCALE == "deDE" then

L.CLICK_TOGGLE_DUNGEONS = "Klicken, um Dungeonbrowser aktivieren."
L.CLICK_TOGGLE_PETJOURNAL = "Mittleren klicken oder SHIFT-klicken, um Wildtierführer aktivieren."
L.CLICK_TOGGLE_PVP = "Rechtsklicken, um PvP-Fenster aktivieren."
L.CLICK_TOGGLE_RAIDS = "ALT-klicken, um Schlachtzugsbrowser aktivieren."
L.CLICK_TOGGLE_SCENARIOS = "STRG-klicken, um Szenarienfenster aktivieren."
L.LFG = "SNG"

return end

------------------------------------------------------------------------
-- Spanish
------------------------------------------------------------------------

if CURRENT_LOCALE == "esES" then

L.CLICK_TOGGLE_DUNGEONS = "Haz clic para mostrar o ocultar el buscador de mazmorras."
L.CLICK_TOGGLE_PETJOURNAL = "Haz clic media o Mayús+clic para mostrar o ocultar la guía de mascotas."
L.CLICK_TOGGLE_PVP = "Haz clic derecho para mostrar o ocultar el cuadro de JcJ."
L.CLICK_TOGGLE_RAIDS = "Alt+clic para mostrar o ocultar el buscador de bandas."
L.CLICK_TOGGLE_SCENARIOS = "Ctrl+clic para mostrar o ocultar el cuadro de gestas."
L.LFG = "BDG"

return end

------------------------------------------------------------------------
-- Latin American Spanish
------------------------------------------------------------------------

if CURRENT_LOCALE == "esMX" then

L.CLICK_TOGGLE_DUNGEONS = "Haz clic para mostrar o ocultar el buscador de calabozos."
L.CLICK_TOGGLE_PETJOURNAL = "Haz clic media o Mayús+clic para mostrar o ocultar la guía de mascotas."
L.CLICK_TOGGLE_PVP = "Haz clic derecho para mostrar o ocultar el cuadro de JcJ."
L.CLICK_TOGGLE_RAIDS = "Alt-clic para mostrar o ocultar el buscador de bandas."
L.CLICK_TOGGLE_SCENARIOS = "Ctrl+clic para mostrar o ocultar el cuadro de gestas."
L.LFG = "BDG"

return end

------------------------------------------------------------------------
-- French
------------------------------------------------------------------------

if CURRENT_LOCALE == "frFR" then

L.CLICK_TOGGLE_DUNGEONS = "Cliquer pour afficher ou fermer la Cadre des donjons"
L.CLICK_TOGGLE_PETJOURNAL = "Clic milieu ou clic-maj pour afficher/fermer le Codex des mascottes."
L.CLICK_TOGGLE_PVP = "Clic droit pour afficher ou fermer le Panneau JcJ."
L.CLICK_TOGGLE_RAIDS = "Clic-alt pour afficher ou fermer la Formation de raid."
L.CLICK_TOGGLE_SCENARIOS = "Clic-ctrl pour afficher/fermer le Panneau des Scénarios."
L.LFG = "RdG"

return end

------------------------------------------------------------------------
-- Italian
------------------------------------------------------------------------

if CURRENT_LOCALE == "itIT" then

L.CLICK_TOGGLE_DUNGEONS = "Clicca per mostrare o nascondere il ricerca delle istanze."
L.CLICK_TOGGLE_PETJOURNAL = "Clicca medio o Maiusc-clicca per mostrare o nascondere il diario delle mascotte."
L.CLICK_TOGGLE_PVP = "Clicca destro per mostrare o nascondere l'interfaccia del PvP."
L.CLICK_TOGGLE_RAIDS = "Alt-clicca per mostrare o nascondere il ricerca delle incursioni."
L.CLICK_TOGGLE_SCENARIOS = "Ctrl-clicca per mostrare o nascondere il pannello delle scenari."
L.LFG = "CG"

return end

------------------------------------------------------------------------
-- Brazilian Portuguese
------------------------------------------------------------------------

if CURRENT_LOCALE == "ptBR" then

L.CLICK_TOGGLE_DUNGEONS = "Clique para mostrar ou ocultar o Localizador de masmorras."
L.CLICK_TOGGLE_PETJOURNAL = "Meio-clique ou shift-clique para mostrar ou ocultar o Diário de Mascotes."
L.CLICK_TOGGLE_PVP = "Direito-clique para mostrar ou ocultar o quadro de JxJ."
L.CLICK_TOGGLE_RAIDS = "Alt-clique para mostrar ou ocultar o Localizador de raides."
L.CLICK_TOGGLE_SCENARIOS = "Ctrl-clique para mostrar ou ocultar o Localizador de cenários."
L.LFG = "PG"

return end

------------------------------------------------------------------------
-- Russian
------------------------------------------------------------------------

if CURRENT_LOCALE == "ruRU" then

L.CLICK_TOGGLE_DUNGEONS = "Щелкните для открытия Поиск подземелий."
L.CLICK_TOGGLE_PETJOURNAL = "Щелкните средней кнопкой мыши или Shift-клик для открытия Транспорт и питомцы."
L.CLICK_TOGGLE_PVP = "Щелкните правой кнопкой мыши для открытия Окно PvP."
L.CLICK_TOGGLE_RAIDS = "Alt-клик для открытия Поиск рейда."
L.CLICK_TOGGLE_SCENARIOS = "Ctrl-клик для открытия Сценарии."
L.LFG = "ЛФГ"

return end

------------------------------------------------------------------------
-- Korean
------------------------------------------------------------------------

if CURRENT_LOCALE == "koKR" then

L.CLICK_TOGGLE_DUNGEONS = "클릭 하면 던전 찾기 창을 켜거나 끕니다."
L.CLICK_TOGGLE_PETJOURNAL = "가운데클릭 또는 쉬프트클릭 하면 애완동물 도감 창을 켜거나 끕니다."
L.CLICK_TOGGLE_PVP = "오른쪽클릭 하면 명예창 창을 켜거나 끕니다."
L.CLICK_TOGGLE_RAIDS = "ALT클릭 하면 공격대 찾기 창을 켜거나 끕니다."
L.CLICK_TOGGLE_SCENARIOS = "CTRL클릭 하면 시나리오 창을 켜거나 끕니다."
L.LFG = "던전 찾기"

return end

------------------------------------------------------------------------
-- Simplified Chinese
------------------------------------------------------------------------

if CURRENT_LOCALE == "zhCN" then

L.CLICK_TOGGLE_DUNGEONS = "左键点击进入副本工具窗口。"
L.CLICK_TOGGLE_PETJOURNAL = "中键点击或shift+左键点击打开宠物手册。"
L.CLICK_TOGGLE_PVP = "右键点击打开PVP窗口。"
L.CLICK_TOGGLE_RAIDS = "Alt+左键点击进入团队浏览器窗口。"
L.CLICK_TOGGLE_SCENARIOS = "按住Ctrl键单击打开/关闭场景战役查找。"
L.LFG = "寻求组队"

return end

------------------------------------------------------------------------
-- Traditional Chinese
------------------------------------------------------------------------

if CURRENT_LOCALE == "zhTW" then

L.CLICK_TOGGLE_DUNGEONS = "點擊顯示地城搜尋視窗."
L.CLICK_TOGGLE_PETJOURNAL = "中鍵點擊或Shift+左鍵點擊打開寵物手冊。"
L.CLICK_TOGGLE_PVP = "右键单击打开/关闭PVP窗口。"
L.CLICK_TOGGLE_RAIDS = "按住Alt键单击打开/关闭瀏覽團隊窗口。"
L.CLICK_TOGGLE_SCENARIOS = "按住Ctrl键单击打开/关闭场景战役查找。"
L.LFG = "尋求組隊"

return end
