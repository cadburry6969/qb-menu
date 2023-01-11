local QBCore = exports['qb-core']:GetCoreObject()

local headerShown = false
local sendData = nil

-- Functions
local function openMenu(data)
    if not data or not next(data) then return end
	for _,v in pairs(data) do
		if v["icon"] then
			local img = "qb-inventory/html/"
			if QBCore.Shared.Items[tostring(v["icon"])] then
				if not string.find(QBCore.Shared.Items[tostring(v["icon"])].image, "images/") then
					img = img.."images/"
				end
				v["icon"] = img..QBCore.Shared.Items[tostring(v["icon"])].image
			end
		end
	end
    SetNuiFocus(true, true)
    headerShown = false
    sendData = data
    SendNUIMessage({
        action = 'OPEN_MENU',
        data = table.clone(data)
    })
end
exports('openMenu', openMenu)

local function closeMenu()
    sendData = nil
    headerShown = false
    SetNuiFocus(false)
    SendNUIMessage({
        action = 'CLOSE_MENU'
    })
end
exports('closeMenu', closeMenu)

local function showHeader(data)
    if not data or not next(data) then return end
    headerShown = true
    sendData = data
    SendNUIMessage({
        action = 'SHOW_HEADER',
        data = table.clone(data)
    })
end
exports('showHeader', showHeader)

RegisterNetEvent('qb-menu:client:openMenu', function(data)
    openMenu(data)
end)

RegisterNetEvent('qb-menu:client:closeMenu', function()
    closeMenu()
end)

RegisterNUICallback('clickedButton', function(option, cb)
    if headerShown then headerShown = false end
    PlaySoundFrontend(-1, 'Highlight_Cancel', 'DLC_HEIST_PLANNING_BOARD_SOUNDS', 1)
    SetNuiFocus(false)
    if sendData then
        local data = sendData[tonumber(option)]
        sendData = nil
        if data then
            if data.params.event then
                if data.params.isServer then
                    TriggerServerEvent(data.params.event, data.params.args)
                elseif data.params.isCommand then
                    ExecuteCommand(data.params.event)
                elseif data.params.isQBCommand then
                    TriggerServerEvent('QBCore:CallCommand', data.params.event, data.params.args)
                elseif data.params.isAction then
                    data.params.event(data.params.args)
                else
                    TriggerEvent(data.params.event, data.params.args)
                end
            end
        end
    end
    cb('ok')
end)

RegisterNUICallback('closeMenu', function(_, cb)
    headerShown = false
    sendData = nil
    SetNuiFocus(false)
    cb('ok')
end)

RegisterCommand('+menufocus', function()
    if headerShown then
        SetNuiFocus(true, true)
    end
end)
RegisterKeyMapping('+menufocus', 'Focus Menu', 'keyboard', 'LMENU')


RegisterCommand("menutest", function(source, args, raw)
    openMenu({
        {
            header = "Online Players",
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
        {
            header = "header title",
            txt = "description",
            params = {}
        },
        {
            header = "header title",
            txt = "description",
            params = {}
        },
        {
            header = "header title",
            txt = "description",
            params = {}
        },
        {
            header = "header title",
            txt = "description",
            params = {}
        },
        {
            header = "header title",
            txt = "description",
            params = {}
        },
        {
            header = "header title",
            txt = "description",
            params = {}
        },
        {
            header = "header title",
            txt = "description",
            params = {}
        },
        {
            header = "header title",
            txt = "description",
            params = {}
        },
        {
            header = "header title",
            txt = "description",
            params = {}
        },
        {
            header = "header title",
            txt = "description",
            params = {}
        },
        {
            header = "header title",
            txt = "description",
            params = {}
        },
        {
            header = "header title",
            txt = "description",
            params = {}
        },
        {
            header = "header title",
            txt = "description",
            params = {}
        },
        {
            header = "header title",
            txt = "description",
            params = {}
        },
        {
            header = "header title",
            txt = "description",
            params = {}
        },
        {
            header = "header title",
            txt = "description",
            params = {}
        },
        {
            header = "header title",
            txt = "description",
            params = {}
        },
        {
            header = "header title",
            txt = "description",
            params = {}
        },
        {
            header = "header title",
            txt = "description",
            params = {}
        },
        {
            header = "header title",
            txt = "description",
            disabled = true,
            params = {}
        },
    })
end)