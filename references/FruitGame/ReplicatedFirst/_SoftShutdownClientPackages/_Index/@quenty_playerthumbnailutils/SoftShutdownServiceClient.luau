 

local v1 = require(script.Parent.loader).load(script)
local u2 = game:GetService("Workspace")
local u3 = game:GetService("UserInputService")
local u4 = game:GetService("StarterGui")
local u5 = game:GetService("TeleportService")
local u6 = v1("AttributeValue")
local u7 = v1("Maid")
local u8 = v1("PlayerGuiUtils")
local u9 = v1("Rx")
local u10 = v1("SoftShutdownConstants")
local u11 = v1("SoftShutdownTranslator")
local u12 = v1("SoftShutdownUI")
local u13 = v1("RxValueBaseUtils")
local v14 = {}
local u15 = {
    Enum.CoreGuiType.PlayerList,
    Enum.CoreGuiType.Health,
    Enum.CoreGuiType.Backpack,
    Enum.CoreGuiType.Chat,
    Enum.CoreGuiType.EmotesMenu,
    Enum.CoreGuiType.All
}
function v14.Init(u16, p17) --[[ Line: 32 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u11
        [3] = u6
        [4] = u2
        [5] = u10
        [6] = u9
        [7] = u13
        [8] = u5
    --]]
    local v18 = not u16._serviceBag
    assert(v18, "Already initialized")
    u16._serviceBag = assert(p17, "No serviceBag")
    u16._maid = u7.new()
    u16._translator = u16._serviceBag:GetService(u11)
    u16._isLobby = u6.new(u2, u10.IS_SOFT_SHUTDOWN_LOBBY_ATTRIBUTE, false)
    u16._isUpdating = u6.new(u2, u10.IS_SOFT_SHUTDOWN_UPDATING_ATTRIBUTE, false)
    u16._localTeleportDataSaysIsLobby = Instance.new("BoolValue")
    u16._localTeleportDataSaysIsLobby.Value = false
    u16._maid:GiveTask(u16._localTeleportDataSaysIsLobby)
    u16._isArrivingAfterShutdown = Instance.new("BoolValue")
    u16._isArrivingAfterShutdown.Value = false
    u16._maid:GiveTask(u16._isArrivingAfterShutdown)
    task.spawn(function() --[[ Line: 50 ]]
        --[[
        Upvalues:
            [1] = u16
        --]]
        if u16:_queryLocalTeleportInfo() then
            u16._localTeleportDataSaysIsLobby.Value = true
        end
        if u16:_queryIsArrivingAfterShutdown() then
            u16._isArrivingAfterShutdown.Value = true
        end
    end)
    u16._maid:GiveTask(u9.combineLatest({
        ["isLobby"] = u16._isLobby:Observe(),
        ["isShuttingDown"] = u16._isUpdating:Observe(),
        ["localTeleportDataSaysIsLobby"] = u13.observeValue(u16._localTeleportDataSaysIsLobby),
        ["isArrivingAfterShutdown"] = u13.observeValue(u16._isArrivingAfterShutdown)
    }):Subscribe(function(p19) --[[ Line: 64 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u5
        --]]
        if p19.isLobby or p19.localTeleportDataSaysIsLobby then
            u16._maid._shutdownUI = nil
            if not u16._maid._lobbyUI then
                local v20 = u16._maid
                local v21, v22 = u16:_showSoftShutdownUI("shutdown.lobby.title", "shutdown.lobby.subtitle", true)
                v20._lobbyUI = v21
                u5:SetTeleportGui(v22)
                return
            end
        else
            if p19.isShuttingDown then
                local v23 = u16._maid
                local v24, v25 = u16:_showSoftShutdownUI("shutdown.restart.title", "shutdown.restart.subtitle")
                v23._shutdownUI = v24
                u5:SetTeleportGui(v25)
                u16._maid._lobbyUI = nil
                return
            end
            if p19.isArrivingAfterShutdown then
                local u26 = u16:_showSoftShutdownUI("shutdown.complete.title", "shutdown.complete.subtitle", true)
                u16._maid._shutdownUI = u26
                u16._maid._lobbyUI = nil
                task.delay(1, function() --[[ Line: 87 ]]
                    --[[
                    Upvalues:
                        [1] = u16
                        [2] = u26
                    --]]
                    if u16._maid._shutdownUI == u26 then
                        u16._maid._shutdownUI = nil
                    end
                end)
                return
            end
            u16._maid._shutdownUI = nil
            u16._maid._lobbyUI = nil
        end
    end))
end
function v14._queryIsArrivingAfterShutdown(_) --[[ Line: 99 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v27 = u5:GetLocalPlayerTeleportData()
    return type(v27) == "table" and v27.isSoftShutdownArrivingIntoUpdatedServer and true or false
end
function v14._queryLocalTeleportInfo(_) --[[ Line: 108 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v28 = u5:GetLocalPlayerTeleportData()
    return type(v28) == "table" and v28.isSoftShutdownReserveServer and true or false
end
function v14._showSoftShutdownUI(p29, p30, p31, p32) --[[ Line: 117 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u8
        [3] = u12
    --]]
    local v33 = u7.new()
    local u34 = u7.new()
    local v35 = Instance.new("ScreenGui")
    v35.Name = "SoftShutdownScreenGui"
    v35.ResetOnSpawn = false
    v35.AutoLocalize = false
    v35.IgnoreGuiInset = true
    v35.DisplayOrder = 10000000000
    v35.Parent = u8.getPlayerGui()
    v35.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    u34:GiveTask(v35)
    local u36 = u12.new()
    u34:GiveTask(u36)
    v33:GiveTask(function() --[[ Line: 135 ]]
        --[[
        Upvalues:
            [1] = u36
            [2] = u34
        --]]
        u36:Hide()
        task.delay(1, function() --[[ Line: 138 ]]
            --[[
            Upvalues:
                [1] = u34
            --]]
            u34:Destroy()
        end)
    end)
    p29:_hideCoreGuiUI(u34, v35)
    v33:GivePromise(p29._translator:PromiseFormatByKey(p31)):Then(function(p37) --[[ Line: 145 ]]
        --[[
        Upvalues:
            [1] = u36
        --]]
        u36:SetSubtitle(p37)
    end)
    v33:GivePromise(p29._translator:PromiseFormatByKey(p30)):Then(function(p38) --[[ Line: 149 ]]
        --[[
        Upvalues:
            [1] = u36
        --]]
        u36:SetTitle(p38)
    end)
    u36:Show(p32)
    u36.Gui.Parent = v35
    return v33, v35
end
function v14._hideCoreGuiUI(_, u39, u40) --[[ Line: 160 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u8
        [3] = u15
        [4] = u4
    --]]
    if not u3.ModalEnabled then
        u3.ModalEnabled = true
        u39:GiveTask(function() --[[ Line: 164 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            u3.ModalEnabled = false
        end)
    end
    local v41 = u8.getPlayerGui()
    local u42 = {}
    for _, v43 in pairs(v41:GetChildren()) do
        if v43:IsA("ScreenGui") and (v43 ~= u40 and v43.Enabled) then
            u42[v43] = v43
            v43.Enabled = false
        end
    end
    u39:GiveTask(v41.ChildAdded:Connect(function(p44) --[[ Line: 184 ]]
        --[[
        Upvalues:
            [1] = u40
            [2] = u42
        --]]
        if p44:IsA("ScreenGui") and (p44 ~= u40 and p44.Enabled) then
            u42[p44] = p44
            p44.Enabled = false
        end
    end))
    u39:GiveTask(v41.ChildRemoved:Connect(function(p45) --[[ Line: 188 ]]
        --[[
        Upvalues:
            [1] = u42
        --]]
        u42[p45] = nil
    end))
    u39:GiveTask(function() --[[ Line: 192 ]]
        --[[
        Upvalues:
            [1] = u42
        --]]
        for v46, _ in pairs(u42) do
            v46.Enabled = true
        end
    end)
    for _, u47 in pairs(u15) do
        task.spawn(function() --[[ Line: 199 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u47
                [3] = u39
            --]]
            if u4:GetCoreGuiEnabled(u47) then
                u4:SetCoreGuiEnabled(u47, false)
                u39:GiveTask(function() --[[ Line: 203 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u47
                    --]]
                    u4:SetCoreGuiEnabled(u47, true)
                end)
            end
        end)
    end
end
function v14.Destroy(p48) --[[ Line: 211 ]]
    p48._maid:DoCleaning()
end
return v14