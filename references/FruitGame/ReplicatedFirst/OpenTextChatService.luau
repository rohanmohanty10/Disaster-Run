 

local u1 = game:GetService("HttpService")
local u2 = game:GetService("LogService")
local u3 = game:GetService("TextChatService")
local u4 = game:GetService("UserInputService")
local u5 = game:GetService("ContentProvider")
local u6 = game:GetService("StarterGui")
local u7 = game:GetService("TweenService")
local u8 = game:GetService("TextService")
local u9 = game:GetService("Players")
local u10 = game:GetService("GuiService")
local u11 = game:GetService("RunService")
local u12 = game:GetService("ReplicatedStorage")
local v13 = game:GetService("ReplicatedFirst")
if not (script:IsDescendantOf(u12) or script:IsDescendantOf(v13)) then
    error("OpenTextChatService must be insatlled in ReplicatedStorage or ReplicatedFirst. Please refer to the usage guide.\nhttps://devforum.roblox.com/t/3605944")
end
local v14 = os.clock()
repeat
    task.wait()
until u3.ChatVersion == Enum.ChatVersion.TextChatService or os.clock() - v14 > 5
if u11:IsServer() then
    error("Attempt to use OpenTextChatService in a server context. This module is client-sided only.", 2)
end
if script:GetAttribute("Initialized") then
    error("OpenTextChatService has already been initialized in a different environment.", 2)
else
    script:SetAttribute("Initialized", true)
end
if not script:GetAttribute("Enabled") then
    return u3
end
local u15 = script:GetAttribute("Demo") == true
local u16 = script:GetAttribute("Debug") == true
local v17 = script.Modules
local u18 = script.Assets
local u19 = game.Players.LocalPlayer
local u20 = u19.PlayerGui
local u21 = require(v17.AutoComplete)
local v22 = require(v17.Util).WaitForChildWhichIsA
local u23 = v22(workspace, "Camera")
local u24 = script:FindFirstChild("DefaultBubbleChatConfiguration")
local u25 = script:FindFirstChild("TextChatConfiguration")
local u26 = v22(u3, "ChatWindowConfiguration")
local u27 = v22(u3, "ChatInputBarConfiguration")
local u28 = v22(u3, "ChannelTabsConfiguration")
local u29 = v22(u3, "BubbleChatConfiguration")
local u30 = u18.ExperienceChat
local u31 = u18.BubbleChat
local u32 = u30.appLayout
local u33 = u32.channelBar
local u34 = u32.chatInputBar
local u35 = u32.chatWindow
local v36 = u34.Background.Container.TextContainer
local u37 = v36.TargetChannelChip
local u38 = v36.TextBoxContainer
local u39 = v36.TextBoxContainer.TextBox
local u40 = u34.Background.Border
local u41 = u33.DropdownMenu.Border
local u42 = u33.HorizontalBar.ContentContainer
local u43 = u33.DropdownMenu.ScrollView
local u44 = u35.scrollingView.bottomLockedScrollView.RCTScrollView.RCTScrollContentView
local _ = u44["$layout"].Padding
local u45 = u34.AutocompleteDropdown
local u46 = u45.ScrollBarFrame.ScrollViewFrame.ScrollView
local u47 = u46.OffsetFrame
local u48 = {
    ["AutoScrollThreshold"] = 1,
    ["RayDown"] = Vector3.new(0, -10, 0),
    ["RaycastInterval"] = 0.25,
    ["Alignment"] = {
        [Enum.HorizontalAlignment] = {
            [Enum.HorizontalAlignment.Left] = Vector3.new(0, 8, 0),
            [Enum.HorizontalAlignment.Center] = Vector3.new(0.5, 0, 0.5),
            [Enum.HorizontalAlignment.Right] = Vector3.new(1, -8, 1)
        },
        [Enum.VerticalAlignment] = {
            [Enum.VerticalAlignment.Top] = Vector3.new(0, 4, 0),
            [Enum.VerticalAlignment.Center] = Vector3.new(0.5, 0, 0.5),
            [Enum.VerticalAlignment.Bottom] = Vector3.new(1, -4, 1)
        }
    },
    ["LongChatBounds"] = Vector2.new((1 / 0), (1 / 0)),
    ["BubbleChatBounds"] = Vector2.new(315, (1 / 0)),
    ["DisplayBubbleOffset"] = Vector3.new(0, 1, 0.1),
    ["ZeroVector2"] = Vector2.new(0, 0),
    ["CaretPadding"] = UDim.new(0, 8),
    ["NoPadding"] = UDim.new(0, 0),
    ["SpecialCharacters"] = { utf8.char(57344), utf8.char(57345), utf8.char(57346) },
    ["ColorSequenceWhite"] = ColorSequence.new(Color3.new(255, 255, 255)),
    ["NumberSequenceZero"] = NumberSequence.new(0),
    ["GuiInset"] = Vector2.new(58, 0),
    ["RBXAll"] = Instance.new("TextChannel")
}
u48.RBXAll.Name = "RBXAll"
local u49 = Instance.new("BindableEvent")
local u50 = u49.Event
local u51 = Instance.new("BindableEvent")
local _ = u51.Event
local u52 = Instance.new("BindableEvent")
local v53 = u52.Event
local u54 = Instance.new("BindableEvent")
local _ = u54.Event
local u55 = Instance.new("BindableEvent")
local v56 = u55.Event
function u48.KeyCodeToChar(p57) --[[ Line: 212 ]]
    if p57.Value >= 127 or p57.Value <= 33 then
        return p57.Name
    end
    local v58 = p57.Value
    return string.char(v58)
end
function u48.DeepPipe(p59, u60, u61) --[[ Line: 220 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    local v62 = u48.MultiConnection.new()
    for _, u63 in pairs(p59:GetDescendants()) do
        task.spawn(function() --[[ Line: 224 ]]
            --[[
            Upvalues:
                [1] = u60
                [2] = u63
                [3] = u63
            --]]
            u60.Instances[u63] = u60.new(u63)
        end)
    end
    if u61 ~= nil then
        u61()
    end
    v62:AddConnection(p59.DescendantAdded:Connect(function(p64) --[[ Line: 229 ]]
        --[[
        Upvalues:
            [1] = u60
            [2] = u61
        --]]
        if u60.Instances[p64] == nil then
            u60.Instances[p64] = u60.new(p64)
            if u61 ~= nil then
                u61()
            end
        end
    end))
    v62:AddConnection(p59.DescendantRemoving:Connect(function(p65) --[[ Line: 236 ]]
        --[[
        Upvalues:
            [1] = u60
            [2] = u61
        --]]
        if u60.Instances[p65] ~= nil then
            u60.Instances[p65]:CleanUp()
            u60.Instances[p65] = nil
            if u61 ~= nil then
                u61()
            end
        end
    end))
    return v62
end
function u48.Pipe(p66, u67, u68) --[[ Line: 247 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    local v69 = u48.MultiConnection.new()
    for _, u70 in pairs(p66:GetChildren()) do
        task.spawn(function() --[[ Line: 251 ]]
            --[[
            Upvalues:
                [1] = u67
                [2] = u70
                [3] = u70
            --]]
            u67.Instances[u70] = u67.new(u70)
        end)
    end
    if u68 ~= nil then
        u68()
    end
    v69:AddConnection(p66.ChildAdded:Connect(function(p71) --[[ Line: 256 ]]
        --[[
        Upvalues:
            [1] = u67
            [2] = u68
        --]]
        if u67.Instances[p71] == nil then
            u67.Instances[p71] = u67.new(p71)
            if u68 ~= nil then
                u68()
            end
        end
    end))
    v69:AddConnection(p66.ChildRemoved:Connect(function(p72) --[[ Line: 263 ]]
        --[[
        Upvalues:
            [1] = u67
            [2] = u68
        --]]
        if u67.Instances[p72] ~= nil then
            u67.Instances[p72]:CleanUp()
            u67.Instances[p72] = nil
            if u68 ~= nil then
                u68()
            end
        end
    end))
    return v69
end
function u48.Observe(p73, u74) --[[ Line: 274 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    local v75 = u48.MultiConnection.new()
    local u76 = {}
    for _, u77 in pairs(p73:GetChildren()) do
        spawn(function() --[[ Line: 278 ]]
            --[[
            Upvalues:
                [1] = u76
                [2] = u77
                [3] = u74
            --]]
            u76[u77] = u74(u77)
        end)
    end
    v75:AddConnection(p73.ChildAdded:Connect(function(p78) --[[ Line: 282 ]]
        --[[
        Upvalues:
            [1] = u76
            [2] = u74
        --]]
        u76[p78] = u74(p78)
    end))
    v75:AddConnection(p73.ChildRemoved:Connect(function(p79) --[[ Line: 285 ]]
        --[[
        Upvalues:
            [1] = u76
        --]]
        if u76[p79] ~= nil then
            u76[p79]()
            u76[p79] = nil
        end
    end))
    return v75
end
function u48.GetCoreGuiEnabled(p80) --[[ Line: 294 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    return u6:GetCoreGuiEnabled(p80)
end
function u48.SetCoreGuiEnabled(p81, p82) --[[ Line: 298 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    u6:SetCoreGuiEnabled(p81, p82)
end
function u48.GetCore(u83) --[[ Line: 302 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    local u84 = nil
    while true do
        local v85 = pcall(function() --[[ Line: 305 ]]
            --[[
            Upvalues:
                [1] = u84
                [2] = u6
                [3] = u83
            --]]
            u84 = u6:GetCore(u83)
        end)
        if not v85 then
            task.wait()
        end
        if v85 then
            return u84
        end
    end
end
function u48.SetCore(u86, u87) --[[ Line: 309 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    while true do
        local v88 = pcall(function() --[[ Line: 311 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u86
                [3] = u87
            --]]
            u6:SetCore(u86, u87)
        end)
        if not v88 then
            task.wait()
        end
        if v88 then
            return
        end
    end
end
u48.CoreGuiEnabled = u48.GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
function u48.GetChatCoreGuiEnabled() --[[ Line: 315 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    return u48.GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
end
function u48.SetChatCoreGuiEnabled(p89) --[[ Line: 319 ]]
    --[[
    Upvalues:
        [1] = u48
        [2] = u55
    --]]
    u48.SetCoreGuiEnabled(Enum.CoreGuiType.Chat, p89)
    if u48.CoreGuiEnabled ~= p89 then
        u48.CoreGuiEnabled = p89
        u55:Fire()
    end
end
u48.ChatActive = nil
function u48.GetChatActive() --[[ Line: 325 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    return u48.GetCore("ChatActive")
end
function u48.SetChatActive(p90) --[[ Line: 329 ]]
    --[[
    Upvalues:
        [1] = u48
        [2] = u52
    --]]
    u48.SetCore("ChatActive", p90)
    if u48.ChatActive ~= p90 then
        u48.ChatActive = p90
        u52:Fire()
    end
end
function u48.SetCoreGuiChatConnections() --[[ Line: 334 ]]
    --[[
    Upvalues:
        [1] = u48
        [2] = u49
        [3] = u51
        [4] = u54
    --]]
    local v91 = {
        ["ChatWindow"] = {
            ["ToggleVisibility"] = u49,
            ["SetVisible"] = u49,
            ["TopbarEnabledChanged"] = u49,
            ["CoreGuiEnabled"] = u49,
            ["VisibilityStateChanged"] = u51,
            ["MessagesChanged"] = u54
        }
    }
    u48.SetCore("CoreGuiChatConnections", v91)
end
function u48.CoreGuiChatConnectionsOwnership() --[[ Line: 338 ]]
    --[[
    Upvalues:
        [1] = u50
        [2] = u48
    --]]
    local u92 = false
    local v93 = u50:Connect(function() --[[ Line: 340 ]]
        --[[
        Upvalues:
            [1] = u92
        --]]
        u92 = true
    end)
    local v94 = u48.GetChatCoreGuiEnabled()
    u48.SetChatCoreGuiEnabled(not v94)
    u48.SetChatCoreGuiEnabled(v94)
    task.wait()
    v93:Disconnect()
    return u92
end
function u48.GetTextBounds(p95, p96, p97, p98, p99) --[[ Line: 349 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    local u100 = Instance.new("GetTextBoundsParams")
    u100.Font = p98
    u100.RichText = true
    u100.Size = p96
    u100.Text = p95
    u100.Width = p99.X
    local u101 = nil
    local v102
    if pcall(function() --[[ Line: 357 ]]
        --[[
        Upvalues:
            [1] = u101
            [2] = u8
            [3] = u100
        --]]
        u101 = u8:GetTextBoundsAsync(u100)
    end) then
        v102 = u101
    else
        if p97 == Enum.Font.Unknown or p97 == nil then
            p97 = Enum.Font.GothamBold
        end
        u101 = u8:GetTextSize(p95, p96, p97, p99)
        v102 = u101
    end
    return v102
end
function u48.TransparencyMask(p103, p104) --[[ Line: 365 ]]
    return (1 - p104) * p103 + p104
end
function u48.FilterSpecialCharacters(p105) --[[ Line: 369 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    for _, v106 in pairs(u48.SpecialCharacters) do
        p105 = string.gsub(p105, v106, "#")
    end
    return p105
end
function u48.GetAbsoluteSize(p107, p108, p109) --[[ Line: 375 ]]
    local v110 = p108.X.Offset + p108.X.Scale * p107.X
    local v111 = p108.Y.Offset + p108.Y.Scale * p107.Y
    local v112 = Vector2.new
    if p109 then
        local v113 = p109.MinSize.X
        local v114 = p109.MaxSize.X
        v110 = math.clamp(v110, v113, v114)
    end
    if p109 then
        local v115 = p109.MinSize.Y
        local v116 = p109.MaxSize.Y
        v111 = math.clamp(v111, v115, v116)
    end
    return v112(v110, v111)
end
function u48.LightAbsoluteSize(p117, p118, p119, p120, p121, p122) --[[ Line: 381 ]]
    local v123 = Vector2.new
    local v124 = p118.X.Offset + p118.X.Scale * p117.X
    local v125 = math.clamp(v124, p119 or 0, p120 or (1 / 0))
    local v126 = p118.Y.Offset + p118.Y.Scale * p117.Y
    return v123(v125, (math.clamp(v126, p121 or 0, p122 or (1 / 0))))
end
function u48.GetAbsolutePosition(p127, p128, p129, p130, p131, p132) --[[ Line: 385 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    local v133 = u48.GetAbsoluteSize(p127, p129, p132)
    return Vector2.new(p130.X.Offset + p130.X.Scale * p127.X, p130.Y.Offset + p130.Y.Scale * p127.Y) + p128 - Vector2.new(p131.X * v133.X, p131.Y * v133.Y)
end
function u48.GetViewportSize() --[[ Line: 391 ]]
    --[[
    Upvalues:
        [1] = u23
        [2] = u10
    --]]
    local v134 = u23.ViewportSize
    local v135 = table.pack(u10:GetGuiInset())
    return Vector2.new(v134.X - v135[1].X - v135[2].X, v134.Y - v135[1].Y - v135[2].Y)
end
function u48.LightViewportSize() --[[ Line: 397 ]]
    --[[
    Upvalues:
        [1] = u23
    --]]
    local v136 = u23.ViewportSize
    return Vector2.new(v136.X, v136.Y - 58)
end
u48.VirtualClassBuilder = {
    ["__type"] = "virtualClassBuilder"
}
function u48.VirtualClassBuilder.Build(p137, p138, p139) --[[ Line: 404 ]]
    if p137.Builders[p139.ClassName] ~= nil then
        p137.Builders[p139.ClassName](p138, p139)
    end
end
function u48.VirtualClassBuilder.Add(p140, p141, p142) --[[ Line: 409 ]]
    p140.Builders[p141] = p142
    return p140
end
function u48.VirtualClassBuilder.new() --[[ Line: 413 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    local v143 = {
        ["__index"] = u48.VirtualClassBuilder
    }
    local v144 = setmetatable({}, v143)
    v144.Builders = {}
    return v144
end
u48.VirtualConnection = {
    ["__type"] = "virtualConnection"
}
function u48.VirtualConnection.Disconnect(p145) --[[ Line: 421 ]]
    for v146, v147 in pairs(p145.virtualEvent.__connections) do
        if v147 == p145 then
            p145.virtualEvent.__connections[v146] = nil
        end
    end
end
function u48.VirtualConnection.new(p148, p149) --[[ Line: 424 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    local v150 = {
        ["__index"] = u48.VirtualBindable
    }
    return setmetatable({
        ["__connections"] = {},
        ["__virtualBindable"] = p148,
        ["__function"] = p149
    }, v150)
end
u48.VirtualEvent = {
    ["__type"] = "virtualEvent"
}
function u48.VirtualEvent.Destroy(p151) --[[ Line: 429 ]]
    p151.__connections = {}
end
function u48.VirtualEvent.Connect(p152, p153) --[[ Line: 432 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    local v154 = u48.VirtualConnection.new(p152, p153)
    local v155 = p152.__connections
    table.insert(v155, v154)
    return v154
end
function u48.VirtualEvent.Fire(p156, ...) --[[ Line: 437 ]]
    local v157 = table.pack(...)
    for _, v158 in pairs(p156.__connections) do
        task.spawn(v158.__function, table.unpack(v157))
    end
end
function u48.VirtualEvent.new() --[[ Line: 443 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    local v159 = {
        ["__index"] = u48.VirtualEvent
    }
    return setmetatable({
        ["__connections"] = {}
    }, v159)
end
function u48.MethodCall(u160, u161) --[[ Line: 448 ]]
    return function(_, ...) --[[ Line: 449 ]]
        --[[
        Upvalues:
            [1] = u160
            [2] = u161
        --]]
        return u160[u161](u160, ...)
    end
end
function u48.IsVirtual(p162) --[[ Line: 454 ]]
    return typeof(p162) == "table" and p162.__type == "virtualClass"
end
u48.VirtualClass = {
    ["__type"] = "virtualClass"
}
function u48.VirtualClass.__cleanup(p163) --[[ Line: 464 ]]
    p163.__clean = true
end
function u48.VirtualClass.__call(p164) --[[ Line: 467 ]]
    return p164:GetInstance()
end
function u48.VirtualClass.GetInstance(p165) --[[ Line: 470 ]]
    return p165.__mirror
end
function u48.VirtualClass.__unm(p166) --[[ Line: 473 ]]
    return p166:GetInstance()
end
function u48.VirtualClass.__tostring(p167) --[[ Line: 476 ]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u1
    --]]
    if u16 then
        local v168 = u1
        return tostring(v168:JSONEncode(p167))
    else
        local v169 = p167.__mirror
        return ("%* (Virtual)"):format((tostring(v169)))
    end
end
function u48.VirtualClass.__index(p170, p171) --[[ Line: 479 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    local v172 = getmetatable(p170)
    if rawget(v172, p171) == nil then
        if rawget(p170, p171) == nil then
            if p170.__getters[p171] == nil then
                if p170.__getters.FindFirstChild ~= nil then
                    local v173 = p170.__getters.FindFirstChild(p170)(p170, p171)
                    if v173 ~= nil then
                        return v173
                    end
                end
                local v174 = p170.__mirror[p171]
                if typeof(v174) == "function" and debug.info(v174, "n") ~= "" then
                    return u48.MethodCall(p170.__mirror, p171)
                else
                    return v174
                end
            else
                return p170.__getters[p171](p170, p171)
            end
        else
            return rawget(p170, p171)
        end
    else
        return rawget(v172, p171)
    end
end
function u48.VirtualClass.__newindex(p175, p176, p177) --[[ Line: 502 ]]
    if p175.__setters[p176] == nil then
        p175.__mirror[p176] = p177
    else
        local v178 = p175.__setters[p176](p175, p176, p177)
        local v179 = v178 == nil and true or v178
        if p175.__signals[p176] ~= nil then
            if p175.__signals[p176].Bindable ~= nil and v179 then
                p175.__signals[p176].Bindable:Fire()
            end
            p175.__changedBindable:Fire(p176)
            return
        end
    end
end
function u48.VirtualClass.__addgetter(p180, p181, p182) --[[ Line: 516 ]]
    p180.__getters[p181] = p182
    return p180
end
function u48.VirtualClass.__addsetter(p183, p184, p185) --[[ Line: 520 ]]
    p183.__setters[p184] = p185
    return p183
end
function u48.VirtualClass.__addsignal(p186, p187, p188) --[[ Line: 524 ]]
    local v189
    if p188 == nil then
        v189 = Instance.new("BindableEvent")
        p188 = v189.Event
    else
        v189 = nil
    end
    if p186.__signals[p187] == nil then
        p186.__signals[p187] = {
            ["Signal"] = p188,
            ["Bindable"] = v189
        }
    end
    return p186
end
function u48.VirtualClass.GetPropertyChangedSignal(p190, p191) --[[ Line: 530 ]]
    if p190.__signals[p191] == nil or rawget(p190, "__clean") == true then
        return p190.__mirror:GetPropertyChangedSignal(p191)
    else
        return p190.__signals[p191].Signal
    end
end
function u48.VirtualClass.new(p192) --[[ Line: 537 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    local u193 = {
        ["__changedBindable"] = Instance.new("BindableEvent")
    }
    u193.Changed = u193.__changedBindable.Event
    p192.Changed:Connect(function(p194) --[[ Line: 541 ]]
        --[[
        Upvalues:
            [1] = u193
        --]]
        u193.__changedBindable:Fire(p194)
    end)
    u193.__mirror = p192
    u193.__class = {}
    u193.__getters = {}
    u193.__setters = {}
    u193.__signals = {}
    local v195 = u48.VirtualClass
    return setmetatable(u193, v195)
end
u48.VirtualTree = {}
function u48.VirtualTree.__cleanup(p196) --[[ Line: 553 ]]
    for _, v197 in pairs(p196.__connections) do
        v197:Disconnect()
    end
end
function u48.VirtualTree.__autoresolve(p198, p199) --[[ Line: 556 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    if u48.IsVirtual(p199) then
        if p198.__autoresolveclasses == nil or not table.find(p198.__autoresolveclasses, p199.ClassName) then
            return p199.__mirror
        else
            return p199
        end
    else
        return p199
    end
end
function u48.VirtualTree.__adddefaults(u200, u201) --[[ Line: 565 ]]
    --[[
    Upvalues:
        [1] = u48
        [2] = u1
    --]]
    rawset(u201, "__util", {})
    rawset(u201, "__connections", {})
    rawset(u201, "__coroutines", {})
    rawset(u201, "__waitbindables", {})
    rawset(u201, "__cleanup", function(p202) --[[ Line: 571 ]]
        rawset(p202, "__clean", true)
        for _, v203 in pairs(p202.__connections) do
            v203:Disconnect()
        end
        for _, v204 in pairs(p202.__coroutines) do
            task.cancel(v204)
        end
        for v205, _ in pairs(p202.__waitbindables) do
            p202.__waitbindables[v205]:Fire()
            p202.__waitbindables[v205]:Destroy()
        end
        p202.__connections = {}
        p202.__coroutines = {}
        p202.__waitbindables = {}
    end)
    u201.__util.AncestryChanged = u48.VirtualEvent.new()
    u201.__util.DescendantAdded = u48.VirtualEvent.new()
    u201.__util.DescendantRemoving = u48.VirtualEvent.new()
    u201.__util.DescendantChanged = u48.VirtualEvent.new()
    u201.__util.ChildAdded = u48.VirtualEvent.new()
    u201.__util.ChildRemoved = u48.VirtualEvent.new()
    u201.__util.ChildChanged = u48.VirtualEvent.new()
    u201:__addgetter("AncestryChanged", function() --[[ Line: 589 ]]
        --[[
        Upvalues:
            [1] = u201
        --]]
        return u201.__util.AncestryChanged
    end)
    u201:__addsetter("AncestryChanged", function(_, p206) --[[ Line: 590 ]]
        --[[
        Upvalues:
            [1] = u201
        --]]
        error(("%* is not a valid member of %* \"%*\""):format(p206, u201.__mirror.ClassName, u201.__mirror.Name), 2)
    end)
    u201:__addgetter("DescendantAdded", function() --[[ Line: 591 ]]
        --[[
        Upvalues:
            [1] = u201
        --]]
        return u201.__util.DescendantAdded
    end)
    u201:__addsetter("DescendantAdded", function(_, p207) --[[ Line: 592 ]]
        --[[
        Upvalues:
            [1] = u201
        --]]
        error(("%* is not a valid member of %* \"%*\""):format(p207, u201.__mirror.ClassName, u201.__mirror.Name), 2)
    end)
    u201:__addgetter("DescendantRemoving", function() --[[ Line: 593 ]]
        --[[
        Upvalues:
            [1] = u201
        --]]
        return u201.__util.DescendantRemoving
    end)
    u201:__addsetter("DescendantRemoving", function(_, p208) --[[ Line: 594 ]]
        --[[
        Upvalues:
            [1] = u201
        --]]
        error(("%* is not a valid member of %* \"%*\""):format(p208, u201.__mirror.ClassName, u201.__mirror.Name), 2)
    end)
    u201:__addgetter("ChildAdded", function() --[[ Line: 595 ]]
        --[[
        Upvalues:
            [1] = u201
        --]]
        return u201.__util.ChildAdded
    end)
    u201:__addsetter("ChildAdded", function(_, p209) --[[ Line: 596 ]]
        --[[
        Upvalues:
            [1] = u201
        --]]
        error(("%* is not a valid member of %* \"%*\""):format(p209, u201.__mirror.ClassName, u201.__mirror.Name), 2)
    end)
    u201:__addgetter("ChildRemoved", function() --[[ Line: 597 ]]
        --[[
        Upvalues:
            [1] = u201
        --]]
        return u201.__util.ChildRemoved
    end)
    u201:__addsetter("ChildRemoved", function(_, p210) --[[ Line: 598 ]]
        --[[
        Upvalues:
            [1] = u201
        --]]
        error(("%* is not a valid member of %* \"%*\""):format(p210, u201.__mirror.ClassName, u201.__mirror.Name), 2)
    end)
    rawset(u201, "__parent", function(p211) --[[ Line: 599 ]]
        --[[
        Upvalues:
            [1] = u200
        --]]
        if p211.__mirror.Parent == nil then
            return nil
        else
            return u200.__descendants[p211.__mirror.Parent]
        end
    end)
    u201:__addgetter("Parent", function(p212) --[[ Line: 603 ]]
        --[[
        Upvalues:
            [1] = u200
        --]]
        return u200:__autoresolve(p212:__parent())
    end)
    u201:__addsetter("Parent", function(p213, p214) --[[ Line: 606 ]]
        --[[
        Upvalues:
            [1] = u48
        --]]
        if u48.IsVirtual(p214) then
            p214 = p214.__mirror
        end
        p213.__mirror.Parent = p214
    end)
    rawset(u201, "__getchildren", function(p215) --[[ Line: 610 ]]
        --[[
        Upvalues:
            [1] = u200
        --]]
        local v216 = {}
        for _, v217 in pairs(p215.__mirror:GetChildren()) do
            local v218 = u200.__descendants[v217]
            table.insert(v216, v218)
        end
        return v216
    end)
    u201:__addgetter("GetChildren", function(u219) --[[ Line: 617 ]]
        --[[
        Upvalues:
            [1] = u200
        --]]
        return function(_) --[[ Line: 618 ]]
            --[[
            Upvalues:
                [1] = u219
                [2] = u200
            --]]
            local v220 = u219:__getchildren()
            for v221, v222 in pairs(v220) do
                v220[v221] = u200:__autoresolve(v222)
            end
            return v220
        end
    end)
    rawset(u201, "__findfirstchild", function(p223, p224, p225) --[[ Line: 624 ]]
        for _, v226 in pairs(p223:__getchildren()) do
            if v226.Name == p224 then
                return v226
            end
        end
        if p225 then
            for _, v227 in pairs(p223:__getchildren()) do
                local v228 = v227:__findfirstchild(p224, p225)
                if v228 ~= nil then
                    return v228
                end
            end
        end
    end)
    u201:__addgetter("FindFirstChild", function(u229) --[[ Line: 633 ]]
        --[[
        Upvalues:
            [1] = u200
        --]]
        return function(_, p230, p231) --[[ Line: 634 ]]
            --[[
            Upvalues:
                [1] = u200
                [2] = u229
            --]]
            return u200:__autoresolve(u229:__findfirstchild(p230, p231))
        end
    end)
    rawset(u201, "__findfirstchildofclass", function(p232, p233) --[[ Line: 638 ]]
        for _, v234 in pairs(p232:__getchildren()) do
            if v234.ClassName == p233 then
                return v234
            end
        end
    end)
    u201:__addgetter("FindFirstChildOfClass", function(u235) --[[ Line: 641 ]]
        --[[
        Upvalues:
            [1] = u200
        --]]
        return function(_, p236) --[[ Line: 642 ]]
            --[[
            Upvalues:
                [1] = u200
                [2] = u235
            --]]
            return u200:__autoresolve(u235:__findfirstchildofclass(p236))
        end
    end)
    rawset(u201, "__findfirstchildwhichisa", function(p237, p238, p239) --[[ Line: 646 ]]
        for _, v240 in pairs(p237:__getchildren()) do
            if v240:IsA(p238) then
                return v240
            end
        end
        if p239 then
            for _, v241 in pairs(p237:__getchildren()) do
                local v242 = v241:__findfirstchildwhichisa(p238, p239)
                if v242 ~= nil then
                    return v242
                end
            end
        end
    end)
    u201:__addgetter("FindFirstChildWhichIsA", function(u243) --[[ Line: 655 ]]
        --[[
        Upvalues:
            [1] = u200
        --]]
        return function(_, p244, p245) --[[ Line: 656 ]]
            --[[
            Upvalues:
                [1] = u200
                [2] = u243
            --]]
            return u200:__autoresolve(u243:__findfirstchildwhichisa(p244, p245))
        end
    end)
    local function v249(p246, p247) --[[ Line: 660 ]]
        --[[
        Upvalues:
            [1] = u48
            [2] = u200
        --]]
        if not u48.IsVirtual(p247) then
            p247 = u200.__descendants[p247]
        end
        local v248 = p246.Parent
        while v248 ~= nil do
            if v248 == p247 then
                return true
            end
            v248 = v248.Parent
        end
        return false
    end
    rawset(u201, "__isdescendantof", v249)
    u201:__addgetter("IsDescendantOf", function(u250) --[[ Line: 669 ]]
        return function(_, p251) --[[ Line: 670 ]]
            --[[
            Upvalues:
                [1] = u250
            --]]
            return u250:__isdescendantof(p251)
        end
    end)
    local function v254(p252, p253) --[[ Line: 674 ]]
        --[[
        Upvalues:
            [1] = u48
            [2] = u200
        --]]
        if not u48.IsVirtual(p253) then
            p253 = u200.__descendants[p253]
        end
        if p253 == nil then
            return false
        else
            return p253:__isdescendantof(p252)
        end
    end
    rawset(u201, "__isancestorof", v254)
    u201:__addgetter("IsAncestorOf", function(u255) --[[ Line: 679 ]]
        return function(_, p256) --[[ Line: 680 ]]
            --[[
            Upvalues:
                [1] = u255
            --]]
            return u255:__isancestorof(p256)
        end
    end)
    rawset(u201, "__getdescendants", function(u257) --[[ Line: 684 ]]
        local u258 = {}
        local function u262(p259) --[[ Line: 686 ]]
            --[[
            Upvalues:
                [1] = u257
                [2] = u258
                [3] = u262
            --]]
            if p259 ~= u257 then
                local v260 = u258
                table.insert(v260, p259)
            end
            for _, v261 in pairs(p259:__getchildren()) do
                u262(v261)
            end
        end
        if u257 ~= u257 then
            table.insert(u258, u257)
        end
        for _, v263 in pairs(u257:__getchildren()) do
            u262(v263)
        end
        return u258
    end)
    u201:__addgetter("GetDescendants", function(u264) --[[ Line: 693 ]]
        --[[
        Upvalues:
            [1] = u200
        --]]
        return function(_) --[[ Line: 694 ]]
            --[[
            Upvalues:
                [1] = u264
                [2] = u200
            --]]
            local v265 = u264:__getdescendants()
            for v266, v267 in pairs(v265) do
                v267[v266] = u200:__autoresolve(v267)
            end
            return v265
        end
    end)
    rawset(u201, "__findfirstancestor", function(p268, p269) --[[ Line: 700 ]]
        local v270 = p268:__parent()
        while v270 ~= nil do
            if v270.Name == p269 then
                return v270
            end
            v270 = v270.Parent
        end
    end)
    u201:__addgetter("FindFirstAncestor", function(u271) --[[ Line: 707 ]]
        --[[
        Upvalues:
            [1] = u200
        --]]
        return function(_, p272) --[[ Line: 708 ]]
            --[[
            Upvalues:
                [1] = u200
                [2] = u271
            --]]
            return u200:__autoresolve(u271:__findfirstancestor(p272))
        end
    end)
    rawset(u201, "__findfirstancestorofclass", function(p273, p274) --[[ Line: 712 ]]
        local v275 = p273:__parent()
        while v275 ~= nil do
            if v275.ClassName == p274 then
                return v275
            end
            v275 = v275.Parent
        end
    end)
    u201:__addgetter("FindFirstAncestorOfClass", function(u276) --[[ Line: 719 ]]
        --[[
        Upvalues:
            [1] = u200
        --]]
        return function(_, p277) --[[ Line: 720 ]]
            --[[
            Upvalues:
                [1] = u200
                [2] = u276
            --]]
            return u200:__autoresolve(u276:__findfirstancestorofclass(p277))
        end
    end)
    rawset(u201, "__findfirstancestorwhichisa", function(p278, _) --[[ Line: 724 ]]
        local v279 = p278:__parent()
        while v279 ~= nil do
            if v279:IsA("ClassName") then
                return v279
            end
            v279 = v279.Parent
        end
    end)
    u201:__addgetter("FindFirstAncestorWhichIsA", function(u280) --[[ Line: 731 ]]
        --[[
        Upvalues:
            [1] = u200
        --]]
        return function(_, p281) --[[ Line: 732 ]]
            --[[
            Upvalues:
                [1] = u200
                [2] = u280
            --]]
            return u200:__autoresolve(u280:__findfirstancestorwhichisa(p281))
        end
    end)
    local function v292(u282, u283, p284) --[[ Line: 738 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local u285 = u282:FindFirstChild(u283)
        if u285 ~= nil then
            return u285
        end
        local u286 = u1:GenerateGUID(false)
        local v287 = u1:GenerateGUID(false)
        local v288 = u1:GenerateGUID(false)
        local v289 = u1:GenerateGUID(false)
        u282.__waitbindables[u286] = Instance.new("BindableEvent")
        u282.__connections[v288] = u282.__util.ChildAdded:Connect(function(p290) --[[ Line: 747 ]]
            --[[
            Upvalues:
                [1] = u283
                [2] = u285
                [3] = u282
                [4] = u286
            --]]
            if p290.Name == u283 then
                u285 = p290
                u282.__waitbindables[u286]:Fire()
            end
        end)
        u282.__connections[v287] = u282.__util.ChildChanged:Connect(function(p291, _) --[[ Line: 748 ]]
            --[[
            Upvalues:
                [1] = u283
                [2] = u285
                [3] = u282
                [4] = u286
            --]]
            if p291.Name == u283 then
                u285 = p291
                u282.__waitbindables[u286]:Fire()
            end
        end)
        if p284 == (1 / 0) or tostring(p284) == "nan" then
            p284 = nil
        end
        if p284 ~= nil then
            u282.__coroutines[v289] = task.delay(p284, u282.__waitbindables[u286].Fire, u282.__waitbindables[u286])
        end
        u282.__waitbindables[u286].Event:Wait()
        if u282.__waitbindables[u286] ~= nil then
            u282.__waitbindables[u286]:Destroy()
            u282.__waitbindables[u286] = nil
        end
        if u282.__connections[v288] ~= nil then
            u282.__connections[v288]:Disconnect()
            u282.__connections[v288] = nil
        end
        if u282.__connections[v287] ~= nil then
            u282.__connections[v287]:Disconnect()
            u282.__connections[v287] = nil
        end
        if p284 ~= nil and u282.__coroutines[v289] ~= nil then
            task.cancel(u282.__coroutines[v289])
            u282.__coroutines[v289] = nil
        end
        return u285
    end
    rawset(u201, "__waitforchild", v292)
    u201:__addgetter("WaitForChild", function(u293) --[[ Line: 766 ]]
        --[[
        Upvalues:
            [1] = u200
        --]]
        return function(_, p294, p295) --[[ Line: 767 ]]
            --[[
            Upvalues:
                [1] = u200
                [2] = u293
            --]]
            return u200:__autoresolve(u293:__waitforchild(p294, p295))
        end
    end)
    u201.__connections.AncestryChanged = u201.__mirror.AncestryChanged:Connect(function(p296, p297) --[[ Line: 772 ]]
        --[[
        Upvalues:
            [1] = u201
            [2] = u200
            [3] = u200
        --]]
        u201.__util.AncestryChanged:Fire(u200:__autoresolve(u200.__descendants[p296]), u200.__descendants[p297])
    end)
    u201.__connections.DescendantRemoving = u201.__mirror.DescendantRemoving:Connect(function(p298) --[[ Line: 775 ]]
        --[[
        Upvalues:
            [1] = u201
            [2] = u200
            [3] = u200
        --]]
        u201.__util.DescendantRemoving:Fire(u200:__autoresolve(u200.__descendants[p298]))
    end)
    u201.__connections.ChildRemoved = u201.__mirror.ChildRemoved:Connect(function(p299) --[[ Line: 778 ]]
        --[[
        Upvalues:
            [1] = u201
            [2] = u200
            [3] = u200
        --]]
        u201.__util.ChildRemoved:Fire(u200:__autoresolve(u200.__descendants[p299]))
    end)
    u201.__connections.Changed = u201.Changed:Connect(function(p300) --[[ Line: 781 ]]
        --[[
        Upvalues:
            [1] = u200
            [2] = u201
        --]]
        u200:__descendantchanged(u201, p300, true)
    end)
    if u200.__virtualBuilder ~= nil then
        u200.__virtualBuilder:Build(u200, u201)
    end
end
function u48.VirtualTree.__descendantadded(p301, p302, p303) --[[ Line: 787 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    local v304 = p303 == nil and true or p303
    local v305 = u48.VirtualClass.new(p302)
    p301:__adddefaults(v305)
    p301.__descendants[v305.__mirror] = v305
    if v304 then
        local v306 = v305.Parent
        if u48.IsVirtual(v306) then
            v306.__util.ChildAdded:Fire(p301:__autoresolve(v305))
            while u48.IsVirtual(v306) do
                v306.__util.DescendantAdded:Fire(p301:__autoresolve(v305))
                v306 = v306.Parent
            end
        end
    end
end
function u48.VirtualTree.__descendantchanged(p307, p308, p309, p310) --[[ Line: 803 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    if p310 == nil and true or p310 then
        local v311 = p308.Parent
        if u48.IsVirtual(v311) then
            v311.__util.ChildChanged:Fire(p307:__autoresolve(p308), p309)
            while u48.IsVirtual(v311) do
                v311.__util.DescendantChanged:Fire(p307:__autoresolve(p308), p309)
                v311 = v311.Parent
            end
        end
    end
end
function u48.VirtualTree.__descendantremoving(u312, u313, p314) --[[ Line: 816 ]]
    local _ = p314 == nil
    local v315 = u312.__descendants[u313]
    if v315 ~= nil then
        v315:__cleanup()
        task.delay(0, function() --[[ Line: 821 ]]
            --[[
            Upvalues:
                [1] = u312
                [2] = u313
            --]]
            u312.__descendants[u313] = nil
        end)
    end
end
function u48.VirtualTree.__getdescedents(p316) --[[ Line: 823 ]]
    return p316.__descendants
end
function u48.VirtualTree.GetRoot(p317) --[[ Line: 826 ]]
    return p317.__root
end
function u48.VirtualTree.new(p318, p319, p320) --[[ Line: 829 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    local v321 = {
        ["__index"] = u48.VirtualTree
    }
    local u322 = setmetatable({}, v321)
    u322.__root = u48.VirtualClass.new(p318)
    u322.__connections = {}
    u322.__descendants = {}
    u322.__virtualBuilder = p319
    u322.__autoresolveclasses = p320
    u322.__descendants[p318] = u322.__root
    u322:__adddefaults(u322.__root)
    for _, v323 in pairs(u322.__root.__mirror:GetDescendants()) do
        u322:__descendantadded(v323, false)
    end
    u322.__connections.DescendantAdded = u322.__root.__mirror.DescendantAdded:Connect(function(p324) --[[ Line: 841 ]]
        --[[
        Upvalues:
            [1] = u322
        --]]
        u322:__descendantadded(p324)
    end)
    u322.__connections.DescendantRemoving = u322.__root.__mirror.DescendantRemoving:Connect(function(p325) --[[ Line: 842 ]]
        --[[
        Upvalues:
            [1] = u322
        --]]
        u322:__descendantremoving(p325)
    end)
    return u322
end
u25.Parent = u3
local u326 = u48.VirtualTree.new(u3, nil, {
    "ChatWindowConfiguration",
    "ChatInputBarConfiguration",
    "ChannelTabsConfiguration",
    "BubbleChatConfiguration",
    "TextChatService",
    "Configuration"
}):GetRoot()
local u327 = u326:FindFirstChild(u25.Name)
local u328 = u326:FindFirstChildWhichIsA("ChatWindowConfiguration")
local u329 = u326:FindFirstChildWhichIsA("ChatInputBarConfiguration")
local u330 = u326:FindFirstChildWhichIsA("ChannelTabsConfiguration")
local u331 = u326:FindFirstChildWhichIsA("BubbleChatConfiguration")
u327:__addgetter("OptionToViewUntranslatedMessage", function(_, p332) --[[ Line: 857 ]]
    --[[
    Upvalues:
        [1] = u25
    --]]
    return u25:GetAttribute(p332)
end)
u327:__addsetter("OptionToViewUntranslatedMessage", function(_, p333, p334) --[[ Line: 858 ]]
    --[[
    Upvalues:
        [1] = u25
    --]]
    u25:SetAttribute(p333, p334)
end)
u327:__addsignal("OptionToViewUntranslatedMessage", u25:GetAttributeChangedSignal("OptionToViewUntranslatedMessage"))
u327:__addgetter("BackgroundFadeOutTime", function(_, p335) --[[ Line: 860 ]]
    --[[
    Upvalues:
        [1] = u25
    --]]
    return u25:GetAttribute(p335)
end)
u327:__addsetter("BackgroundFadeOutTime", function(_, p336, p337) --[[ Line: 861 ]]
    --[[
    Upvalues:
        [1] = u25
    --]]
    u25:SetAttribute(p336, p337)
end)
u327:__addsignal("BackgroundFadeOutTime", u25:GetAttributeChangedSignal("BackgroundFadeOutTime"))
u327:__addgetter("TextFadeOutTime", function(_, p338) --[[ Line: 863 ]]
    --[[
    Upvalues:
        [1] = u25
    --]]
    return u25:GetAttribute(p338)
end)
u327:__addsetter("TextFadeOutTime", function(_, p339, p340) --[[ Line: 864 ]]
    --[[
    Upvalues:
        [1] = u25
    --]]
    u25:SetAttribute(p339, p340)
end)
u327:__addsignal("TextFadeOutTime", u25:GetAttributeChangedSignal("TextFadeOutTime"))
u327:__addgetter("MaxMessages", function(_, p341) --[[ Line: 866 ]]
    --[[
    Upvalues:
        [1] = u25
    --]]
    return u25:GetAttribute(p341)
end)
u327:__addsetter("MaxMessages", function(_, p342, p343) --[[ Line: 867 ]]
    --[[
    Upvalues:
        [1] = u25
    --]]
    u25:SetAttribute(p342, p343)
end)
u327:__addsignal("MaxMessages", u25:GetAttributeChangedSignal("MaxMessages"))
u327:__addgetter("FilterSpecialCharacters", function(_, p344) --[[ Line: 869 ]]
    --[[
    Upvalues:
        [1] = u25
    --]]
    return u25:GetAttribute(p344)
end)
u327:__addsetter("FilterSpecialCharacters", function(_, p345, p346) --[[ Line: 870 ]]
    --[[
    Upvalues:
        [1] = u25
    --]]
    u25:SetAttribute(p345, p346)
end)
u327:__addsignal("FilterSpecialCharacters", u25:GetAttributeChangedSignal("FilterSpecialCharacters"))
u327:__addgetter("OpenBubbleChatEnabled", function(p347, p348) --[[ Line: 872 ]]
    return p347.__class[p348]
end)
u327:__addsetter("OpenBubbleChatEnabled", function(_, _, _) --[[ Line: 873 ]]
    error("Unable to assign property OpenBubbleChatEnabled. Property is read only", 2)
end)
u327:__addsignal("OpenBubbleChatEnabled")
u327.__class.OpenBubbleChatEnabled = u25:GetAttribute("OpenBubbleChatEnabled")
u327:__addgetter("OpenTextChatEnabled", function(p349, p350) --[[ Line: 876 ]]
    return p349.__class[p350]
end)
u327:__addsetter("OpenTextChatEnabled", function(_, _, _) --[[ Line: 877 ]]
    error("Unable to assign property OpenBubbleChatEnabled. Property is read only", 2)
end)
u327:__addsignal("OpenTextChatEnabled")
u327.__class.OpenTextChatEnabled = u25:GetAttribute("OpenTextChatEnabled")
u326:__addgetter("ChatAbsolutePosition", function(_, _) --[[ Line: 882 ]]
    error("TextChatService.ChatAbsolutePosition is not accessible when TextChatConfiguration.OpenTextChatEnabled is set to false", 2)
end)
u326:__addsetter("ChatAbsolutePosition", function(_, _, _) --[[ Line: 883 ]]
    error("TextChatService.ChatAbsolutePosition is not accessible when TextChatConfiguration.OpenTextChatEnabled is set to false", 2)
end)
u326:__addsignal("ChatAbsolutePosition")
u326:__addgetter("ChatAbsoluteSize", function(_, _) --[[ Line: 885 ]]
    error("TextChatService.ChatAbsoluteSize is not accessible when TextChatConfiguration.OpenTextChatEnabled is set to false", 2)
end)
u326:__addsetter("ChatAbsoluteSize", function(_, _, _) --[[ Line: 886 ]]
    error("TextChatService.ChatAbsoluteSize is not accessible when TextChatConfiguration.OpenTextChatEnabled is set to false", 2)
end)
u326:__addsignal("ChatAbsoluteSize")
u326:__addgetter("ChatBackgroundFaded", function(_, _) --[[ Line: 888 ]]
    error("TextChatService.ChatBackgroundFaded is not accessible when TextChatConfiguration.OpenTextChatEnabled is set to false", 2)
end)
u326:__addsetter("ChatBackgroundFaded", function(_, _, _) --[[ Line: 889 ]]
    error("TextChatService.ChatBackgroundFaded is not accessible when TextChatConfiguration.OpenTextChatEnabled is set to false", 2)
end)
u326:__addsignal("ChatBackgroundFaded")
u326:__addgetter("ChatTextFaded", function(_, _) --[[ Line: 891 ]]
    error("TextChatService.ChatTextFaded is not accessible when TextChatConfiguration.OpenTextChatEnabled is set to false", 2)
end)
u326:__addsetter("ChatTextFaded", function(_, _, _) --[[ Line: 892 ]]
    error("TextChatService.ChatTextFaded is not accessible when TextChatConfiguration.OpenTextChatEnabled is set to false", 2)
end)
u326:__addsignal("ChatTextFaded")
u326:__addgetter("OpenChat", function(_) --[[ Line: 894 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    return function(_) --[[ Line: 894 ]]
        --[[
        Upvalues:
            [1] = u48
        --]]
        task.spawn(u48.SetChatActive, true)
    end
end)
u326:__addgetter("CloseChat", function(_) --[[ Line: 895 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    return function(_) --[[ Line: 895 ]]
        --[[
        Upvalues:
            [1] = u48
        --]]
        task.spawn(u48.SetChatActive, false)
    end
end)
u326:__addgetter("ChatVisible", function(_, _) --[[ Line: 896 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    warn("TextChatService.ChatVisible is deprecated, Please use TextChatService.ChatActive instead")
    return u48.ChatActive
end)
u326:__addsetter("ChatVisible", function(_, _, p351) --[[ Line: 897 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    warn("TextChatService.ChatVisible is deprecated, Please use TextChatService.ChatActive instead")
    if p351 then
        u48.SetChatActive(true)
    else
        u48.SetChatActive(false)
    end
end)
u326:__addsignal("ChatVisible", v53)
u326:__addgetter("ChatActive", function(_, _) --[[ Line: 899 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    return u48.ChatActive
end)
u326:__addsetter("ChatActive", function(_, _, p352) --[[ Line: 900 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    if p352 then
        task.spawn(u48.SetChatActive, true)
        u48.ChatActive = true
    else
        task.spawn(u48.SetChatActive, false)
        u48.ChatActive = false
    end
end)
u326:__addsignal("ChatActive", v53)
u326:__addgetter("CoreGuiEnabled", function(_, _) --[[ Line: 902 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    return u48.GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
end)
u326:__addsetter("CoreGuiEnabled", function(_, _, p353) --[[ Line: 903 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    if p353 then
        u48.SetChatCoreGuiEnabled(true)
    else
        u48.SetChatCoreGuiEnabled(false)
    end
end)
u326:__addsignal("CoreGuiEnabled", v56)
u326:__addgetter("CreateUserWhisperAsync", function(_) --[[ Line: 905 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    return function(_, p354) --[[ Line: 905 ]]
        --[[
        Upvalues:
            [1] = u48
        --]]
        return u48.CreateUserWhsiper(p354)
    end
end)
function u48.UpdateTextBox() --[[ Line: 907 ]]
    --[[
    Upvalues:
        [1] = u329
        [2] = u27
        [3] = u39
        [4] = u20
        [5] = u10
    --]]
    local v355 = u329.TextBox
    local v356 = u27
    if v355 == nil then
        if u39:IsDescendantOf(u20) and (u10:IsTenFootInterface() and u329.Enabled) then
            v355 = u39
        else
            v355 = nil
        end
    elseif not v355:IsDescendantOf(u20) then
        v355 = nil
    end
    v356.TextBox = v355
end
function u48.OwnsTextBox() --[[ Line: 913 ]]
    --[[
    Upvalues:
        [1] = u27
        [2] = u329
        [3] = u10
    --]]
    local v357
    if u27.TextBox == nil and u329.TextBox == nil then
        v357 = not u10:IsTenFootInterface()
    else
        v357 = false
    end
    return v357
end
u48.MultiConnection = {
    ["__type"] = "multiConnection"
}
function u48.MultiConnection.CleanUp(p358) --[[ Line: 919 ]]
    for _, v359 in pairs(p358.Connections) do
        v359:Disconnect()
    end
    p358.Connections = {}
end
function u48.MultiConnection.Disconnect(p360) --[[ Line: 923 ]]
    p360:CleanUp()
end
function u48.MultiConnection.AddConnection(p361, p362) --[[ Line: 926 ]]
    local v363 = p361.Connections
    table.insert(v363, p362)
    return p361
end
function u48.MultiConnection.new() --[[ Line: 930 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    local v364 = {
        ["__index"] = u48.MultiConnection
    }
    local v365 = setmetatable({}, v364)
    v365.Connections = {}
    return v365
end
u48.InstanceBind = {
    ["__type"] = "propertyBind"
}
function u48.InstanceBind.Disconnect(p366) --[[ Line: 937 ]]
    p366.Connection:Disconnect()
end
function u48.InstanceBind.Update(p367) --[[ Line: 940 ]]
    --[[
    Upvalues:
        [1] = u16
    --]]
    if u16 then
        local v368 = print
        local v369 = "InstanceBind"
        local v370 = p367.BindInstance:GetFullName()
        local v371 = p367.Properties
        local v372
        if p367.UpdateDependency == nil then
            v372 = nil
        else
            v372 = p367.UpdateDependency:GetFullName()
        end
        v368(v369, v370, v371, v372, p367.UpdateProperty)
    end
    p367.BindState = true
    for _, v373 in pairs(p367.Properties) do
        local v374 = p367.BindInstance[v373]
        for _, v375 in pairs(p367.UpdateInstances) do
            if v375[v373] ~= v374 then
                v375[v373] = v374
            end
        end
    end
    if p367.UpdateFunction ~= nil then
        p367.UpdateFunction()
    end
end
function u48.InstanceBind.CanUpdate(p376) --[[ Line: 953 ]]
    if p376.UpdateDependency == nil then
        return true
    end
    local v377 = p376.UpdateDependency[p376.UpdateProperty]
    local v378
    if v377 == nil or v377 == false then
        v378 = false
    else
        v378 = p376.BindState == false
    end
    return v378
end
function u48.InstanceBind.new(p379, p380, p381, p382, p383, u384) --[[ Line: 958 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    local v385 = {
        ["__index"] = u48.InstanceBind
    }
    local u386 = setmetatable({}, v385)
    u386.Properties = typeof(p380) ~= "table" and { p380 } or p380
    u386.BindState = true
    u386.BindInstance = p379
    u386.UpdateDependency = p382
    u386.UpdateProperty = u386.UpdateDependency ~= nil and (p383 or "Parent") or nil
    u386.UpdateInstances = typeof(p381) ~= "table" and { p381 } or p381
    u386.Connection = u48.MultiConnection.new()
    u386.UpdateFunction = u384 ~= nil and function() --[[ Line: 967 ]]
        --[[
        Upvalues:
            [1] = u384
            [2] = u386
        --]]
        u384(u386)
    end or nil
    for _, v387 in pairs(u386.Properties) do
        u386.Connection:AddConnection(u386.BindInstance:GetPropertyChangedSignal(v387):Connect(function() --[[ Line: 969 ]]
            --[[
            Upvalues:
                [1] = u386
            --]]
            u386.BindState = false
            if u386:CanUpdate() then
                u386:Update()
            end
        end))
    end
    if u386.UpdateDependency ~= nil then
        u386.Connection:AddConnection(u386.UpdateDependency:GetPropertyChangedSignal(u386.UpdateProperty):Connect(function() --[[ Line: 975 ]]
            --[[
            Upvalues:
                [1] = u386
            --]]
            if u386:CanUpdate() then
                u386:Update()
            end
        end))
    end
    u386:Update()
    return u386
end
u48.PropertyBind = {
    ["__type"] = "propertyBind"
}
function u48.PropertyBind.Disconnect(p388) --[[ Line: 984 ]]
    p388.Connection:Disconnect()
end
function u48.PropertyBind.Update(p389) --[[ Line: 987 ]]
    --[[
    Upvalues:
        [1] = u16
    --]]
    if u16 then
        local v390 = print
        local v391 = "PropertyBind"
        local v392 = p389.BindInstance:GetFullName()
        local v393 = p389.Properties
        local v394
        if p389.UpdateDependency == nil then
            v394 = nil
        else
            v394 = p389.UpdateDependency:GetFullName()
        end
        v390(v391, v392, v393, v394, p389.UpdateProperty)
    end
    p389.BindState = true
    p389.UpdateFunction()
end
function u48.PropertyBind.CanUpdate(p395) --[[ Line: 992 ]]
    if p395.UpdateDependency == nil then
        return true
    end
    local v396 = p395.UpdateDependency[p395.UpdateProperty]
    local v397
    if v396 == nil or v396 == false then
        v397 = false
    else
        v397 = p395.BindState == false
    end
    return v397
end
function u48.PropertyBind.new(p398, p399, p400, p401, u402) --[[ Line: 997 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    local v403 = {
        ["__index"] = u48.PropertyBind
    }
    local u404 = setmetatable({}, v403)
    u404.Properties = typeof(p399) ~= "table" and { p399 } or p399
    u404.BindState = true
    u404.BindInstance = p398
    u404.UpdateDependency = p400
    u404.UpdateProperty = u404.UpdateDependency ~= nil and (p401 or "Parent") or nil
    u404.UpdateFunction = u402 ~= nil and function() --[[ Line: 1004 ]]
        --[[
        Upvalues:
            [1] = u402
            [2] = u404
        --]]
        u402(u404)
    end or nil
    u404.Connection = u48.MultiConnection.new()
    for _, v405 in pairs(u404.Properties) do
        u404.Connection:AddConnection(u404.BindInstance:GetPropertyChangedSignal(v405):Connect(function() --[[ Line: 1007 ]]
            --[[
            Upvalues:
                [1] = u404
            --]]
            u404.BindState = false
            if u404:CanUpdate() then
                u404:Update()
            end
        end))
    end
    if u404.UpdateDependency ~= nil then
        u404.Connection:AddConnection(u404.UpdateDependency:GetPropertyChangedSignal(u404.UpdateProperty):Connect(function() --[[ Line: 1013 ]]
            --[[
            Upvalues:
                [1] = u404
            --]]
            if u404:CanUpdate() then
                u404:Update()
            end
        end))
    end
    return u404
end
u48.StyleBind = {}
function u48.StyleBind.Disconnect(p406) --[[ Line: 1021 ]]
    p406.Connection:Disconnect()
end
function u48.StyleBind.Add(p407, p408, p409) --[[ Line: 1024 ]]
    local v410 = p407.BindInstance[p407.Property]
    if typeof(p409) == "table" then
        local v411 = p407.Binds
        table.insert(v411, {
            ["Instance"] = p408,
            ["Properties"] = p409
        })
        for _, v412 in pairs(p409) do
            if p408[v412] ~= v410 then
                p408[v412] = v410
            end
        end
    else
        local v413 = p407.Binds
        table.insert(v413, {
            ["Instance"] = p408,
            ["Properties"] = { p409 }
        })
        if p408[p409] ~= v410 then
            p408[p409] = v410
            return p407
        end
    end
    return p407
end
function u48.StyleBind.UpdateBinds(p414) --[[ Line: 1035 ]]
    local v415 = p414.BindInstance[p414.Property]
    for _, v416 in pairs(p414.Binds) do
        for _, v417 in pairs(v416.Properties) do
            if v416.Instance[v417] ~= v415 then
                v416.Instance[v417] = v415
            end
        end
    end
    return p414
end
function u48.StyleBind.Update(p418) --[[ Line: 1046 ]]
    --[[
    Upvalues:
        [1] = u16
    --]]
    if u16 then
        local v419 = print
        local v420 = "StyleBind"
        local v421 = p418.BindInstance:GetFullName()
        local v422 = p418.Property
        local v423
        if p418.UpdateDependency == nil then
            v423 = nil
        else
            v423 = p418.UpdateDependency:GetFullName()
        end
        v419(v420, v421, v422, v423, p418.UpdateProperty)
    end
    p418.BindState = true
    p418:UpdateBinds()
end
function u48.StyleBind.CanUpdate(p424) --[[ Line: 1051 ]]
    if p424.UpdateDependency == nil then
        return true
    end
    local v425 = p424.UpdateDependency[p424.UpdateProperty]
    local v426
    if v425 == nil or v425 == false then
        v426 = false
    else
        v426 = p424.BindState == false
    end
    return v426
end
function u48.StyleBind.new(p427, p428, p429, p430) --[[ Line: 1056 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    local v431 = {
        ["__index"] = u48.StyleBind
    }
    local u432 = setmetatable({}, v431)
    u432.Property = p428
    u432.BindState = true
    u432.Binds = {}
    u432.BindInstance = p427
    u432.UpdateDependency = p429
    u432.UpdateProperty = u432.UpdateDependency ~= nil and (p430 or "Parent") or nil
    u432.Connection = u48.MultiConnection.new()
    u432.Connection:AddConnection(u432.BindInstance:GetPropertyChangedSignal(p428):Connect(function() --[[ Line: 1065 ]]
        --[[
        Upvalues:
            [1] = u432
        --]]
        u432.BindState = false
        if u432:CanUpdate() then
            u432:Update()
        end
    end))
    if u432.UpdateDependency ~= nil then
        u432.Connection:AddConnection(u432.UpdateDependency:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 1070 ]]
            --[[
            Upvalues:
                [1] = u432
            --]]
            if u432:CanUpdate() then
                u432:Update()
            end
        end))
    end
    return u432
end
u48.Transparency = {}
function u48.Transparency.Disconnect(p433) --[[ Line: 1078 ]]
    p433.FadedChangedBindable:Destroy()
    p433.TransparencyChangedBindable:Destroy()
    p433.Connection:Disconnect()
    return p433
end
function u48.Transparency.Add(p434, p435, p436) --[[ Line: 1084 ]]
    local v437 = typeof(p435) ~= "table" and { p435 } or p435
    for _, v438 in pairs(v437) do
        p434:Remove(v438)
        local v439
        if p436 == nil then
            v439 = Instance.new("UIGradient")
            v439.Parent = v438
            v439.Name = "Transparency"
            v439.Transparency = NumberSequence.new(p434.Transparency)
        else
            v439 = nil
        end
        local v440 = p434.Binds
        local v441 = {
            ["Instance"] = v438,
            ["Gradient"] = v439
        }
        local v442
        if p436 == nil then
            v442 = nil
        else
            v442 = typeof(p436) == "string" and { p436 } or p436
        end
        v441.Properties = v442
        v440[v438] = v441
    end
end
function u48.Transparency.Remove(p443, p444) --[[ Line: 1098 ]]
    local v445 = typeof(p444) ~= "table" and { p444 } or p444
    for _, v446 in pairs(v445) do
        local v447 = p443.Binds[v446]
        if v447 ~= nil then
            if v447.Gradient ~= nil then
                v447.Gradient:Destroy()
            end
            p443.Binds[v446] = nil
        end
    end
end
function u48.Transparency.SmoothDamp(p448, p449) --[[ Line: 1108 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u48
    --]]
    local v450, v451 = u7:SmoothDamp(p448.Current, p448.Target, p448.Velocity, 0.15, 1000, p449)
    p448.Current = v450
    p448.Velocity = v451
    local v452 = p448.Current * 1000
    p448.Transparency = math.round(v452) / 1000
    if p448.Transparency ~= p448.LastTransparency then
        p448.LastTransparency = p448.Transparency
        local v453 = NumberSequence.new(p448.Transparency)
        for _, v454 in pairs(p448.Binds) do
            if v454.Gradient ~= nil then
                v454.Gradient.Transparency = v453
                v454.Gradient.Enabled = p448.Transparency ~= 0 and true or v454.Gradient.Color ~= u48.ColorSequenceWhite
            end
            if v454.Properties ~= nil then
                for _, v455 in pairs(v454.Properties) do
                    v454.Instance[v455] = p448.Transparency
                end
            end
        end
        p448.TransparencyChangedBindable:Fire(p448.Transparency)
    end
end
function u48.Transparency.SetCurrent(p456, p457, p458) --[[ Line: 1128 ]]
    p456.Current = p457
    local v459 = p456.Current * 1000
    p456.Transparency = math.round(v459) / 1000
    p456.Velocity = p458
end
function u48.Transparency.SetTarget(p460, p461) --[[ Line: 1133 ]]
    if p460.Target ~= p461 then
        local v462 = p460.Faded
        p460.Target = p461
        p460.Faded = p461 == 1
        if v462 ~= p460.Faded then
            p460.FadedChangedBindable:Fire()
        end
    end
end
function u48.Transparency.Update(p463, p464) --[[ Line: 1142 ]]
    p463.BindState = true
    p463:SmoothDamp(p464)
end
function u48.Transparency.CanUpdate(p465) --[[ Line: 1146 ]]
    if p465.UpdateDependency == nil then
        return true
    end
    local v466 = p465.UpdateDependency[p465.UpdateProperty]
    local v467
    if v466 == nil or v466 == false then
        v467 = false
    else
        v467 = p465.BindState == false
    end
    return v467
end
function u48.Transparency.new(p468, p469, p470) --[[ Line: 1151 ]]
    --[[
    Upvalues:
        [1] = u48
        [2] = u11
    --]]
    local v471 = {
        ["__index"] = u48.Transparency
    }
    local u472 = setmetatable({}, v471)
    u472.FadedChangedBindable = Instance.new("BindableEvent")
    u472.FadedChanged = u472.FadedChangedBindable.Event
    u472.TransparencyChangedBindable = Instance.new("BindableEvent")
    u472.TransparencyChanged = u472.TransparencyChangedBindable.Event
    u472.BindState = true
    u472.Binds = {}
    u472.InitialTransparency = p468
    u472.UpdateDependency = p469
    u472.UpdateProperty = u472.UpdateDependency ~= nil and (p470 or "Parent") or nil
    u472.Connection = u48.MultiConnection.new()
    u472.Current = p468
    local v473 = u472.Current * 1000
    u472.Transparency = math.round(v473) / 1000
    u472.Target = p468
    u472.Velocity = 0
    u472.Connection:AddConnection(u11.Heartbeat:Connect(function(p474) --[[ Line: 1167 ]]
        --[[
        Upvalues:
            [1] = u472
        --]]
        u472.BindState = false
        if u472:CanUpdate() then
            u472:Update(p474)
        end
    end))
    return u472
end
function u48.IsWhisper(p475) --[[ Line: 1176 ]]
    if p475 == nil then
        return false
    else
        return string.match(p475.Name, "RBXWhisper:%d+_%d+")
    end
end
function u48.IsTeam(p476) --[[ Line: 1181 ]]
    if p476 == nil then
        return false
    else
        return string.match(p476.Name, "RBXTeam.*")
    end
end
function u48.GetChannelName(p477) --[[ Line: 1186 ]]
    --[[
    Upvalues:
        [1] = u48
        [2] = u19
        [3] = u9
    --]]
    if p477 == nil then
        return ""
    end
    local v478 = p477.Name
    if v478 == "RBXGeneral" then
        return "General"
    end
    if u48.IsTeam(p477) then
        return "Team"
    end
    if u48.IsWhisper(p477) then
        local v479 = string.gmatch(v478, "%d+")
        local v480 = u19.UserId
        while v480 == u19.UserId do
            v480 = tonumber(v479())
        end
        local v481 = u9:GetPlayerByUserId(v480)
        if v481 ~= nil then
            return v481.DisplayName
        end
    end
    return v478
end
function u48.CreateUserWhsiper(p482) --[[ Line: 1203 ]]
    --[[
    Upvalues:
        [1] = u19
        [2] = u9
        [3] = u3
        [4] = u12
    --]]
    if typeof(p482) == "number" then
        if u19.UserId ~= p482 then
            if u9:GetPlayerByUserId(p482) ~= nil then
                local v483 = "RBXWhisper:%*_%*"
                local v484
                if u19.UserId < p482 then
                    v484 = u19.UserId
                else
                    v484 = p482
                end
                local v485
                if u19.UserId < p482 then
                    v485 = p482
                else
                    v485 = u19.UserId
                end
                local v486 = v483:format(v484, v485)
                for _, v487 in pairs(u3:GetDescendants()) do
                    if v487.Name == v486 and v487:IsA("TextChannel") then
                        return v487
                    end
                end
                return u12:WaitForChild("RBXWhisper"):InvokeServer(p482)
            end
        end
    else
        return
    end
end
u48.Channels = {}
function u48.GetTextChannels() --[[ Line: 1214 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    return u48.Channels
end
function u48.SetTextChannels() --[[ Line: 1218 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    local v488 = {}
    for _, v489 in pairs(u48.TextChannel.Instances) do
        if v489.TextChannel.Name ~= "RBXSystem" and v489.TextChannel ~= u48.RBXAll then
            table.insert(v488, v489)
        end
    end
    table.sort(v488, function(p490, p491) --[[ Line: 1221 ]]
        return p490.TextChannel.Name > p491.TextChannel.Name
    end)
    u48.Channels = v488
end
function u48.UpdateChannelTabs() --[[ Line: 1229 ]]
    --[[
    Upvalues:
        [1] = u18
        [2] = u48
        [3] = u33
        [4] = u329
    --]]
    local v492 = u18.Elements.PrimaryChannelTab.UISizeConstraint.MinSize.X
    local v493 = u48.GetTextChannels()
    local v494 = {}
    local v495 = false
    for _, v496 in pairs(v493) do
        if v496.LocalPlayerAdded then
            table.insert(v494, v496)
        else
            v496:SetPrimaryVisibility(false)
            v496:SetDropDownVisibility(false)
        end
    end
    local v497 = #v494
    local v498 = v497 * v492
    local v499 = u33.AbsoluteSize.X
    if v499 < v498 then
        local v500 = v499 - u33.DropdownButton.Size.X.Offset
        while v500 < v498 do
            v497 = v497 - 1
            v498 = v497 * v492
            v495 = true
        end
    end
    local _ = #v494 - v497
    local v501 = u329.TargetTextChannel
    local v502 = {}
    local v503 = {}
    local v504 = {}
    for _, v505 in pairs(v494) do
        if #v502 < v497 then
            table.insert(v502, v505)
        elseif #v502 >= 1 and v505.TextChannel == v501 then
            local v506 = table.remove
            local v507 = #v502
            table.insert(v503, v506(v502, v507))
            local v508
            if #v502 < v497 then
                v508 = v502
            else
                v508 = v503
            end
            table.insert(v508, v505)
        else
            table.insert(v503, v505)
        end
    end
    for _, v509 in pairs(v502) do
        table.insert(v504, v509)
    end
    for _, v510 in pairs(v503) do
        table.insert(v504, v510)
    end
    for v511, v512 in pairs(v504) do
        local v513 = v512.PrimaryChannelTab
        local v514 = v512.DropdownChannelTab
        v513.LayoutOrder = v511
        v512:SetPrimaryVisibility(v511 <= v497)
        v513.Divider.Visible = v511 < v497 and true or (v511 == 1 and true or v495)
        v514.LayoutOrder = v511
        v512:SetDropDownVisibility(v497 < v511)
        v514.Divider.Visible = v511 < #v504
    end
    u33.DropdownButton.Visible = v495
    u33.HorizontalBar.ContentContainer.Size = v495 and UDim2.new(1, -u33.DropdownButton.Size.X.Offset, 1, 0) or UDim2.new(1, 0, 1, 0)
    local v515 = u18.Elements.DropdownChannelTab.Size.Y.Offset
    local v516 = #v503
    local v517 = v515 * math.min(v516, 3)
    u33.DropdownMenu.Size = UDim2.fromOffset(u18.Elements.DropdownChannelTab.Size.X.Offset, v517)
    local v518 = false
    for _, v519 in pairs(v503) do
        v518 = v519.PrimaryChannelTab.UnreadDot.Visible
        if v518 then
            break
        end
    end
    u33.DropdownButton.UnreadDot.Visible = v518
end
function u48.UpdateTextChatMessages() --[[ Line: 1291 ]]
    --[[
    Upvalues:
        [1] = u330
        [2] = u329
        [3] = u48
    --]]
    local v520
    if u330.Enabled then
        v520 = u329.TargetTextChannel
    else
        v520 = u48.RBXAll
    end
    local v521 = u48.TextChannel.Instances[v520]
    if v521 ~= nil then
        v521.PrimaryChannelTab.UnreadDot.Visible = false
        v521.DropdownChannelTab.UnreadDot.Visible = false
        for _, v522 in pairs(v521.TextChatMessages) do
            v522:SetVisibility(true)
        end
    end
    if u48.LastTargetTextChannel ~= v520 then
        local v523 = u48.TextChannel.Instances[u48.LastTargetTextChannel]
        u48.LastTargetTextChannel = v520
        if v523 ~= nil then
            for _, v524 in pairs(v523.TextChatMessages) do
                v524:SetVisibility(false)
            end
        end
    end
end
function u48.ParseAutoComplete(p525, p526) --[[ Line: 1308 ]]
    local v527 = nil
    local v528 = nil
    local v529 = nil
    local v530 = p526 - 1
    local v531 = string.sub(p525, 1, v530)
    local v532 = string.split(v531, ":")
    local v533
    if v532[#v532] == "" then
        table.remove(v532, #v532)
        v533 = true
    else
        v533 = false
    end
    local v534 = #v532
    local v535 = v532[math.max(2, v534)]
    table.remove(v532, #v532)
    if v535 ~= nil then
        local v536 = table.concat(v532, ":")
        v527 = string.len(v536) + 1
        v528 = (":%*%*"):format(v535, v533 and ":" or "")
        v529 = string.len(v528)
    end
    local v537 = string.sub(p525, 1, 1) == "/"
    local v538 = p526 - 1
    local v539 = string.sub(p525, 1, v538)
    if v537 then
        v529 = string.len(v539)
        v527 = 1
    else
        v539 = v528
    end
    return v527, v539, v529
end
function u48.FillAutoComplete(p540, p541, p542, p543) --[[ Line: 1334 ]]
    local v544 = p540.Text
    local v545 = p541 - 1
    local v546 = string.sub(v544, 1, v545)
    local v547 = p541 + p542
    p540.Text = v546 .. p543 .. string.sub(v544, v547)
    p540.CursorPosition = p541 + string.len(p543)
end
u48.InstanceCache = {
    ["__type"] = "insatnceCache"
}
function u48.InstanceCache.Get(p548) --[[ Line: 1343 ]]
    return table.remove(p548.Cache, 1) or p548.Instance:Clone()
end
function u48.InstanceCache.Relieve(p549, p550) --[[ Line: 1346 ]]
    if #p549.Cache < p549.Cap then
        local v551 = p549.Cache
        table.insert(v551, p550)
    else
        p550:Destroy()
    end
    p550.Parent = nil
end
function u48.InstanceCache.new(p552, p553) --[[ Line: 1350 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    local v554 = {
        ["__index"] = u48.InstanceCache
    }
    return setmetatable({
        ["Cap"] = p553,
        ["Cache"] = {},
        ["Instance"] = p552
    }, v554)
end
local u555 = u48.InstanceCache.new(u18.Elements.TextChatAutoComplete, 100)
local v556 = u48.InstanceCache.new
local v557
if u15 then
    v557 = u18.Demo.TextChatMessage
else
    v557 = u18.Elements.TextChatMessage
end
local u558 = v556(v557, 100)
local u559 = u48.InstanceCache.new(u18.Elements.BubbleChatMessage, 100)
u48.TextChatMessage = {}
function u48.TextChatMessage.CleanUp(p560) --[[ Line: 1368 ]]
    p560.Connection:Disconnect()
end
function u48.TextChatMessage.Destroy(p561) --[[ Line: 1371 ]]
    --[[
    Upvalues:
        [1] = u558
    --]]
    p561:CleanUp()
    p561:RemoveTransparency()
    if p561.ChatMessage ~= nil then
        u558:Relieve(p561.ChatMessage)
        p561.ChatMessage = nil
    end
end
function u48.TextChatMessage.SetMessage(p562, p563) --[[ Line: 1376 ]]
    --[[
    Upvalues:
        [1] = u330
        [2] = u329
        [3] = u48
    --]]
    p562.Message = p563
    local v564
    if u330.Enabled then
        v564 = u329.TargetTextChannel
    else
        v564 = u48.RBXAll
    end
    p562:SetVisibility(p562.TextChannel.TextChannel == v564)
    p562.BodyText.TextColor3 = p562:GetProperty("TextColor3")
    p562.PrefixText.TextColor3 = p562:GetProperty("TextColor3", true)
    p562.BodyText.FontFace = p562:GetProperty("FontFace")
    p562.PrefixText.FontFace = p562:GetProperty("FontFace", true)
    p562.BodyText.TextSize = p562:GetProperty("TextSize")
    p562.PrefixText.TextSize = p562:GetProperty("TextSize", true)
    p562.BodyText.TextStrokeColor3 = p562:GetProperty("TextStrokeColor3")
    p562.PrefixText.TextStrokeColor3 = p562:GetProperty("TextStrokeColor3", true)
    p562.BodyText.TextStrokeTransparency = p562:GetProperty("TextStrokeTransparency")
    p562.PrefixText.TextStrokeTransparency = p562:GetProperty("TextStrokeTransparency", true)
    p562:UpdateChat()
end
function u48.TextChatMessage.GetProperty(p565, p566, p567) --[[ Line: 1392 ]]
    --[[
    Upvalues:
        [1] = u328
    --]]
    if p567 == nil then
        p567 = false
    end
    local v568
    if p566 == "Text" or (p566 == "Translation" or p566 == "PrefixText") then
        v568 = p565.Message[p566]
    else
        v568 = u328[p566]
    end
    local v569 = p565.Message.ChatWindowMessageProperties
    if v569 ~= nil then
        local v570 = v569.PrefixTextProperties
        if v570 == nil or not p567 then
            if v569[p566] ~= "" then
                v568 = v569[p566]
            end
        elseif v570[p566] ~= "" then
            return v570[p566]
        end
    end
    return v568
end
function u48.TextChatMessage.UpdateChat(p571) --[[ Line: 1408 ]]
    --[[
    Upvalues:
        [1] = u48
        [2] = u326
        [3] = u327
        [4] = u328
    --]]
    local v572 = p571:GetProperty("Text")
    local v573 = p571:GetProperty("Translation")
    local v574 = p571:GetProperty("PrefixText", true)
    if p571.TextChannel.TextChannel ~= u48.RBXAll then
        local v575 = string.gsub(v574, "%[To .+%] ", "")
        local v576 = string.gsub(v575, "%[From .+%] ", "")
        v574 = string.gsub(v576, "%[Team%] ", "")
    end
    local v577 = u326.ChatTranslationEnabled
    if v577 then
        v577 = v573 ~= ""
    end
    local v578
    if v577 then
        v578 = u327.OptionToViewUntranslatedMessage
    else
        v578 = v577
    end
    local v579 = u328.TextSize
    local v580 = v579 - 2
    local v581 = u48.GetTextBounds(v574, v579, nil, u328.FontFace, u48.LongChatBounds)
    local v582 = u48.GetTextBounds("  ", v579, nil, u328.FontFace, u48.LongChatBounds).X / 2
    local v583 = v580 / v582
    local v584 = math.round(v583)
    local v585 = ("<font transparency=\'1.0\' family=\'%*\' weight=\'%*\' size=\'%*\'><stroke transparency=\'1.0\'>%*</stroke></font>%*%*"):format(u328.FontFace.Family, u328.FontFace.Weight.Name, u328.TextSize, v574, v574 == "" and "" or " ", v578 and string.rep(" ", v584 + 1) or "")
    if not v577 then
        p571.Translated = false
    end
    if p571.Translated then
        if not v577 then
            v573 = v572
        end
    else
        v573 = v572
    end
    local v586 = "%*%*"
    if u327.FilterSpecialCharacters and p571.Message.TextSource ~= nil then
        v573 = u48.FilterSpecialCharacters(v573)
    end
    local v587 = v586:format(v585, v573)
    p571.ChatMessage.TextMessage.Translate.Size = UDim2.fromOffset(v580, v580)
    p571.ChatMessage.TextMessage.Translate.Position = UDim2.fromOffset(v581.X + (v574 == nil and 0 or v582), 0)
    p571.ChatMessage.TextMessage.Translate.Visible = v578
    local v588
    if p571.Message.ChatWindowMessageProperties == nil or p571.Message.ChatWindowMessageProperties.PrefixTextProperties == nil then
        v588 = nil
    else
        v588 = p571.Message.ChatWindowMessageProperties.PrefixTextProperties:FindFirstChildWhichIsA("UIGradient")
    end
    local v589 = p571.PrefixText:FindFirstChildWhichIsA("UIGradient")
    if v588 == nil then
        v589.Color = u48.ColorSequenceWhite
        v589.Offset = u48.ZeroVector2
        v589.Rotation = 0
    else
        v589.Color = v588.Color
        v589.Offset = v588.Offset
        v589.Rotation = v588.Rotation
    end
    p571.PrefixText.Text = v574
    p571.BodyText.Text = v587
end
function u48.TextChatMessage.AddTransparency(p590) --[[ Line: 1447 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    u48.TextFadeTransparency:Add({ p590.ChatMessage.TextMessage.Translate, p590.PrefixText, p590.BodyText })
end
function u48.TextChatMessage.RemoveTransparency(p591) --[[ Line: 1450 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    u48.TextFadeTransparency:Remove({ p591.ChatMessage.TextMessage.Translate, p591.PrefixText, p591.BodyText })
end
function u48.TextChatMessage.SetVisibility(p592, p593) --[[ Line: 1453 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    if p592.Visible ~= p593 then
        p592.Visible = p593
        local v594 = p592.ChatMessage
        local v595
        if p593 then
            v595 = u44
        else
            v595 = nil
        end
        v594.Parent = v595
    end
end
function u48.TextChatMessage.new(p596, p597) --[[ Line: 1459 ]]
    --[[
    Upvalues:
        [1] = u48
        [2] = u326
        [3] = u558
        [4] = u327
        [5] = u328
        [6] = u15
        [7] = u10
        [8] = u329
    --]]
    local v598 = {
        ["__index"] = u48.TextChatMessage
    }
    local u599 = setmetatable({}, v598)
    u599.TextChannel = p596
    u599.Connection = u48.MultiConnection.new()
    u599.Translated = u326.ChatTranslationEnabled
    u599.ChatMessage = u558:Get()
    u599.ChatMessage.Visible = true
    u599.ChatMessage.Parent = nil
    u599.BodyText = u599.ChatMessage.TextMessage.BodyText
    u599.PrefixText = u599.ChatMessage.TextMessage.PrefixText
    u599:AddTransparency()
    u599:SetMessage(p597)
    u599.Connection:AddConnection(u48.PropertyBind.new(u327, { "OptionToViewUntranslatedMessage" }, u599.ChatMessage, "Parent", function() --[[ Line: 1480 ]]
        --[[
        Upvalues:
            [1] = u599
            [2] = u326
        --]]
        u599.Translated = u326.ChatTranslationEnabled
        u599:UpdateChat()
    end))
    u599.Connection:AddConnection(u599.ChatMessage.TextMessage.Translate.Activated:Connect(function() --[[ Line: 1484 ]]
        --[[
        Upvalues:
            [1] = u599
            [2] = u326
            [3] = u327
        --]]
        u599.ChatMessage.TextMessage.Translate.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        u599.ChatMessage.TextMessage.Translate.ImageColor3 = Color3.fromRGB(25, 27, 29)
        local v600 = u326.ChatTranslationEnabled
        if v600 then
            v600 = u599:GetProperty("Translation") ~= ""
        end
        if v600 and u327.OptionToViewUntranslatedMessage then
            u599.Translated = not u599.Translated
            u599:UpdateChat()
        end
    end))
    u599.Connection:AddConnection(u599.ChatMessage.TextMessage.Translate.MouseLeave:Connect(function() --[[ Line: 1493 ]]
        --[[
        Upvalues:
            [1] = u599
        --]]
        u599.ChatMessage.TextMessage.Translate.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        u599.ChatMessage.TextMessage.Translate.ImageColor3 = Color3.fromRGB(25, 27, 29)
    end))
    u599.Connection:AddConnection(u599.ChatMessage.TextMessage.Translate.MouseEnter:Connect(function() --[[ Line: 1497 ]]
        --[[
        Upvalues:
            [1] = u599
        --]]
        u599.ChatMessage.TextMessage.Translate.BackgroundColor3 = Color3.fromRGB(57, 59, 61)
        u599.ChatMessage.TextMessage.Translate.ImageColor3 = Color3.fromRGB(255, 255, 255)
    end))
    u599.Connection:AddConnection(u599.ChatMessage.TextMessage.Translate.MouseButton1Down:Connect(function() --[[ Line: 1501 ]]
        --[[
        Upvalues:
            [1] = u599
        --]]
        u599.ChatMessage.TextMessage.Translate.BackgroundColor3 = Color3.fromRGB(57, 59, 61)
        u599.ChatMessage.TextMessage.Translate.ImageColor3 = Color3.fromRGB(255, 255, 255)
    end))
    u599.Connection:AddConnection(u48.PropertyBind.new(u326, { "ChatTranslationEnabled" }, u599.ChatMessage, "Parent", function() --[[ Line: 1505 ]]
        --[[
        Upvalues:
            [1] = u599
            [2] = u326
        --]]
        u599.Translated = u326.ChatTranslationEnabled
        u599:UpdateChat()
    end))
    u599.Connection:AddConnection(u48.PropertyBind.new(u327, { "FilterSpecialCharacters" }, u599.ChatMessage, "Parent", function() --[[ Line: 1509 ]]
        --[[
        Upvalues:
            [1] = u599
        --]]
        u599:UpdateChat()
    end))
    u599.Connection:AddConnection(u48.PropertyBind.new(u328, { "TextColor3" }, u599.ChatMessage, "Parent", function() --[[ Line: 1512 ]]
        --[[
        Upvalues:
            [1] = u599
        --]]
        u599.BodyText.TextColor3 = u599:GetProperty("TextColor3")
        u599.PrefixText.TextColor3 = u599:GetProperty("TextColor3", true)
    end))
    u599.Connection:AddConnection(u48.PropertyBind.new(u328, { "FontFace" }, u599.ChatMessage, "Parent", function() --[[ Line: 1516 ]]
        --[[
        Upvalues:
            [1] = u599
        --]]
        u599.BodyText.FontFace = u599:GetProperty("FontFace")
        u599.PrefixText.FontFace = u599:GetProperty("FontFace", true)
        if u599.Message.ChatWindowMessageProperties == nil then
            u599:UpdateChat()
        end
    end))
    u599.Connection:AddConnection(u48.PropertyBind.new(u328, { "TextSize" }, u599.ChatMessage, "Parent", function() --[[ Line: 1521 ]]
        --[[
        Upvalues:
            [1] = u599
        --]]
        u599.BodyText.TextSize = u599:GetProperty("TextSize")
        u599.PrefixText.TextSize = u599:GetProperty("TextSize", true)
        if u599.Message.ChatWindowMessageProperties == nil then
            u599:UpdateChat()
        end
    end))
    u599.Connection:AddConnection(u48.PropertyBind.new(u328, { "TextStrokeColor3" }, u599.ChatMessage, "Parent", function() --[[ Line: 1526 ]]
        --[[
        Upvalues:
            [1] = u599
        --]]
        u599.BodyText.TextStrokeColor3 = u599:GetProperty("TextStrokeColor3")
        u599.PrefixText.TextStrokeColor3 = u599:GetProperty("TextStrokeColor3", true)
    end))
    u599.Connection:AddConnection(u48.PropertyBind.new(u328, { "TextStrokeTransparency" }, u599.ChatMessage, "Parent", function() --[[ Line: 1530 ]]
        --[[
        Upvalues:
            [1] = u599
        --]]
        u599.BodyText.TextStrokeTransparency = u599:GetProperty("TextStrokeTransparency")
        u599.PrefixText.TextStrokeTransparency = u599:GetProperty("TextStrokeTransparency", true)
    end))
    if u15 then
        if u599.Message.TextSource ~= nil then
            u599.Connection:AddConnection(u599.PrefixText.MouseEnter:Connect(function() --[[ Line: 1538 ]]
                --[[
                Upvalues:
                    [1] = u599
                --]]
                u599.PrefixText.Text = string.gsub(u599.PrefixText.Text, "<u>", "")
                u599.PrefixText.Text = string.gsub(u599.PrefixText.Text, "</u>", "")
                u599.PrefixText.Text = ("<u>%*</u>"):format(u599.PrefixText.Text)
            end))
            u599.Connection:AddConnection(u599.PrefixText.MouseLeave:Connect(function() --[[ Line: 1543 ]]
                --[[
                Upvalues:
                    [1] = u599
                --]]
                u599.PrefixText.Text = string.gsub(u599.PrefixText.Text, "<u>", "")
                u599.PrefixText.Text = string.gsub(u599.PrefixText.Text, "</u>", "")
            end))
            u599.Connection:AddConnection(u599.PrefixText.Activated:Connect(function() --[[ Line: 1547 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u599
                --]]
                u10:InspectPlayerFromUserId(u599.Message.TextSource.UserId)
            end))
            return u599
        end
    else
        u599.Connection:AddConnection(u599.PrefixText.Activated:Connect(function() --[[ Line: 1552 ]]
            --[[
            Upvalues:
                [1] = u599
                [2] = u48
                [3] = u329
            --]]
            if u599.Message.TextSource == nil then
                return
            else
                local v601 = u48.CreateUserWhsiper(u599.Message.TextSource.UserId)
                if v601 ~= nil then
                    u329.TargetTextChannel = v601
                end
            end
        end))
    end
    return u599
end
u48.TextChannel = {}
u48.TextChannel.Instances = {}
function u48.TextChannel.CleanUp(p602) --[[ Line: 1565 ]]
    for _ = 1, #p602.TextChatMessages do
        table.remove(p602.TextChatMessages, 1):Destroy()
    end
    p602.Connection:Disconnect()
    p602:RemoveTransparency()
    p602.PrimaryChannelTab:Destroy()
    p602.DropdownChannelTab:Destroy()
end
function u48.TextChannel.Clear(p603, _) --[[ Line: 1572 ]]
    for _ = 1, #p603.TextChatMessages do
        table.remove(p603.TextChatMessages, 1):Destroy()
    end
end
function u48.TextChannel.AddMessage(p604, p605) --[[ Line: 1575 ]]
    --[[
    Upvalues:
        [1] = u327
        [2] = u48
        [3] = u33
        [4] = u329
    --]]
    for v606, v607 in pairs(p604.TextChatMessages) do
        if v607.Message.MessageId == p605.MessageId then
            if p605.Text == "" or p605.Status ~= Enum.TextChatMessageStatus.Success and p605.Status ~= Enum.TextChatMessageStatus.Sending then
                table.remove(p604.TextChatMessages, v606):Destroy()
            else
                v607:SetMessage(p605)
            end
        end
    end
    if p605.Text ~= "" and (p605.Status == Enum.TextChatMessageStatus.Success or p605.Status == Enum.TextChatMessageStatus.Sending) then
        p604.TextChatLayoutOrder = p604.TextChatLayoutOrder + 1
        if #p604.TextChatMessages >= u327.MaxMessages then
            table.remove(p604.TextChatMessages, #p604.TextChatMessages):Destroy()
        end
        local v608 = u48.TextChatMessage.new(p604, p605)
        local v609 = p604.TextChatMessages
        table.insert(v609, 1, v608)
        v608.ChatMessage.LayoutOrder = p604.TextChatLayoutOrder
        local v610 = u33.DropdownButton.UnreadDot
        if u329.TargetTextChannel ~= p604.TextChannel then
            p604.PrimaryChannelTab.UnreadDot.Visible = true
            p604.DropdownChannelTab.UnreadDot.Visible = true
            if p604.DropdownChannelTab.Parent ~= nil then
                v610.Visible = true
            end
        end
    end
end
function u48.TextChannel.AddTransparency(p611) --[[ Line: 1599 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    u48.BackgroundFadeTransparency:Add({
        p611.PrimaryChannelTab,
        p611.PrimaryChannelTab.Divider,
        p611.PrimaryChannelTab.Highlight,
        p611.PrimaryChannelTab.UnreadDot,
        p611.PrimaryBodyText,
        p611.DropdownChannelTab,
        p611.DropdownChannelTab.Divider,
        p611.DropdownChannelTab.Highlight,
        p611.DropdownChannelTab.UnreadDot,
        p611.DropdownBodyText
    })
end
function u48.TextChannel.RemoveTransparency(p612) --[[ Line: 1613 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    u48.BackgroundFadeTransparency:Remove({
        p612.PrimaryChannelTab,
        p612.PrimaryChannelTab.Divider,
        p612.PrimaryChannelTab.Highlight,
        p612.PrimaryChannelTab.UnreadDot,
        p612.PrimaryBodyText,
        p612.DropdownChannelTab,
        p612.DropdownChannelTab.Divider,
        p612.DropdownChannelTab.Highlight,
        p612.DropdownChannelTab.UnreadDot,
        p612.DropdownBodyText
    })
end
function u48.TextChannel.SetDropDownVisibility(p613, p614) --[[ Line: 1627 ]]
    --[[
    Upvalues:
        [1] = u43
    --]]
    if p613.DropdownVisible ~= p614 then
        p613.DropdownVisible = p614
        local v615 = p613.DropdownChannelTab
        local v616
        if p614 then
            v616 = u43
        else
            v616 = nil
        end
        v615.Parent = v616
    end
end
function u48.TextChannel.SetPrimaryVisibility(p617, p618) --[[ Line: 1633 ]]
    --[[
    Upvalues:
        [1] = u42
    --]]
    if p617.PrimaryVisible ~= p618 then
        p617.PrimaryVisible = p618
        local v619 = p617.PrimaryChannelTab
        local v620
        if p618 then
            v620 = u42
        else
            v620 = nil
        end
        v619.Parent = v620
    end
end
function u48.TextChannel.new(p621) --[[ Line: 1639 ]]
    --[[
    Upvalues:
        [1] = u48
        [2] = u18
        [3] = u329
        [4] = u327
        [5] = u330
        [6] = u33
        [7] = u19
    --]]
    if p621:IsA("TextChannel") then
        local v622 = {
            ["__index"] = u48.TextChannel
        }
        local u623 = setmetatable({}, v622)
        u623.Instances = nil
        u623.Connection = u48.MultiConnection.new()
        u623.TextChannel = p621
        u623.TextChatMessages = {}
        u623.PrimaryChannelTab = u18.Elements.PrimaryChannelTab:Clone()
        u623.PrimaryChannelTab.Parent = nil
        u623.PrimaryVisible = false
        u623.PrimaryChannelTab.Visible = true
        u623.DropdownChannelTab = u18.Elements.DropdownChannelTab:Clone()
        u623.DropdownChannelTab.Parent = nil
        u623.PrimaryBodyText = u623.PrimaryChannelTab.TextLabel
        u623.DropdownBodyText = u623.DropdownChannelTab.TextLabel
        u623.DropdownVisible = false
        u623.DropdownChannelTab.Visible = true
        u623.ChannelName = u48.GetChannelName(u623.TextChannel)
        u623.PrimaryBodyText.Text = u623.ChannelName
        u623.DropdownBodyText.Text = u623.ChannelName
        local v624 = u623.TextChannel == u329.TargetTextChannel
        u623.TextChatLayoutOrder = 0
        u623.LocalPlayerAdded = false
        u623:AddTransparency()
        u623.Connection:AddConnection(u48.PropertyBind.new(u327, { "MaxMessages" }, nil, nil, function() --[[ Line: 1673 ]]
            --[[
            Upvalues:
                [1] = u623
                [2] = u327
            --]]
            while #u623.TextChatMessages > u327.MaxMessages do
                table.remove(u623.TextChatMessages, #u623.TextChatMessages):Destroy()
            end
        end))
        u623.Connection:AddConnection(u48.StyleBind.new(u330, "TextStrokeColor3", u623.PrimaryChannelTab, "Parent"):Add(u623.PrimaryBodyText, "TextStrokeColor3"))
        u623.Connection:AddConnection(u48.StyleBind.new(u330, "TextStrokeTransparency", u623.PrimaryChannelTab, "Parent"):Add(u623.PrimaryBodyText, "TextStrokeTransparency"))
        u623.Connection:AddConnection(u48.StyleBind.new(u330, "TextSize", u623.PrimaryChannelTab, "Parent"):Add(u623.PrimaryBodyText, "TextSize"))
        u623.Connection:AddConnection(u48.StyleBind.new(u330, "FontFace", u623.PrimaryChannelTab, "Parent"):Add(u623.PrimaryBodyText, "FontFace"))
        u623.Connection:AddConnection(u48.StyleBind.new(u330, "TextColor3", u623.DropdownChannelTab, "Parent"):Add(u623.DropdownBodyText, "TextColor3"))
        u623.Connection:AddConnection(u48.StyleBind.new(u330, "TextStrokeColor3", u623.DropdownChannelTab, "Parent"):Add(u623.DropdownBodyText, "TextStrokeColor3"))
        u623.Connection:AddConnection(u48.StyleBind.new(u330, "TextStrokeTransparency", u623.DropdownChannelTab, "Parent"):Add(u623.DropdownBodyText, "TextStrokeTransparency"))
        u623.Connection:AddConnection(u48.StyleBind.new(u330, "TextSize", u623.DropdownChannelTab, "Parent"):Add(u623.DropdownBodyText, "TextSize"))
        u623.Connection:AddConnection(u48.StyleBind.new(u330, "FontFace", u623.DropdownChannelTab, "Parent"):Add(u623.DropdownBodyText, "FontFace"))
        u623.Connection:AddConnection(u623.PrimaryChannelTab.Activated:Connect(function() --[[ Line: 1703 ]]
            --[[
            Upvalues:
                [1] = u329
                [2] = u623
                [3] = u33
                [4] = u48
            --]]
            u329.TargetTextChannel = u623.TextChannel
            u33.DropdownMenu.Visible = false
            u48.UpdateChannelTabs()
        end))
        u623.Connection:AddConnection(u623.DropdownChannelTab.Activated:Connect(function() --[[ Line: 1708 ]]
            --[[
            Upvalues:
                [1] = u329
                [2] = u623
                [3] = u33
                [4] = u48
            --]]
            u329.TargetTextChannel = u623.TextChannel
            u33.DropdownMenu.Visible = false
            u48.UpdateChannelTabs()
        end))
        u623.Connection:AddConnection(u48.PropertyBind.new(u330, { "HoverBackgroundColor3", "BackgroundColor3" }, u623.DropdownChannelTab, "Parent", function() --[[ Line: 1713 ]]
            --[[
            Upvalues:
                [1] = u623
                [2] = u330
            --]]
            u623.DropdownChannelTab.BackgroundColor3 = u623.MouseInsideDropdown and u330.HoverBackgroundColor3 or u330.BackgroundColor3
        end))
        u623.DropdownChannelTab.BackgroundColor3 = u623.MouseInsideDropdown and u330.HoverBackgroundColor3 or u330.BackgroundColor3
        u623.Connection:AddConnection(u623.DropdownChannelTab.MouseEnter:Connect(function() --[[ Line: 1717 ]]
            --[[
            Upvalues:
                [1] = u623
                [2] = u330
            --]]
            u623.MouseInsideDropdown = true
            u623.DropdownChannelTab.BackgroundColor3 = u330.HoverBackgroundColor3
        end))
        u623.Connection:AddConnection(u623.DropdownChannelTab.MouseLeave:Connect(function() --[[ Line: 1721 ]]
            --[[
            Upvalues:
                [1] = u623
                [2] = u330
            --]]
            u623.MouseInsideDropdown = false
            u623.DropdownChannelTab.BackgroundColor3 = u330.BackgroundColor3
        end))
        u623.Connection:AddConnection(u48.PropertyBind.new(u330, { "TextColor3", "SelectedTabTextColor3" }, u623.PrimaryChannelTab, "Parent", function() --[[ Line: 1725 ]]
            --[[
            Upvalues:
                [1] = u623
                [2] = u329
                [3] = u330
            --]]
            u623.PrimaryBodyText.TextColor3 = u623.TextChannel == u329.TargetTextChannel and u330.SelectedTabTextColor3 or u330.TextColor3
        end))
        u623.PrimaryBodyText.TextColor3 = v624 and u330.SelectedTabTextColor3 or u330.TextColor3
        u623.Connection:AddConnection(u48.PropertyBind.new(u330, { "TextColor3", "SelectedTabTextColor3" }, u623.DropdownChannelTab, "Parent", function() --[[ Line: 1729 ]]
            --[[
            Upvalues:
                [1] = u623
                [2] = u329
                [3] = u330
            --]]
            u623.DropdownBodyText.TextColor3 = u623.TextChannel == u329.TargetTextChannel and u330.SelectedTabTextColor3 or u330.TextColor3
        end))
        u623.DropdownBodyText.TextColor3 = v624 and u330.SelectedTabTextColor3 or u330.TextColor3
        u623.Connection:AddConnection(u48.PropertyBind.new(u329, { "TargetTextChannel" }, u623.PrimaryChannelTab, "Parent", function() --[[ Line: 1733 ]]
            --[[
            Upvalues:
                [1] = u623
                [2] = u329
                [3] = u330
            --]]
            u623.PrimaryBodyText.TextColor3 = u623.TextChannel == u329.TargetTextChannel and u330.SelectedTabTextColor3 or u330.TextColor3
            u623.PrimaryChannelTab.Highlight.Visible = u623.TextChannel == u329.TargetTextChannel
        end))
        u623.PrimaryBodyText.TextColor3 = v624 and u330.SelectedTabTextColor3 or u330.TextColor3
        u623.PrimaryChannelTab.Highlight.Visible = v624
        u623.Connection:AddConnection(u48.PropertyBind.new(u329, { "TargetTextChannel" }, u623.DropdownChannelTab, "Parent", function() --[[ Line: 1739 ]]
            --[[
            Upvalues:
                [1] = u623
                [2] = u329
                [3] = u330
            --]]
            u623.DropdownBodyText.TextColor3 = u623.TextChannel == u329.TargetTextChannel and u330.SelectedTabTextColor3 or u330.TextColor3
            u623.DropdownChannelTab.Highlight.Visible = u623.TextChannel == u329.TargetTextChannel
        end))
        u623.DropdownBodyText.TextColor3 = v624 and u330.SelectedTabTextColor3 or u330.TextColor3
        u623.DropdownChannelTab.Highlight.Visible = v624
        u623.Connection:AddConnection(u48.PropertyBind.new(u623.TextChannel, { "Name" }, nil, nil, function() --[[ Line: 1745 ]]
            --[[
            Upvalues:
                [1] = u623
                [2] = u48
            --]]
            u623.ChannelName = u48.GetChannelName(u623.TextChannel)
            u623.PrimaryBodyText.Text = u623.ChannelName
            u623.DropdownBodyText.Text = u623.ChannelName
        end))
        u623.Connection:AddConnection(u48.Observe(u623.TextChannel, function(p625) --[[ Line: 1752 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u623
                [3] = u48
            --]]
            if p625:IsA("TextSource") then
                if p625.UserId == u19.UserId then
                    u623.LocalPlayerAdded = true
                    u48.SetTextChannels()
                    u48.UpdateChannelTabs()
                    return function() --[[ Line: 1758 ]]
                        --[[
                        Upvalues:
                            [1] = u623
                            [2] = u48
                        --]]
                        u623.LocalPlayerAdded = false
                        u48.SetTextChannels()
                        u48.UpdateChannelTabs()
                    end
                end
            end
        end))
        u48.SetTextChannels()
        u48.UpdateChannelTabs()
        return u623
    end
end
u48.TextChatAutoComplete = {
    ["__type"] = "TextChatAutoComplete"
}
u48.TextChatAutoComplete.Instances = {}
function u48.TextChatAutoComplete.CleanUp(p626) --[[ Line: 1774 ]]
    --[[
    Upvalues:
        [1] = u555
    --]]
    if p626.TextChatAutoComplete ~= nil then
        u555:Relieve(p626.TextChatAutoComplete)
        p626.TextChatAutoComplete = nil
    end
    if p626.BodyText ~= nil then
        p626.BodyText = nil
    end
    p626.Connection:Disconnect()
end
function u48.TextChatAutoComplete.Destroy(p627) --[[ Line: 1779 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    p627:CleanUp()
    u48.TextChatAutoComplete.Instances[p627] = nil
end
function u48.TextChatAutoComplete.AddConnections(u628) --[[ Line: 1783 ]]
    --[[
    Upvalues:
        [1] = u555
        [2] = u47
        [3] = u48
        [4] = u329
    --]]
    u628:CleanUp()
    u628.TextChatAutoComplete = u555:Get()
    u628.BodyText = u628.TextChatAutoComplete.TextLabelButton.TextLabel
    u628.BodyText.Text = u628.ReplaceText
    u628.TextChatAutoComplete.Visible = true
    u628.TextChatAutoComplete.Parent = u47
    u628.Connection:AddConnection(u48.StyleBind.new(u329, "TextColor3", u628.TextChatAutoComplete, "Parent"):Add(u628.BodyText, "TextColor3"))
    u628.Connection:AddConnection(u48.StyleBind.new(u329, "FontFace", u628.TextChatAutoComplete, "Parent"):Add(u628.BodyText, "FontFace"))
    u628.Connection:AddConnection(u48.StyleBind.new(u329, "TextSize", u628.TextChatAutoComplete, "Parent"):Add(u628.BodyText, "TextSize"))
    u628.Connection:AddConnection(u48.StyleBind.new(u329, "TextStrokeColor3", u628.TextChatAutoComplete, "Parent"):Add(u628.BodyText, "TextStrokeColor3"))
    u628.Connection:AddConnection(u48.StyleBind.new(u329, "TextStrokeTransparency", u628.TextChatAutoComplete, "Parent"):Add(u628.BodyText, "TextStrokeTransparency"))
    u628.Connection:AddConnection(u628.TextChatAutoComplete.MouseEnter:Connect(function() --[[ Line: 1808 ]]
        --[[
        Upvalues:
            [1] = u48
            [2] = u628
        --]]
        if u48.CurrentAutoComplete ~= nil and u48.CurrentAutoComplete ~= u628 then
            local v629 = u48.CurrentAutoComplete
            u48.CurrentAutoComplete = nil
            v629:UpdateAppearance()
        end
        u48.CurrentAutoComplete = u628
        u628:UpdateAppearance()
    end))
    u628.Connection:AddConnection(u628.TextChatAutoComplete.TextLabelButton.MouseButton1Down:Connect(function() --[[ Line: 1818 ]]
        --[[
        Upvalues:
            [1] = u628
        --]]
        u628:Replace()
    end))
    u628:UpdateAppearance()
end
function u48.TextChatAutoComplete.Replace(p630) --[[ Line: 1824 ]]
    --[[
    Upvalues:
        [1] = u48
        [2] = u39
    --]]
    if p630.Visible then
        u48.FillAutoComplete(u39, p630.ReplaceIndex, p630.ReplaceLength, p630.ReplaceWith)
    end
end
function u48.TextChatAutoComplete.UpdateAppearance(p631) --[[ Line: 1829 ]]
    --[[
    Upvalues:
        [1] = u48
        [2] = u46
        [3] = u45
    --]]
    if p631.Visible then
        p631.TextChatAutoComplete.TextLabelButton.BackgroundTransparency = u48.CurrentAutoComplete == p631 and 0.85 or 1
        if u48.CurrentAutoComplete == p631 then
            local v632 = p631.TextChatAutoComplete.Size.Y.Offset
            local v633 = (p631.TextChatAutoComplete.LayoutOrder - 1) * v632
            local v634 = u46.CanvasPosition
            local v635 = u45.Size
            if v633 < v634.Y then
                u46.CanvasPosition = Vector2.new(v634.X, v633)
                return
            end
            if v633 + v632 > v634.Y + v635.Y.Offset then
                u46.CanvasPosition = Vector2.new(v634.X, v633 + v632 - v635.Y.Offset)
            end
        end
    end
end
function u48.TextChatAutoComplete.SetVisibility(p636, p637) --[[ Line: 1847 ]]
    if p636.Visible ~= p637 then
        p636.Visible = p637
        if p637 then
            p636:AddConnections()
            return
        end
        p636:CleanUp()
    end
end
function u48.TextChatAutoComplete.new(p638, p639, p640, p641, p642, p643, p644, p645) --[[ Line: 1857 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    local v646 = {
        ["__index"] = u48.TextChatAutoComplete
    }
    local v647 = setmetatable({}, v646)
    v647.Instances = nil
    v647.Connection = u48.MultiConnection.new()
    v647.ReplaceWith = p638
    v647.ReplaceMatch = p639
    v647.ReplaceText = p640
    v647.MinReplaceLength = p641
    v647.OnlyAtStart = p642
    v647.CompleteWhenMatched = p643
    v647.AutoCompleteEnabled = p644
    v647.MatchWithoutSufix = p645
    v647.Visible = false
    u48.TextChatAutoComplete.Instances[v647] = v647
    return v647
end
u48.TextChatCommand = {}
u48.TextChatCommand.Instances = {}
function u48.TextChatCommand.CleanUp(p648) --[[ Line: 1880 ]]
    p648.Connection:Disconnect()
    p648.TextChatAutoComplete:Destroy()
end
function u48.TextChatCommand.new(p649) --[[ Line: 1884 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    if p649:IsA("TextChatCommand") then
        local v650 = {
            ["__index"] = u48.TextChatCommand
        }
        local u651 = setmetatable({}, v650)
        u651.Instances = nil
        u651.Connection = u48.MultiConnection.new()
        u651.Command = p649
        u651.TextChatAutoComplete = u48.TextChatAutoComplete.new(u651.Command.PrimaryAlias, u651.Command.PrimaryAlias, u651.Command.PrimaryAlias, 1, true, false, u651.Command.AutocompleteVisible, false)
        u651.Connection:AddConnection(u651.Command.Triggered:Connect(function() --[[ Line: 1893 ]]
            --[[
            Upvalues:
                [1] = u651
                [2] = u48
            --]]
            if u651.Command.PrimaryAlias == "/clear" and u651.Command.Enabled then
                for _, v652 in pairs(u48.TextChannel.Instances) do
                    v652:Clear()
                end
            end
        end))
        u651.Connection:AddConnection(u48.PropertyBind.new(u651.Command, { "AutocompleteVisible" }, u651.Command, "Parent", function() --[[ Line: 1901 ]]
            --[[
            Upvalues:
                [1] = u651
            --]]
            u651.TextChatAutoComplete.AutoCompleteEnabled = u651.Command.AutocompleteVisible
        end))
        u651.Connection:AddConnection(u48.PropertyBind.new(u651.Command, { "PrimaryAlias" }, u651.Command, "Parent", function() --[[ Line: 1904 ]]
            --[[
            Upvalues:
                [1] = u651
            --]]
            local v653 = u651.Command.PrimaryAlias
            u651.TextChatAutoComplete.ReplaceWith = v653
            u651.TextChatAutoComplete.ReplaceText = v653
            u651.TextChatAutoComplete.ReplaceMatch = v653
            u651.TextChatAutoComplete.BodyText.Text = v653
        end))
        return u651
    end
end
u48.BubbleChatMessage = {
    ["__type"] = "bubbleChatMessage"
}
function u48.BubbleChatMessage.CleanUp(p654) --[[ Line: 1916 ]]
    for _, v655 in pairs(p654.InstanceBinds) do
        v655:Disconnect()
    end
    p654.Connection:Disconnect()
    p654.InstanceBinds = {}
end
function u48.BubbleChatMessage.Destroy(p656) --[[ Line: 1921 ]]
    --[[
    Upvalues:
        [1] = u559
    --]]
    p656:CleanUp()
    local v657 = table.find(p656.BubbleChatContainer.BubbleChatMessages, p656)
    if v657 ~= nil then
        table.remove(p656.BubbleChatContainer.BubbleChatMessages, v657)
    end
    if p656.ChatMessage ~= nil then
        u559:Relieve(p656.ChatMessage)
        p656.ChatMessage = nil
    end
    if #p656.BubbleChatContainer.BubbleChatMessages == 0 then
        p656.BubbleChatContainer:Destroy()
    end
end
function u48.BubbleChatMessage.UpdateTransparency(p658, _, _) --[[ Line: 1928 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    local v659 = u48.TransparencyMask(p658.BackgroundTransparency, p658.Current.Z) * 100
    local v660 = math.round(v659) / 100
    p658.LastTransparency = v660
    p658.ChatBubbleFrame.BackgroundTransparency = not p658.HasImage and 1 or v660
    p658.ChatBubbleFrame.ImageTransparency = p658.HasImage and 1 or v660
    p658.Caret.ImageTransparency = v660
end
function u48.BubbleChatMessage.SmoothDamp(p661, p662, _) --[[ Line: 1936 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u48
    --]]
    local v663, v664 = u7:SmoothDamp(p661.Current, p661.Target, p661.Velocity, 0.15, 1000, p662)
    p661.Current = v663
    p661.Velocity = v664
    local v665 = u48.TransparencyMask(p661.BackgroundTransparency, p661.Current.Z) * 100
    local v666 = math.round(v665) / 100
    local v667 = UDim2.fromOffset
    local v668 = p661.Current.X
    local v669 = math.round(v668)
    local v670 = p661.Current.Y
    local v671 = v667(v669, (math.round(v670)))
    if v671 ~= p661.LastSize then
        p661.LastSize = v671
        p661.ChatMessage.Size = v671
    end
    if v666 ~= p661.LastTransparency then
        p661.LastTransparency = v666
        p661.ChatBubbleFrame.BackgroundTransparency = not p661.HasImage and 1 or v666
        p661.ChatBubbleFrame.ImageTransparency = p661.HasImage and 1 or v666
        p661.Caret.ImageTransparency = v666
    end
end
function u48.BubbleChatMessage.SetMessage(p672, p673) --[[ Line: 1952 ]]
    --[[
    Upvalues:
        [1] = u331
    --]]
    p672.Message = p673
    p672.BackgroundTransparency = p672:GetProperty("BackgroundTransparency")
    p672.ChatMessage.ChatBubbleFrame.BackgroundColor3 = p672:GetProperty("BackgroundColor3")
    p672.ChatMessage.Caret.ImageColor3 = p672:GetProperty("BackgroundColor3")
    p672.BodyText.FontFace = p672:GetProperty("FontFace")
    p672.BodyText.TextColor3 = p672:GetProperty("TextColor3")
    p672.BodyText.TextSize = p672:GetProperty("TextSize")
    local v674 = p672.ChatMessage.Caret
    local v675 = p672:GetProperty("TailVisible")
    if v675 then
        v675 = p672.LastMessage
    end
    v674.Visible = v675
    p672.Font = u331.Font
    p672.FontFace = p672:GetProperty("FontFace")
    p672.TextSize = p672:GetProperty("TextSize")
    p672:UpdateChat()
end
function u48.BubbleChatMessage.UpdateVisibility(p676, p677) --[[ Line: 1966 ]]
    p676.ChatMessage.Visible = p676.InDistanceRange
    local v678 = p676.InChatRange and (not (p676.Destroying or p677) and p676.InDistanceRange)
    if v678 then
        v678 = p676.Enabled or p676.Player == nil
    end
    if not p676.Destroying and p676.Visible ~= v678 or p677 then
        if p677 then
            p676.Destroying = true
        end
        p676.Visible = v678
        if v678 then
            p676.Velocity = 0
            p676:UpdateChat()
            local v679 = p676.Target.X
            p676.Current = Vector3.new(v679, 0, 1)
            p676.ChatMessage.Size = UDim2.fromOffset(p676.Current.X, p676.Current.Y)
            return
        end
        p676.Velocity = 0
        p676:UpdateChat()
        if p677 then
            task.delay(1, p676.Destroy, p676)
        end
    end
end
function u48.BubbleChatMessage.GetProperty(p680, p681) --[[ Line: 1984 ]]
    --[[
    Upvalues:
        [1] = u331
    --]]
    local v682
    if p681 == "Text" or (p681 == "Translation" or p681 == "PrefixText") then
        v682 = p680.Message[p681]
    else
        v682 = u331[p681]
    end
    local v683 = p680.Message.BubbleChatMessageProperties
    if v683 ~= nil and v683[p681] ~= "" then
        v682 = v683[p681]
    end
    return v682
end
function u48.BubbleChatMessage.UpdateChat(p684) --[[ Line: 1994 ]]
    --[[
    Upvalues:
        [1] = u327
        [2] = u48
        [3] = u331
    --]]
    local v685 = p684.ChatMessage.ChatBubbleFrame.Padding
    if p684.Visible then
        local v686 = p684.ChatTranslationEnabled
        if v686 then
            v686 = p684:GetProperty("Translation") ~= ""
        end
        local v687
        if v686 then
            v687 = p684:GetProperty("Translation")
        else
            v687 = p684:GetProperty("Text")
        end
        local v688 = "%*"
        if u327.FilterSpecialCharacters and p684.Message.TextSource ~= nil then
            v687 = u48.FilterSpecialCharacters(v687)
        end
        local v689 = v688:format(v687)
        p684.BodyText.Text = v689
        local v690 = u48.GetTextBounds(v689, p684.TextSize, p684.Font, p684.FontFace, u48.BubbleChatBounds)
        local v691 = v690.X
        local v692 = v690.Y
        local v693 = p684.Visible and 0 or 1
        local v694 = Vector3.new(v691, v692, v693)
        local v695 = 1 + (v685.PaddingLeft.Scale + v685.PaddingRight.Scale) * 2
        local v696 = 1 + v685.PaddingTop.Scale + v685.PaddingBottom.Scale
        local v697 = v694 * Vector3.new(v695, v696, 1)
        local v698 = (v685.PaddingLeft.Offset + v685.PaddingRight.Offset) * 2
        local v699 = v685.PaddingBottom.Offset + v685.PaddingTop.Offset
        p684.Target = v697 + Vector3.new(v698, v699, 0)
    else
        p684.BodyText.Text = ""
        local v700 = (v685.PaddingLeft.Offset + v685.PaddingRight.Offset) * 2
        local v701 = v685.PaddingBottom.Offset + v685.PaddingTop.Offset + u331.TextSize
        p684.Target = Vector3.new(v700, v701, 1)
    end
end
function u48.BubbleChatMessage.ReBind(u702, p703) --[[ Line: 2010 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    if u702.InstanceBinds[p703.ClassName] ~= nil then
        u702.InstanceBinds[p703.ClassName]:Disconnect()
        u702.InstanceBinds[p703.ClassName] = nil
    end
    u702.InstanceBinds[p703.ClassName] = u48.InstanceBind.new(p703, u702.BindMap[p703.ClassName].Properties, u702.BindMap[p703.ClassName].Instances, u702.ChatMessage, "Parent", function() --[[ Line: 2015 ]]
        --[[
        Upvalues:
            [1] = u702
        --]]
        u702:UpdateChat()
    end)
end
function u48.BubbleChatMessage.UnBind(p704, p705) --[[ Line: 2019 ]]
    --[[
    Upvalues:
        [1] = u24
    --]]
    if p704.InstanceBinds[p705.ClassName] ~= nil then
        p704.InstanceBinds[p705.ClassName]:Disconnect()
        p704.InstanceBinds[p705.ClassName] = nil
    end
    p704:ReBind(u24:FindFirstChildWhichIsA(p705.ClassName) or Instance.new(p705.ClassName))
end
function u48.BubbleChatMessage.AddInstanceBinds(p706) --[[ Line: 2026 ]]
    --[[
    Upvalues:
        [1] = u331
        [2] = u24
    --]]
    for v707, _ in pairs(p706.BindMap) do
        p706:ReBind(u331:FindFirstChildWhichIsA(v707) or (u24:FindFirstChildWhichIsA(v707) or Instance.new(v707)))
    end
end
function u48.BubbleChatMessage.new(p708, p709) --[[ Line: 2032 ]]
    --[[
    Upvalues:
        [1] = u48
        [2] = u559
        [3] = u331
        [4] = u326
        [5] = u11
        [6] = u23
        [7] = u29
        [8] = u327
    --]]
    local v710 = {
        ["__index"] = u48.BubbleChatMessage
    }
    local u711 = setmetatable({}, v710)
    u711.Connection = u48.MultiConnection.new()
    u711.BubbleChatContainer = p708
    u711.Timestamp = p709.Timestamp.UnixTimestampMillis / 1000
    u711.Visible = false
    u711.InChatRange = false
    u711.InDistanceRange = false
    u711.LastMessage = true
    u711.Velocity = 0
    u711.Current = Vector3.new(0, 0, 0)
    u711.Target = u711.Current
    u711.ChatMessage = u559:Get()
    u711.ChatMessage.Visible = true
    u711.BodyText = u711.ChatMessage.ChatBubbleFrame.Text
    u711.ChatBubbleFrame = u711.ChatMessage.ChatBubbleFrame
    u711.Caret = u711.ChatMessage.Caret
    u711.BubbleDuration = u331.BubbleDuration
    u711.BackgroundTransparency = u331.BubbleDuration
    u711.MinimizeDistance = u331.MinimizeDistance
    u711.ChatTranslationEnabled = u326.ChatTranslationEnabled
    u711.Font = u331.Font
    u711.FontFace = u331.FontFace
    u711.TextSize = u331.TextSize
    u711.Enabled = true
    u711.Player = u711.BubbleChatContainer.Player
    u711.InstanceBinds = {}
    u711.BindMap = {
        ["UICorner"] = {
            ["Instances"] = { u711.ChatMessage.ChatBubbleFrame.UICorner },
            ["Properties"] = { "CornerRadius" }
        },
        ["UIGradient"] = {
            ["Instances"] = { u711.ChatMessage.ChatBubbleFrame.Gradient, u711.ChatMessage.Caret.Gradient },
            ["Properties"] = {
                "Color",
                "Enabled",
                "Offset",
                "Rotation",
                "Transparency"
            }
        },
        ["UIPadding"] = {
            ["Instances"] = { u711.ChatMessage.ChatBubbleFrame.Padding },
            ["Properties"] = {
                "PaddingBottom",
                "PaddingLeft",
                "PaddingRight",
                "PaddingTop"
            }
        },
        ["ImageLabel"] = {
            ["Instances"] = { u711.ChatMessage.ChatBubbleFrame },
            ["Properties"] = {
                "Image",
                "ImageColor3",
                "ImageRectOffset",
                "ImageRectSize",
                "ResampleMode",
                "ScaleType"
            }
        }
    }
    u711:AddInstanceBinds()
    u711.HasImage = u711.ChatBubbleFrame.Image == ""
    u711:SetMessage(p709)
    if u711.Player ~= nil then
        u711.Enabled = u331.Enabled
        u711.Connection:AddConnection(u48.PropertyBind.new(u331, { "Enabled" }, u711.ChatMessage, "Parent", function() --[[ Line: 2083 ]]
            --[[
            Upvalues:
                [1] = u711
                [2] = u331
            --]]
            u711.Enabled = u331.Enabled
            u711:UpdateVisibility()
        end))
    end
    u711.Connection:AddConnection(u11.Heartbeat:Connect(function(p712) --[[ Line: 2088 ]]
        --[[
        Upvalues:
            [1] = u711
            [2] = u23
        --]]
        u711:SmoothDamp(p712)
        if not u711.Destroying and u711.Timestamp + u711.BubbleDuration < os.time() then
            u711:UpdateVisibility(true)
        end
        if u711.BubbleChatContainer.Adornee ~= nil then
            local v713 = (u23.CFrame.Position - u711.BubbleChatContainer.Adornee.Position).Magnitude < u711.MinimizeDistance
            if v713 ~= u711.InDistanceRange then
                u711.InDistanceRange = v713
                u711:UpdateVisibility()
            end
        end
    end))
    u711.Connection:AddConnection(u29.ChildAdded:Connect(function(p714) --[[ Line: 2103 ]]
        --[[
        Upvalues:
            [1] = u711
        --]]
        if u711.BindMap[p714.ClassName] ~= nil then
            u711:ReBind(p714)
        end
    end))
    u711.Connection:AddConnection(u29.ChildRemoved:Connect(function(p715) --[[ Line: 2106 ]]
        --[[
        Upvalues:
            [1] = u711
        --]]
        if u711.BindMap[p715.ClassName] ~= nil then
            u711:UnBind(p715)
        end
    end))
    u711.Connection:AddConnection(u48.PropertyBind.new(u331, { "BubbleDuration" }, u711.ChatMessage, "Parent", function() --[[ Line: 2109 ]]
        --[[
        Upvalues:
            [1] = u711
            [2] = u331
        --]]
        u711.BubbleDuration = u331.BubbleDuration
    end))
    u711.BubbleDuration = u331.BubbleDuration
    u711.Connection:AddConnection(u48.PropertyBind.new(u331, { "MinimizeDistance" }, u711.ChatMessage, "Parent", function() --[[ Line: 2113 ]]
        --[[
        Upvalues:
            [1] = u711
            [2] = u331
        --]]
        u711.MinimizeDistance = u331.MinimizeDistance
    end))
    u711.MinimizeDistance = u331.MinimizeDistance
    u711.Connection:AddConnection(u48.PropertyBind.new(u711.ChatBubbleFrame, { "Image" }, u711.ChatMessage, "Parent", function() --[[ Line: 2117 ]]
        --[[
        Upvalues:
            [1] = u711
        --]]
        u711.HasImage = u711.ChatBubbleFrame.Image == ""
        u711:UpdateTransparency()
    end))
    u711.Connection:AddConnection(u48.PropertyBind.new(u331, { "BackgroundTransparency" }, u711.ChatMessage, "Parent", function() --[[ Line: 2121 ]]
        --[[
        Upvalues:
            [1] = u711
        --]]
        u711.BackgroundTransparency = u711:GetProperty("BackgroundTransparency")
    end))
    u711.BackgroundTransparency = u711:GetProperty("BackgroundTransparency")
    u711.Connection:AddConnection(u48.PropertyBind.new(u331, { "BackgroundColor3" }, u711.ChatMessage, "Parent", function() --[[ Line: 2125 ]]
        --[[
        Upvalues:
            [1] = u711
        --]]
        u711.ChatBubbleFrame.BackgroundColor3 = u711:GetProperty("BackgroundColor3")
        u711.ChatMessage.Caret.ImageColor3 = u711:GetProperty("BackgroundColor3")
    end))
    u711.ChatBubbleFrame.BackgroundColor3 = u711:GetProperty("BackgroundColor3")
    u711.ChatMessage.Caret.ImageColor3 = u711:GetProperty("BackgroundColor3")
    u711.Connection:AddConnection(u48.PropertyBind.new(u331, { "FontFace" }, u711.ChatMessage, "Parent", function() --[[ Line: 2131 ]]
        --[[
        Upvalues:
            [1] = u711
            [2] = u331
        --]]
        u711.Font = u331.Font
        u711.BodyText.FontFace = u711:GetProperty("FontFace")
        u711.FontFace = u711:GetProperty("FontFace")
        u711:UpdateChat()
    end))
    u711.Font = u331.Font
    u711.BodyText.FontFace = u711:GetProperty("FontFace")
    u711.FontFace = u711:GetProperty("FontFace")
    u711.Connection:AddConnection(u48.PropertyBind.new(u331, { "TextColor3" }, u711.ChatMessage, "Parent", function() --[[ Line: 2140 ]]
        --[[
        Upvalues:
            [1] = u711
        --]]
        u711.BodyText.TextColor3 = u711:GetProperty("TextColor3")
    end))
    u711.BodyText.TextColor3 = u711:GetProperty("TextColor3")
    u711.Connection:AddConnection(u48.PropertyBind.new(u331, { "TextSize" }, u711.ChatMessage, "Parent", function() --[[ Line: 2144 ]]
        --[[
        Upvalues:
            [1] = u711
        --]]
        u711.TextSize = u711:GetProperty("TextSize")
        u711.BodyText.TextSize = u711:GetProperty("TextSize")
        u711:UpdateChat()
    end))
    u711.TextSize = u711:GetProperty("TextSize")
    u711.BodyText.TextSize = u711:GetProperty("TextSize")
    u711.Connection:AddConnection(u48.PropertyBind.new(u331, { "TailVisible" }, u711.ChatMessage, "Parent", function() --[[ Line: 2151 ]]
        --[[
        Upvalues:
            [1] = u711
        --]]
        local v716 = u711.ChatMessage.Caret
        local v717 = u711:GetProperty("TailVisible")
        if v717 then
            v717 = u711.LastMessage
        end
        v716.Visible = v717
    end))
    local v718 = u711.ChatMessage.Caret
    local v719 = u711:GetProperty("TailVisible")
    if v719 then
        v719 = u711.LastMessage
    end
    v718.Visible = v719
    u711.Connection:AddConnection(u48.PropertyBind.new(u326, { "ChatTranslationEnabled" }, u711.ChatMessage, "Parent", function() --[[ Line: 2155 ]]
        --[[
        Upvalues:
            [1] = u711
            [2] = u326
        --]]
        u711.ChatTranslationEnabled = u326.ChatTranslationEnabled
        u711:UpdateChat()
    end))
    u711.ChatTranslationEnabled = u326.ChatTranslationEnabled
    u711.Connection:AddConnection(u48.PropertyBind.new(u327, { "FilterSpecialCharacters" }, u711.ChatMessage, "Parent", function() --[[ Line: 2160 ]]
        --[[
        Upvalues:
            [1] = u711
        --]]
        u711:UpdateChat()
    end))
    return u711
end
u48.DistantBubble = {
    ["__type"] = "distantBubble"
}
function u48.DistantBubble.CleanUp(p720) --[[ Line: 2168 ]]
    for _, v721 in pairs(p720.InstanceBinds) do
        v721:Disconnect()
    end
    p720.Connection:Disconnect()
    p720.InstanceBinds = {}
end
function u48.DistantBubble.Destroy(p722) --[[ Line: 2173 ]]
    p722:CleanUp()
    p722.ChatMessage:Destroy()
end
function u48.DistantBubble.UpdateTransparency(p723, _, _) --[[ Line: 2177 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    local v724 = u48.TransparencyMask(p723.BackgroundTransparency, p723.Current.Z) * 100
    local v725 = math.round(v724) / 100
    p723.LastTransparency = v725
    p723.ChatBubbleFrame.BackgroundTransparency = not p723.HasImage and 1 or v725
    p723.ChatBubbleFrame.ImageTransparency = p723.HasImage and 1 or v725
    p723.Caret.ImageTransparency = v725
end
function u48.DistantBubble.SmoothDamp(p726, p727) --[[ Line: 2185 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u48
    --]]
    local v728, v729 = u7:SmoothDamp(p726.Current, p726.Target, p726.Velocity, 0.15, 1000, p727)
    p726.Current = v728
    p726.Velocity = v729
    local v730 = u48.TransparencyMask(p726.BackgroundTransparency, p726.Current.Z) * 100
    local v731 = math.round(v730) / 100
    local v732 = UDim2.fromOffset
    local v733 = p726.Current.X
    local v734 = math.round(v733)
    local v735 = p726.Current.Y
    local v736 = v732(v734, (math.round(v735)))
    if v736 ~= p726.LastSize then
        p726.LastSize = v736
        p726.ChatMessage.Size = v736
    end
    if v731 ~= p726.LastTransparency then
        p726.LastTransparency = v731
        p726.ChatBubbleFrame.BackgroundTransparency = not p726.HasImage and 1 or v731
        p726.ChatBubbleFrame.ImageTransparency = p726.HasImage and 1 or v731
        p726.Caret.ImageTransparency = v731
    end
end
function u48.DistantBubble.UpdateVisibility(p737) --[[ Line: 2201 ]]
    p737.ChatMessage.Visible = not p737.InDistanceRange
    local v738 = not p737.InDistanceRange
    if v738 then
        v738 = p737.Enabled or p737.Player == nil
    end
    if p737.Visible ~= v738 then
        p737.Visible = v738
        if v738 then
            p737.Velocity = 0
            p737:UpdateChat()
            local v739 = p737.Target.Y
            p737.Current = Vector3.new(0, v739, 1)
            p737.ChatMessage.Size = UDim2.fromOffset(p737.Current.X, p737.Current.Y)
            return
        end
        p737.Velocity = 0
        p737:UpdateChat()
    end
end
function u48.DistantBubble.UpdateChat(p740) --[[ Line: 2217 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    if p740.Visible then
        local v741 = p740.ChatMessage.ChatBubbleFrame.Padding
        local v742 = u48.GetTextBounds(p740.BodyText.Text, p740.TextSize, p740.Font, p740.FontFace, u48.BubbleChatBounds)
        local v743 = v742.X
        local v744 = v742.Y
        local v745 = Vector3.new(v743, v744, 0)
        local v746 = 1 + (v741.PaddingLeft.Scale + v741.PaddingRight.Scale) * 2.5
        local v747 = 1 + (v741.PaddingTop.Scale + v741.PaddingBottom.Scale) * 0.75
        local v748 = v745 * Vector3.new(v746, v747, 1)
        local v749 = (v741.PaddingLeft.Offset + v741.PaddingRight.Offset) * 2.5 * p740.TextSize / 20
        local v750 = (v741.PaddingBottom.Offset + v741.PaddingTop.Offset) * 0.75 * p740.TextSize / 20
        p740.Target = v748 + Vector3.new(v749, v750, 0)
    end
end
function u48.DistantBubble.ReBind(u751, p752) --[[ Line: 2224 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    if u751.InstanceBinds[p752.ClassName] ~= nil then
        u751.InstanceBinds[p752.ClassName]:Disconnect()
        u751.InstanceBinds[p752.ClassName] = nil
    end
    u751.InstanceBinds[p752.ClassName] = u48.InstanceBind.new(p752, u751.BindMap[p752.ClassName].Properties, u751.BindMap[p752.ClassName].Instances, u751.ChatMessage, "Parent", function() --[[ Line: 2229 ]]
        --[[
        Upvalues:
            [1] = u751
        --]]
        u751:UpdateChat()
    end)
end
function u48.DistantBubble.UnBind(p753, p754) --[[ Line: 2233 ]]
    --[[
    Upvalues:
        [1] = u24
    --]]
    if p753.InstanceBinds[p754.ClassName] ~= nil then
        p753.InstanceBinds[p754.ClassName]:Disconnect()
        p753.InstanceBinds[p754.ClassName] = nil
    end
    p753:ReBind(u24[p754.ClassName] or Instance.new(p754.ClassName))
end
function u48.DistantBubble.AddInstanceBinds(p755) --[[ Line: 2240 ]]
    --[[
    Upvalues:
        [1] = u331
        [2] = u24
    --]]
    for v756, _ in pairs(p755.BindMap) do
        p755:ReBind(u331:FindFirstChildWhichIsA(v756) or (u24:FindFirstChildWhichIsA(v756) or Instance.new(v756)))
    end
end
function u48.DistantBubble.new(p757) --[[ Line: 2246 ]]
    --[[
    Upvalues:
        [1] = u48
        [2] = u18
        [3] = u331
        [4] = u326
        [5] = u11
        [6] = u23
        [7] = u29
    --]]
    local v758 = {
        ["__index"] = u48.DistantBubble
    }
    local u759 = setmetatable({}, v758)
    u759.Connection = u48.MultiConnection.new()
    u759.BubbleChatContainer = p757
    u759.Visible = false
    u759.InDistanceRange = false
    u759.Velocity = 0
    u759.Current = Vector3.new(0, 0, 0)
    u759.Target = u759.Current
    u759.ChatMessage = u18.Elements.BubbleChatMessage:Clone()
    u759.ChatMessage.Visible = false
    u759.BodyText = u759.ChatMessage.ChatBubbleFrame.Text
    u759.BodyText.Text = "..."
    u759.UIScale = Instance.new("UIScale")
    u759.UIScale.Scale = 0.75
    u759.UIScale.Parent = u759.ChatMessage
    u759.ChatBubbleFrame = u759.ChatMessage.ChatBubbleFrame
    u759.Caret = u759.ChatMessage.Caret
    u759.BubbleDuration = u331.BubbleDuration
    u759.BackgroundTransparency = u331.BubbleDuration
    u759.MinimizeDistance = u331.MinimizeDistance
    u759.ChatTranslationEnabled = u326.ChatTranslationEnabled
    u759.FontFace = u331.FontFace
    u759.Font = u331.Font
    u759.TextSize = u331.TextSize
    u759.Enabled = u331.Enabled
    u759.Player = u759.BubbleChatContainer.Player
    u759.InstanceBinds = {}
    u759.BindMap = {
        ["UICorner"] = {
            ["Instances"] = { u759.ChatMessage.ChatBubbleFrame.UICorner },
            ["Properties"] = { "CornerRadius" }
        },
        ["UIGradient"] = {
            ["Instances"] = { u759.ChatMessage.ChatBubbleFrame.Gradient, u759.ChatMessage.Caret.Gradient },
            ["Properties"] = {
                "Color",
                "Enabled",
                "Offset",
                "Rotation",
                "Transparency"
            }
        },
        ["UIPadding"] = {
            ["Instances"] = { u759.ChatMessage.ChatBubbleFrame.Padding },
            ["Properties"] = {
                "PaddingBottom",
                "PaddingLeft",
                "PaddingRight",
                "PaddingTop"
            }
        },
        ["ImageLabel"] = {
            ["Instances"] = { u759.ChatMessage.ChatBubbleFrame },
            ["Properties"] = {
                "Image",
                "ImageColor3",
                "ImageRectOffset",
                "ImageRectSize",
                "ResampleMode",
                "ScaleType"
            }
        }
    }
    u759:AddInstanceBinds()
    u759.HasImage = u759.ChatBubbleFrame.Image == ""
    if u759.Player ~= nil then
        u759.Enabled = u331.Enabled
        u759.Connection:AddConnection(u48.PropertyBind.new(u331, { "Enabled" }, u759.ChatMessage, "Parent", function() --[[ Line: 2295 ]]
            --[[
            Upvalues:
                [1] = u759
                [2] = u331
            --]]
            u759.Enabled = u331.Enabled
            u759:UpdateVisibility()
        end))
    end
    u759.Connection:AddConnection(u11.Heartbeat:Connect(function(p760) --[[ Line: 2300 ]]
        --[[
        Upvalues:
            [1] = u759
            [2] = u23
        --]]
        u759:SmoothDamp(p760)
        if u759.BubbleChatContainer.Adornee ~= nil then
            local v761 = (u23.CFrame.Position - u759.BubbleChatContainer.Adornee.Position).Magnitude < u759.MinimizeDistance
            if v761 ~= u759.InDistanceRange then
                u759.InDistanceRange = v761
                u759:UpdateVisibility()
            end
        end
    end))
    u759.Connection:AddConnection(u29.ChildAdded:Connect(function(p762) --[[ Line: 2310 ]]
        --[[
        Upvalues:
            [1] = u759
        --]]
        if u759.BindMap[p762.ClassName] ~= nil then
            u759:ReBind(p762)
        end
    end))
    u759.Connection:AddConnection(u29.ChildRemoved:Connect(function(p763) --[[ Line: 2313 ]]
        --[[
        Upvalues:
            [1] = u759
        --]]
        if u759.BindMap[p763.ClassName] ~= nil then
            u759:UnBind(p763)
        end
    end))
    u759.Connection:AddConnection(u48.PropertyBind.new(u331, { "BackgroundTransparency" }, u759.ChatMessage, "Parent", function() --[[ Line: 2316 ]]
        --[[
        Upvalues:
            [1] = u759
            [2] = u331
        --]]
        u759.BackgroundTransparency = u331.BackgroundTransparency
    end))
    u759.BackgroundTransparency = u331.BackgroundTransparency
    u759.Connection:AddConnection(u48.PropertyBind.new(u331, { "BubbleDuration" }, u759.ChatMessage, "Parent", function() --[[ Line: 2320 ]]
        --[[
        Upvalues:
            [1] = u759
            [2] = u331
        --]]
        u759.BubbleDuration = u331.BubbleDuration
    end))
    u759.BubbleDuration = u331.BubbleDuration
    u759.Connection:AddConnection(u48.PropertyBind.new(u331, { "MinimizeDistance" }, u759.ChatMessage, "Parent", function() --[[ Line: 2324 ]]
        --[[
        Upvalues:
            [1] = u759
            [2] = u331
        --]]
        u759.MinimizeDistance = u331.MinimizeDistance
    end))
    u759.MinimizeDistance = u331.MinimizeDistance
    u759.Connection:AddConnection(u48.PropertyBind.new(u759.ChatBubbleFrame, { "Image" }, u759.ChatMessage, "Parent", function() --[[ Line: 2328 ]]
        --[[
        Upvalues:
            [1] = u759
        --]]
        u759.HasImage = u759.ChatBubbleFrame.Image == ""
        u759:UpdateTransparency()
    end))
    u759.Connection:AddConnection(u48.StyleBind.new(u331, "BackgroundColor3", u759.ChatMessage, "Parent"):Add(u759.ChatMessage.ChatBubbleFrame, "BackgroundColor3"):Add(u759.ChatMessage.Caret, "ImageColor3"))
    u759.Connection:AddConnection(u48.StyleBind.new(u331, "FontFace", u759.ChatMessage, "Parent"):Add(u759.BodyText, "FontFace"))
    u759.Connection:AddConnection(u48.StyleBind.new(u331, "TextColor3", u759.ChatMessage, "Parent"):Add(u759.BodyText, "TextColor3"))
    u759.Connection:AddConnection(u48.StyleBind.new(u331, "TextSize", u759.ChatMessage, "Parent"):Add(u759.BodyText, "TextSize"))
    u759.Connection:AddConnection(u48.PropertyBind.new(u331, { "TailVisible" }, u759.ChatMessage, "Parent", function() --[[ Line: 2345 ]]
        --[[
        Upvalues:
            [1] = u759
            [2] = u331
        --]]
        u759.ChatMessage.Caret.Visible = u331.TailVisible
    end))
    u759.ChatMessage.Caret.Visible = u331.TailVisible
    u759.Connection:AddConnection(u48.PropertyBind.new(u331, { "FontFace", "TextSize" }, u759.ChatMessage, "Parent", function() --[[ Line: 2349 ]]
        --[[
        Upvalues:
            [1] = u759
            [2] = u331
        --]]
        u759.Font = u331.Font
        u759.FontFace = u331.FontFace
        u759.TextSize = u331.TextSize
        u759:UpdateChat()
    end))
    u759.Font = u331.Font
    u759.FontFace = u331.FontFace
    u759.TextSize = u331.TextSize
    u759.Connection:AddConnection(u48.PropertyBind.new(u326, { "ChatTranslationEnabled" }, u759.ChatMessage, "Parent", function() --[[ Line: 2358 ]]
        --[[
        Upvalues:
            [1] = u759
            [2] = u326
        --]]
        u759.ChatTranslationEnabled = u326.ChatTranslationEnabled
        u759:UpdateChat()
    end))
    u759.ChatTranslationEnabled = u326.ChatTranslationEnabled
    return u759
end
u48.BubbleChatContainer = {
    ["__type"] = "bubbleChatContainer"
}
u48.BubbleChatContainer.Instances = {}
function u48.BubbleChatContainer.CleanUp(p764) --[[ Line: 2369 ]]
    p764.Connection:Disconnect()
end
function u48.BubbleChatContainer.Destroy(p765) --[[ Line: 2372 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    u48.BubbleChatContainer.Instances[p765.PartOrCharacter] = nil
    p765:CleanUp()
    for _ = 1, #p765.BubbleChatMessages do
        table.remove(p765.BubbleChatMessages, 1):Destroy()
    end
    p765.Container:Destroy()
    p765.DistantBubble:Destroy()
end
function u48.BubbleChatContainer.AddMessage(p766, p767) --[[ Line: 2379 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    for v768, v769 in pairs(p766.BubbleChatMessages) do
        if v769.Message.MessageId == p767.MessageId then
            if p767.Text == "" or p767.Status ~= Enum.TextChatMessageStatus.Success and p767.Status ~= Enum.TextChatMessageStatus.Sending then
                local v770 = p766.BubbleChatMessages
                local v771 = table.remove
                local v772 = p766.BubbleChatMessages
                table.insert(v770, v771(v772, v768))
                v769:UpdateVisibility(true)
                v769.LastMessage = false
                v769.Caret.Visible = false
                v769.ChatMessage.LayoutOrder = 0
                local v773 = p766.BubbleChatMessages[1]
                if v773 ~= nil then
                    v773.LastMessage = true
                    local v774 = v773.Caret
                    local v775 = v773:GetProperty("TailVisible")
                    if v775 then
                        v775 = v773.LastMessage
                    end
                    v774.Visible = v775
                end
            else
                v769:SetMessage(p767)
            end
        end
    end
    if p767.Text == "" or p767.Status ~= Enum.TextChatMessageStatus.Success and p767.Status ~= Enum.TextChatMessageStatus.Sending then
        if #p766.BubbleChatMessages <= 0 then
            p766:Destroy()
        end
    else
        p766.BubbleChatLayoutOrder = p766.BubbleChatLayoutOrder + 1
        local v776 = u48.BubbleChatMessage.new(p766, p767)
        local v777 = v776.ChatMessage
        local v778 = p766.BubbleChatMessages[1]
        if v778 ~= nil then
            v778.LastMessage = false
            v778.Caret.Visible = false
        end
        local v779 = p766.BubbleChatMessages
        table.insert(v779, 1, v776)
        v777.LayoutOrder = p766.BubbleChatLayoutOrder
        v777.Parent = p766.BubbleChatList
        local v780 = v777.Caret
        local v781 = v776:GetProperty("TailVisible")
        if v781 then
            v781 = v776.LastMessage
        end
        v780.Visible = v781
        p766:UpdateMessages()
    end
end
function u48.BubbleChatContainer.UpdateMessages(p782) --[[ Line: 2414 ]]
    --[[
    Upvalues:
        [1] = u331
    --]]
    for v783, v784 in pairs(p782.BubbleChatMessages) do
        v784.InChatRange = v783 <= u331.MaxBubbles
        v784:UpdateVisibility()
    end
end
function u48.BubbleChatContainer.UpdateTarget(p785) --[[ Line: 2420 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    if p785.Adornee ~= nil then
        local v786 = p785.Adornee.Position ~= p785.LastPosition
        local v787 = not p785.Updated
        if v787 then
            if p785.LastUpdate + u48.RaycastInterval < os.clock() then
                v787 = p785.Visible
            else
                v787 = false
            end
        end
        if v786 or v787 then
            if v787 then
                p785.Updated = true
                p785.LastUpdate = os.clock()
                local v788 = workspace:Raycast(p785.Adornee.Position - u48.RayDown, u48.RayDown, p785.RaycastParams)
                local v789
                if v788 == nil then
                    v789 = p785.Adornee.Position
                else
                    v789 = v788.Position - p785.Adornee.Position
                end
                p785.Target = v789
                p785.LastPosition = p785.Adornee.Position
                return
            end
            p785.Updated = false
        end
    end
end
function u48.BubbleChatContainer.SmoothDamp(p790, p791) --[[ Line: 2437 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    if p790.Adornee ~= nil and p790.Visible then
        local v792, v793 = u7:SmoothDamp(p790.Current, p790.Target, p790.Velocity, 2, 1000, p791)
        p790.Current = v792
        p790.Velocity = v793
        p790.Container.StudsOffsetWorldSpace = p790.Current
    end
end
function u48.BubbleChatContainer.SetVisibility(p794, p795) --[[ Line: 2443 ]]
    --[[
    Upvalues:
        [1] = u31
    --]]
    if p794.Visible ~= p795 then
        p794.Visible = p795
        local v796 = p794.Container
        local v797
        if p795 then
            v797 = u31
        else
            v797 = nil
        end
        v796.Parent = v797
    end
end
function u48.BubbleChatContainer.new(p798) --[[ Line: 2449 ]]
    --[[
    Upvalues:
        [1] = u48
        [2] = u18
        [3] = u9
        [4] = u19
        [5] = u331
        [6] = u11
        [7] = u15
    --]]
    local v799 = {
        ["__index"] = u48.BubbleChatContainer
    }
    local u800 = setmetatable({}, v799)
    u800.Instances = nil
    u800.Connection = u48.MultiConnection.new()
    u800.PartOrCharacter = p798
    u800.BubbleChatMessages = {}
    u800.RaycastParams = RaycastParams.new()
    u800.RaycastParams.FilterType = Enum.RaycastFilterType.Include
    u800.RaycastParams.FilterDescendantsInstances = { u800.PartOrCharacter }
    u800.Container = u18.Elements.BubbleChatContainer:Clone()
    u800.Container.Enabled = true
    u800.Current = Vector3.new(0, 0, 0)
    u800.Target = u800.Current
    u800.Velocity = 0
    u800.BubbleChatLayoutOrder = 1
    u800.Player = u9:GetPlayerFromCharacter(p798)
    u800.IsLocalPlayer = u800.Player == u19
    u800.LastUpdate = 0
    u800.Updated = false
    u800.BubbleChatList = u800.Container.BubbleChatList
    u800.DistantBubble = u48.DistantBubble.new(u800)
    u800.DistantBubble.ChatMessage.Parent = u800.BubbleChatList
    if u800.PartOrCharacter:IsA("BasePart") then
        u800.Adornee = u800.PartOrCharacter
        u800.Container.Adornee = u800.Adornee
        u800:SetVisibility(u800.Adornee ~= nil)
    else
        u800.Adornee = u800.PartOrCharacter:FindFirstChild(u331.AdorneeName)
        u800.Container.Adornee = u800.Adornee
        u800:SetVisibility(u800.Adornee ~= nil)
        u800.Connection:AddConnection(u48.PropertyBind.new(u331, { "AdorneeName" }, u800.Container, "Parent", function() --[[ Line: 2492 ]]
            --[[
            Upvalues:
                [1] = u800
                [2] = u331
            --]]
            local v801 = u800
            local v802
            if u800.PartOrCharacter:IsA("BasePart") then
                v802 = u800.PartOrCharacter
            else
                v802 = u800.PartOrCharacter:FindFirstChild(u331.AdorneeName)
            end
            v801.Adornee = v802
            u800.Container.Adornee = u800.Adornee
            u800:SetVisibility(u800.Adornee ~= nil)
            u800.Current = u800.Target
        end))
    end
    u800:UpdateTarget()
    u800.Current = u800.Target
    u800.Connection:AddConnection(u11.Heartbeat:Connect(function(p803) --[[ Line: 2505 ]]
        --[[
        Upvalues:
            [1] = u800
        --]]
        u800:UpdateTarget()
        u800:SmoothDamp(p803)
    end))
    u800.Connection:AddConnection(u800.PartOrCharacter.Destroying:Connect(function(_) --[[ Line: 2509 ]]
        --[[
        Upvalues:
            [1] = u800
        --]]
        u800:Destroy()
    end))
    u800.Connection:AddConnection(u48.PropertyBind.new(u331, { "TailVisible" }, u800.Container, "Parent", function() --[[ Line: 2512 ]]
        --[[
        Upvalues:
            [1] = u800
            [2] = u331
            [3] = u48
        --]]
        u800.Container.BubbleChatList.CaretPadding.PaddingBottom = u331.TailVisible and u48.CaretPadding or u48.NoPadding
    end))
    u800.Container.BubbleChatList.CaretPadding.PaddingBottom = u331.TailVisible and u48.CaretPadding or u48.NoPadding
    u800.Connection:AddConnection(u48.PropertyBind.new(u331, { "MaxBubbles" }, u800.Container, "Parent", function() --[[ Line: 2516 ]]
        --[[
        Upvalues:
            [1] = u800
        --]]
        u800:UpdateMessages()
    end))
    u800.Connection:AddConnection(u48.PropertyBind.new(u331, { "BubblesSpacing" }, u800.Container, "Parent", function() --[[ Line: 2519 ]]
        --[[
        Upvalues:
            [1] = u800
            [2] = u331
        --]]
        u800.Container.BubbleChatList.Layout.Padding = UDim.new(0, u331.BubblesSpacing)
    end))
    u800.Container.BubbleChatList.Layout.Padding = UDim.new(0, u331.BubblesSpacing)
    u800.Connection:AddConnection(u48.PropertyBind.new(u331, { "VerticalStudsOffset" }, u800.Container, "Parent", function() --[[ Line: 2523 ]]
        --[[
        Upvalues:
            [1] = u800
            [2] = u331
            [3] = u48
        --]]
        local v804 = u800.Container
        local v805
        if u800.IsLocalPlayer then
            v805 = u331.LocalPlayerStudsOffset
        else
            v805 = u48.DisplayBubbleOffset
        end
        local v806 = u331.VerticalStudsOffset
        v804.StudsOffset = v805 + Vector3.new(0, v806, 0)
    end))
    u800.Connection:AddConnection(u48.PropertyBind.new(u331, { "LocalPlayerStudsOffset" }, u800.Container, "Parent", function() --[[ Line: 2526 ]]
        --[[
        Upvalues:
            [1] = u800
            [2] = u331
            [3] = u48
        --]]
        local v807 = u800.Container
        local v808
        if u800.IsLocalPlayer then
            v808 = u331.LocalPlayerStudsOffset
        else
            v808 = u48.DisplayBubbleOffset
        end
        local v809 = u331.VerticalStudsOffset
        v807.StudsOffset = v808 + Vector3.new(0, v809, 0)
    end))
    local v810 = u800.Container
    local v811
    if u800.IsLocalPlayer then
        v811 = u331.LocalPlayerStudsOffset
    else
        v811 = u48.DisplayBubbleOffset
    end
    local v812 = u331.VerticalStudsOffset
    v810.StudsOffset = v811 + Vector3.new(0, v812, 0)
    u800.Connection:AddConnection(u48.StyleBind.new(u331, "MaxDistance", u800.Container, "Parent"):Add(u800.Container, "MaxDistance"))
    if u15 then
        u800.Container.StudsOffset = Vector3.new(-2, 0, 0)
    end
    u48.BubbleChatContainer.Instances[u800.PartOrCharacter] = u800
    return u800
end
u48.ExperienceChat = {
    ["__type"] = "experienceChat"
}
function u48.ExperienceChat.CleanUp(p813) --[[ Line: 2544 ]]
    --[[
    Upvalues:
        [1] = u48
        [2] = u35
        [3] = u34
        [4] = u32
        [5] = u39
        [6] = u44
        [7] = u37
        [8] = u33
    --]]
    p813.Connection:Disconnect()
    u48.BackgroundFadeTransparency:Remove({
        u35,
        u34,
        u32.topBorder,
        u32.bottomBorder,
        u32.topPadding,
        u34.Background,
        u39,
        u44,
        u37,
        u34.Background.Container.SendButton.SendIcon,
        u33.HorizontalBar.Background,
        u33.HorizontalBar.BottomBorder,
        u33.HorizontalBar.TopCorner,
        u33.DropdownButton.TextButton,
        u33.DropdownButton.TextButton.DropdownIconImage,
        u33.DropdownButton.UnreadDot
    })
end
function u48.ExperienceChat.CloseBackgroundFade(p814) --[[ Line: 2565 ]]
    if p814.BackgroundFadeCoroutine ~= nil then
        task.cancel(p814.BackgroundFadeCoroutine)
        p814.BackgroundFadeCoroutine = nil
    end
end
function u48.ExperienceChat.StartBackgroundFade(p815) --[[ Line: 2571 ]]
    --[[
    Upvalues:
        [1] = u327
        [2] = u48
    --]]
    p815:CloseBackgroundFade()
    local v816 = u327.BackgroundFadeOutTime
    if tostring(v816) == "nan" then
        warn("BackgroundFadeOutTime cannot be NaN")
    elseif v816 ~= (1 / 0) then
        p815.BackgroundFadeCoroutine = task.delay(v816, u48.BackgroundFadeTransparency.SetTarget, u48.BackgroundFadeTransparency, 1)
    end
end
function u48.ExperienceChat.CloseTextFade(p817) --[[ Line: 2579 ]]
    if p817.TextFadeCoroutine ~= nil then
        task.cancel(p817.TextFadeCoroutine)
        p817.TextFadeCoroutine = nil
    end
end
function u48.ExperienceChat.StartTextFade(p818) --[[ Line: 2585 ]]
    --[[
    Upvalues:
        [1] = u327
        [2] = u48
    --]]
    p818:CloseTextFade()
    local v819 = u327.TextFadeOutTime
    local v820 = u327.BackgroundFadeOutTime
    local v821 = math.max(v819, v820)
    if tostring(v821) == "nan" then
        warn("BackgroundFadeOutTime cannot be NaN")
    elseif v821 ~= (1 / 0) then
        p818.TextFadeCoroutine = task.delay(v821, u48.TextFadeTransparency.SetTarget, u48.TextFadeTransparency, 1)
    end
end
function u48.ExperienceChat.RegisterActivity(p822, p823) --[[ Line: 2593 ]]
    --[[
    Upvalues:
        [1] = u329
        [2] = u48
    --]]
    if p823 == nil then
        p823 = false
    end
    local v824 = u329.IsFocused
    if not p823 then
        u48.BackgroundFadeTransparency:SetCurrent(0, 0)
        u48.BackgroundFadeTransparency:SetTarget(0)
        if v824 then
            p822:CloseBackgroundFade()
        else
            p822:StartBackgroundFade()
        end
    end
    u48.TextFadeTransparency:SetCurrent(0, 0)
    u48.TextFadeTransparency:SetTarget(0)
    if v824 then
        p822:CloseTextFade()
    else
        p822:StartTextFade()
    end
end
function u48.ExperienceChat.UpdateAutoCompleteBounds(_) --[[ Line: 2613 ]]
    --[[
    Upvalues:
        [1] = u48
        [2] = u32
        [3] = u47
        [4] = u18
        [5] = u45
    --]]
    local v825 = u48.GetAbsoluteSize(u48.GetViewportSize(), u32.Size, u32.uiSizeConstraint)
    local v826 = #u47:GetChildren() - 1
    local v827 = v825.Y
    local v828 = v826 * u18.Elements.TextChatAutoComplete.Size.Y.Offset
    local v829 = math.min(v827, v828)
    local v830 = math.min(v829, 105)
    u45.Size = UDim2.new(0.95, 0, 0, v830)
end
function u48.ExperienceChat.UpdateAutoComplete(p831) --[[ Line: 2620 ]]
    --[[
    Upvalues:
        [1] = u329
        [2] = u45
        [3] = u48
        [4] = u4
        [5] = u39
    --]]
    task.wait()
    if not (u329.IsFocused and u329.AutocompleteEnabled) then
        if u45.Visible ~= false then
            for _, v832 in pairs(u48.TextChatAutoComplete.Instances) do
                v832:SetVisibility(false)
            end
            u45.Visible = false
        end
        return
    end
    if not (u4.KeyboardEnabled and u48.OwnsTextBox()) then
        return
    end
    local v833, v834, v835 = u48.ParseAutoComplete(u39.Text, u39.CursorPosition)
    local v836 = false
    local v837 = {}
    if v834 ~= nil then
        for _, v838 in pairs(u48.TextChatAutoComplete.Instances) do
            local v839, v840
            if v838.AutoCompleteEnabled and (v833 == 1 or not v838.OnlyAtStart) and v838.MinReplaceLength <= v835 then
                local v841 = v838.ReplaceMatch
                local v842 = string.sub(v841, 0, v835)
                v839 = string.match(v834, v842) ~= nil
                if v839 then
                    v840 = string.len(v841) <= v835
                else
                    v840 = v839
                end
                v836 = v836 or v839
                if v839 and not v840 then
                    v838.ReplaceIndex = v833
                    v838.ReplaceWord = v834
                    v838.ReplaceLength = v835
                    table.insert(v837, v838)
                end
                if v840 and v838.CompleteWhenMatched then
                    u48.FillAutoComplete(u39, v833, v835, v838.ReplaceWith)
                    break
                end
            else
                v839 = false
                v840 = false
            end
            if v839 then
                v839 = not v840
            end
            v838:SetVisibility(v839)
        end
    end
    table.sort(v837, function(p843, p844) --[[ Line: 2665 ]]
        local v845 = p843.ReplaceMatch
        local v846 = p843.ReplaceMatch
        local v847 = string.len(v846)
        local v848 = p844.ReplaceMatch
        local v849 = string.len(v848)
        if v847 == v849 then
            return v845 < v848
        else
            return v847 < v849
        end
    end)
    for v850, v851 in pairs(v837) do
        if v851.Visible then
            v851.TextChatAutoComplete.LayoutOrder = v850
        end
    end
    u45.Visible = #v837 > 0
    p831:UpdateAutoCompleteBounds()
    if u48.CurrentAutoComplete ~= v837[1] then
        local v852 = u48.CurrentAutoComplete
        u48.CurrentAutoComplete = nil
        if v852 ~= nil then
            v852:UpdateAppearance()
        end
        u48.CurrentAutoComplete = v837[1]
        if v837[1] ~= nil then
            v837[1]:UpdateAppearance()
        end
    end
end
function u48.ExperienceChat.HandleInput(p853, p854) --[[ Line: 2687 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u48
        [3] = u329
        [4] = u39
        [5] = u330
    --]]
    if not u4.KeyboardEnabled then
        return
    end
    if u48.CurrentAutoComplete ~= nil then
        if p854.KeyCode == Enum.KeyCode.Up then
            local v855 = u48.CurrentAutoComplete.TextChatAutoComplete.LayoutOrder - 1
            for _, v856 in pairs(u48.TextChatAutoComplete.Instances) do
                if v856.Visible == true and v856.TextChatAutoComplete.LayoutOrder == v855 then
                    local v857 = u48.CurrentAutoComplete
                    u48.CurrentAutoComplete = v856
                    v857:UpdateAppearance()
                    v856:UpdateAppearance()
                    break
                end
            end
        elseif p854.KeyCode == Enum.KeyCode.Down then
            local v858 = u48.CurrentAutoComplete.TextChatAutoComplete.LayoutOrder + 1
            for _, v859 in pairs(u48.TextChatAutoComplete.Instances) do
                if v859.Visible == true and v859.TextChatAutoComplete.LayoutOrder == v858 then
                    local v860 = u48.CurrentAutoComplete
                    u48.CurrentAutoComplete = v859
                    v860:UpdateAppearance()
                    v859:UpdateAppearance()
                    break
                end
            end
        end
    end
    if p854.KeyCode == u329.KeyboardKeyCode and (u329.Enabled and (u48.OwnsTextBox() and u48.GetChatCoreGuiEnabled())) then
        task.wait()
        u39:CaptureFocus()
        u48.SetChatActive(true)
    end
    if p854.KeyCode == Enum.KeyCode.Backspace and (u329.Enabled and (u329.IsFocused and (u39.Text == "" and (not u330.Enabled and (u48.IsWhisper(u329.TargetTextChannel) or u48.IsTeam(u329.TargetTextChannel)))))) and u48.OwnsTextBox() then
        u329.TargetTextChannel = p853.LastNonWhisper
    end
end
function u48.ExperienceChat.SendChatInputBarTextBox(_) --[[ Line: 2727 ]]
    --[[
    Upvalues:
        [1] = u48
        [2] = u39
        [3] = u329
    --]]
    if u48.OwnsTextBox() then
        if u39.Text ~= "" and u329.TargetTextChannel ~= nil then
            local v861 = u39.Text
            u39.Text = ""
            u39:ReleaseFocus()
            u329.TargetTextChannel:SendAsync(v861)
            return
        end
        u39.Text = ""
        u39:ReleaseFocus()
    end
end
function u48.ExperienceChat.RegisterTextChatMessage(p862, p863) --[[ Line: 2740 ]]
    --[[
    Upvalues:
        [1] = u48
        [2] = u330
    --]]
    local v864
    if u48.TextChannel.Instances[p863.TextChannel] == nil then
        v864 = false
    else
        u48.TextChannel.Instances[p863.TextChannel]:AddMessage(p863)
        v864 = true
    end
    if p863.TextChannel.Name == "RBXSystem" then
        for _, v865 in pairs(u48.TextChannel.Instances) do
            if v865.TextChannel.Name == "RBXGeneral" then
                v865:AddMessage(p863)
                v864 = true
            end
        end
    end
    u48.TextChannel.Instances[u48.RBXAll]:AddMessage(p863)
    if not u330.Enabled or v864 then
        p862:RegisterActivity(true)
    end
end
function u48.ExperienceChat.AutoScrollToBottom(_) --[[ Line: 2763 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    local u866 = u44.Parent
    if u866 ~= nil then
        task.spawn(function() --[[ Line: 2768 ]]
            --[[
            Upvalues:
                [1] = u866
            --]]
            task.wait()
            local v867 = u866.AbsoluteCanvasSize.Y
            u866.CanvasSize = UDim2.fromOffset(0, v867)
            local v868 = u866
            local v869 = Vector2.new
            local v870 = v867 - u866.AbsoluteWindowSize.Y
            v868.CanvasPosition = v869(0, (math.max(0, v870)))
        end)
    end
end
function u48.ExperienceChat.FocusChanged(u871, p872) --[[ Line: 2775 ]]
    --[[
    Upvalues:
        [1] = u48
        [2] = u39
    --]]
    if u48.OwnsTextBox() then
        u39.Text = string.gsub(u39.Text, "%c", "")
        if p872 then
            if u48.CurrentAutoComplete == nil then
                u871:SendChatInputBarTextBox()
            else
                u48.CurrentAutoComplete:Replace()
                task.delay(0, function() --[[ Line: 2781 ]]
                    --[[
                    Upvalues:
                        [1] = u39
                        [2] = u871
                    --]]
                    u39.Text = string.gsub(u39.Text, "%c", "")
                    u871:UpdateTextBoxPlaceholder()
                end)
            end
        end
    end
    u871:TextBoxTextChanged()
    u871:UpdateTextBoxPlaceholder()
end
function u48.ExperienceChat.TextBoxTextChanged(p873) --[[ Line: 2793 ]]
    --[[
    Upvalues:
        [1] = u329
        [2] = u39
        [3] = u48
        [4] = u34
    --]]
    local _ = u329.IsFocused
    local v874 = p873.LastTextInput or ""
    local v875 = u39.Text
    if string.len(v875) > 200 then
        u39.Text = v874
    else
        v874 = v875
    end
    local v876 = v874 == ""
    u39.TextTransparency = u48.TransparencyMask(u39.Text == "" and 0.5 or 0, u48.BackgroundFadeTransparency.Transparency)
    u34.Background.Container.SendButton.SendIcon.ImageTransparency = v876 and 0.5 or 0
    u34.Background.Container.SendButton.SendIcon.ImageColor3 = not v876 and u329.TextColor3 or u329.PlaceholderColor3
    p873:UpdateAutoComplete()
    p873.LastTextInput = v874
end
function u48.ExperienceChat.BoundsChanged(p877) --[[ Line: 2808 ]]
    --[[
    Upvalues:
        [1] = u32
        [2] = u15
        [3] = u48
        [4] = u328
    --]]
    local v878 = u32.AbsoluteSize
    local v879 = u32.layout.AbsoluteContentSize
    local v880 = u15 and Vector3.new(0, 8, 0) or u48.Alignment[Enum.HorizontalAlignment][u328.HorizontalAlignment]
    local v881 = u48.Alignment[Enum.VerticalAlignment][u328.VerticalAlignment]
    local v882 = -v881.Z * (v879.Y - v878.Y)
    u32.Position = UDim2.new(v880.X, v880.Y, v881.X, v881.Y + v882)
    u32.AnchorPoint = Vector2.new(v880.Z, v881.Z)
    p877:UpdateAutoCompleteBounds()
end
function u48.ExperienceChat.UpdateTextBoxPlaceholder(_) --[[ Line: 2818 ]]
    --[[
    Upvalues:
        [1] = u329
        [2] = u39
        [3] = u10
        [4] = u4
        [5] = u48
    --]]
    if u329.IsFocused then
        u39.PlaceholderText = ""
    else
        u39.PlaceholderText = u10:IsTenFootInterface() and "Use that \"Chat\" button in the menu to chat" or (not u4.KeyboardEnabled and "Tap here to chat" or ("To chat click here or press %* key"):format((string.lower(u48.KeyCodeToChar(u329.KeyboardKeyCode)))))
    end
end
function u48.ExperienceChat.TargetTextChannelChanged(p883) --[[ Line: 2826 ]]
    --[[
    Upvalues:
        [1] = u329
        [2] = u48
    --]]
    if u329.TargetTextChannel ~= nil and not (u48.IsWhisper(u329.TargetTextChannel) or u48.IsTeam(u329.TargetTextChannel)) then
        p883.LastNonWhisper = u329.TargetTextChannel
    end
    p883:UpdateTextBoxChip()
end
function u48.ExperienceChat.UpdateTextBoxChip(_) --[[ Line: 2832 ]]
    --[[
    Upvalues:
        [1] = u330
        [2] = u48
        [3] = u329
        [4] = u37
        [5] = u38
    --]]
    if u330.Enabled or not (u48.IsWhisper(u329.TargetTextChannel) or u48.IsTeam(u329.TargetTextChannel)) then
        u37.Visible = false
        u38.Size = UDim2.new(1, -8, 0, 0)
    else
        local v884
        if u48.IsWhisper(u329.TargetTextChannel) then
            v884 = ("[To %*]"):format((u48.GetChannelName(u329.TargetTextChannel)))
        else
            v884 = ("[%*]"):format((u48.GetChannelName(u329.TargetTextChannel)))
        end
        u37.Visible = true
        u37.Text = v884
        local v885 = u48.GetTextBounds(v884, u37.TextSize, nil, u37.FontFace, u48.LongChatBounds)
        u37.Size = UDim2.new(0, v885.X, 1, 0)
        u38.Size = UDim2.new(1, -8 - v885.X, 0, 0)
    end
end
function u48.ExperienceChat.PopulateAutoComplete(_) --[[ Line: 2845 ]]
    --[[
    Upvalues:
        [1] = u21
        [2] = u48
    --]]
    local v886 = {}
    for v887, v888 in pairs(u21.Emojis) do
        table.insert(v886, {
            ["Name"] = v887,
            ["Emoji"] = v888
        })
    end
    table.sort(v886, function(p889, p890) --[[ Line: 2848 ]]
        local v891 = p889.Name
        local v892 = string.len(v891)
        local v893 = p890.Name
        local v894 = string.len(v893)
        if v892 == v894 then
            return p889.Name < p890.Name
        else
            return v892 < v894
        end
    end)
    for _, v895 in pairs(v886) do
        u48.TextChatAutoComplete.new(v895.Emoji, (":%*:"):format(v895.Name), ("%* %*"):format(v895.Emoji, v895.Name), 3, false, true, true, true)
    end
end
function u48.ExperienceChat.new() --[[ Line: 2859 ]]
    --[[
    Upvalues:
        [1] = u48
        [2] = u30
        [3] = u326
        [4] = u32
        [5] = u328
        [6] = u26
        [7] = u329
        [8] = u34
        [9] = u4
        [10] = u39
        [11] = u331
        [12] = u20
        [13] = u27
        [14] = u330
        [15] = u33
        [16] = u28
        [17] = u3
        [18] = u35
        [19] = u44
        [20] = u37
        [21] = u40
        [22] = u41
        [23] = u45
        [24] = u50
    --]]
    local v896 = {
        ["__index"] = u48.ExperienceChat
    }
    local u897 = setmetatable({}, v896)
    u897.Connection = u48.MultiConnection.new()
    u48.BackgroundFadeTransparency = u48.Transparency.new(1, u30, "Enabled")
    u48.TextFadeTransparency = u48.Transparency.new(1, u30, "Enabled")
    u326:__addgetter("ChatAbsolutePosition", function(_, _) --[[ Line: 2868 ]]
        --[[
        Upvalues:
            [1] = u32
        --]]
        return u32.AbsolutePosition
    end)
    u326:__addsetter("ChatAbsolutePosition", function(_, _, _) --[[ Line: 2869 ]]
        error("Unable to assign property ChatAbsolutePosition. Property is read only", 2)
    end)
    u326:__addsignal("ChatAbsolutePosition", u32:GetPropertyChangedSignal("AbsolutePosition"))
    u326:__addgetter("ChatAbsoluteSize", function(_, _) --[[ Line: 2871 ]]
        --[[
        Upvalues:
            [1] = u32
        --]]
        return u32.layout.AbsoluteContentSize
    end)
    u326:__addsetter("ChatAbsoluteSize", function(_, _, _) --[[ Line: 2872 ]]
        error("Unable to assign property ChatAbsoluteSize. Property is read only", 2)
    end)
    u326:__addsignal("ChatAbsoluteSize", u32.layout:GetPropertyChangedSignal("AbsoluteContentSize"))
    u326:__addgetter("ChatTextFaded", function(_, _) --[[ Line: 2874 ]]
        --[[
        Upvalues:
            [1] = u48
        --]]
        return u48.TextFadeTransparency.Target == 1
    end)
    u326:__addsetter("ChatTextFaded", function(_, _, _) --[[ Line: 2875 ]]
        error("Unable to assign property ChatTextFaded. Property is read only", 2)
    end)
    u326:__addsignal("ChatTextFaded", u48.TextFadeTransparency.FadedChanged)
    u326:__addgetter("ChatTextTransparency", function(_, _) --[[ Line: 2877 ]]
        --[[
        Upvalues:
            [1] = u48
        --]]
        return u48.TextFadeTransparency.Transparency
    end)
    u326:__addsetter("ChatTextTransparency", function(_, _, _) --[[ Line: 2878 ]]
        error("Unable to assign property ChatTextTransparency. Property is read only", 2)
    end)
    u326:__addsignal("ChatTextTransparency", u48.TextFadeTransparency.TransparencyChanged)
    u326:__addgetter("ChatBackgroundFaded", function(_, _) --[[ Line: 2880 ]]
        --[[
        Upvalues:
            [1] = u48
        --]]
        return u48.BackgroundFadeTransparency.Target == 1
    end)
    u326:__addsetter("ChatBackgroundFaded", function(_, _, _) --[[ Line: 2881 ]]
        error("Unable to assign property ChatBackgroundFaded. Property is read only", 2)
    end)
    u326:__addsignal("ChatBackgroundFaded", u48.BackgroundFadeTransparency.FadedChanged)
    u326:__addgetter("ChatBackgroundTransparency", function(_, _) --[[ Line: 2883 ]]
        --[[
        Upvalues:
            [1] = u48
        --]]
        return u48.BackgroundFadeTransparency.Transparency
    end)
    u326:__addsetter("ChatBackgroundTransparency", function(_, _, _) --[[ Line: 2884 ]]
        error("Unable to assign property ChatBackgroundTransparency. Property is read only", 2)
    end)
    u326:__addsignal("ChatBackgroundTransparency", u48.BackgroundFadeTransparency.TransparencyChanged)
    u328:__addgetter("AbsolutePosition", function(_, _) --[[ Line: 2888 ]]
        --[[
        Upvalues:
            [1] = u32
        --]]
        return u32.AbsolutePosition
    end)
    u328:__addsetter("AbsolutePosition", function(_, _, _) --[[ Line: 2889 ]]
        error("Unable to assign property AbsolutePosition. Property is read only", 2)
    end)
    u328:__addsignal("AbsolutePosition", u32:GetPropertyChangedSignal("AbsolutePosition"))
    u328:__addgetter("AbsoluteSize", function(_, _) --[[ Line: 2891 ]]
        --[[
        Upvalues:
            [1] = u32
        --]]
        return u32.AbsoluteSize
    end)
    u328:__addsetter("AbsoluteSize", function(_, _, _) --[[ Line: 2892 ]]
        error("Unable to assign property AbsoluteSize. Property is read only", 2)
    end)
    u328:__addsignal("AbsoluteSize", u32:GetPropertyChangedSignal("AbsoluteSize"))
    u328:__addgetter("Enabled", function(p898, p899) --[[ Line: 2894 ]]
        return p898.__class[p899]
    end)
    u328:__addsetter("Enabled", function(p900, p901, p902) --[[ Line: 2895 ]]
        p900.__class[p901] = p902
    end)
    u328:__addsignal("Enabled")
    u328.__class.Enabled = u26.Enabled
    u329:__addgetter("AbsolutePosition", function(_, _) --[[ Line: 2900 ]]
        --[[
        Upvalues:
            [1] = u34
        --]]
        return u34.AbsolutePosition
    end)
    u329:__addsetter("AbsolutePosition", function(_, _, _) --[[ Line: 2901 ]]
        error("Unable to assign property AbsolutePosition. Property is read only", 2)
    end)
    u329:__addsignal("AbsolutePosition", u34:GetPropertyChangedSignal("AbsolutePosition"))
    u329:__addgetter("AbsoluteSize", function(_, _) --[[ Line: 2903 ]]
        --[[
        Upvalues:
            [1] = u34
        --]]
        return u34.AbsoluteSize
    end)
    u329:__addsetter("AbsoluteSize", function(_, _, _) --[[ Line: 2904 ]]
        error("Unable to assign property AbsoluteSize. Property is read only", 2)
    end)
    u329:__addsignal("AbsoluteSize", u34:GetPropertyChangedSignal("AbsoluteSize"))
    u329:__addgetter("IsFocused", function(_, _) --[[ Line: 2906 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u39
        --]]
        return u4:GetFocusedTextBox() == u39
    end)
    u329:__addsetter("IsFocused", function(_, _, _) --[[ Line: 2907 ]]
        error("Unable to assign property IsFocused. Property is read only", 2)
    end)
    u329:__addsignal("IsFocused")
    u897.Connection:AddConnection(u39.Focused:Connect(function(p903) --[[ Line: 2909 ]]
        --[[
        Upvalues:
            [1] = u39
            [2] = u331
        --]]
        if p903 == u39 then
            u331.__signals.IsFocused:Fire()
        end
    end))
    u897.Connection:AddConnection(u39.FocusLost:Connect(function(p904) --[[ Line: 2910 ]]
        --[[
        Upvalues:
            [1] = u39
            [2] = u331
        --]]
        if p904 == u39 then
            u331.__signals.IsFocused:Fire()
        end
    end))
    u329:__addgetter("TextBox", function(p905, p906) --[[ Line: 2911 ]]
        return p905.__class[p906]
    end)
    u329:__addsetter("TextBox", function(p907, p908, p909) --[[ Line: 2912 ]]
        --[[
        Upvalues:
            [1] = u39
            [2] = u20
            [3] = u48
        --]]
        if p909 == u39 then
            error("Expected TextBox got TextBox for ChatInputBarConfiguration.TextBox.", 2)
        else
            if typeof(p909) == "nil" or typeof(p909) == "Instance" then
                if typeof(p909) == "Instance" then
                    if not p909:IsA("TextBox") then
                        error(("Expected TextBox got %* for ChatInputBarConfiguration.TextBox."):format(p909.ClassName), 2)
                        return
                    end
                    if not p909:IsDescendantOf(u20) then
                        error("ChatInputBarConfiguration.TextBox should be a descendant of PlayerGui.", 2)
                        return
                    end
                end
                if p907.__class[p908] == p909 then
                    return false
                end
                p907.__class[p908] = p909
                u48.UpdateTextBox()
                return true
            end
            error(("Unable to assign property TextBox. TextBox expected, got %*"):format((typeof(p909))), 2)
        end
    end)
    u329:__addsignal("TextBox")
    u329.__class.TextBox = u27.TextBox
    u329:__addgetter("Enabled", function(p910, p911) --[[ Line: 2927 ]]
        return p910.__class[p911]
    end)
    u329:__addsetter("Enabled", function(p912, p913, p914) --[[ Line: 2928 ]]
        p912.__class[p913] = p914
    end)
    u329:__addsignal("Enabled")
    u329.__class.Enabled = u27.Enabled
    u330:__addgetter("AbsolutePosition", function(_, _) --[[ Line: 2933 ]]
        --[[
        Upvalues:
            [1] = u34
        --]]
        return u34.AbsolutePosition
    end)
    u330:__addsetter("AbsolutePosition", function(_, _, _) --[[ Line: 2934 ]]
        error("Unable to assign property AbsolutePosition. Property is read only")
    end)
    u330:__addsignal("AbsolutePosition", u33:GetPropertyChangedSignal("AbsolutePosition"))
    u330:__addgetter("AbsoluteSize", function(_, _) --[[ Line: 2936 ]]
        --[[
        Upvalues:
            [1] = u34
        --]]
        return u34.AbsoluteSize
    end)
    u330:__addsetter("AbsoluteSize", function(_, _, _) --[[ Line: 2937 ]]
        error("Unable to assign property AbsoluteSize. Property is read only")
    end)
    u330:__addsignal("AbsoluteSize", u33:GetPropertyChangedSignal("AbsoluteSize"))
    u330:__addgetter("Enabled", function(p915, p916) --[[ Line: 2939 ]]
        return p915.__class[p916]
    end)
    u330:__addsetter("Enabled", function(p917, p918, p919) --[[ Line: 2940 ]]
        p917.__class[p918] = p919
    end)
    u330:__addsignal("Enabled")
    u330.__class.Enabled = u28.Enabled
    u26.Enabled = false
    u27.Enabled = false
    u28.Enabled = false
    u30.Enabled = false
    u30.Parent = u20
    u48.TextChannel.Instances[u48.RBXAll] = u48.TextChannel.new(u48.RBXAll)
    u897.Connection:AddConnection(u48.DeepPipe(u3, u48.TextChannel, function() --[[ Line: 2953 ]]
        --[[
        Upvalues:
            [1] = u48
        --]]
        u48.SetTextChannels()
        u48.UpdateChannelTabs()
    end))
    u897.Connection:AddConnection(u48.DeepPipe(u3, u48.TextChatCommand))
    u897.Connection:AddConnection(u326.SendingMessage:Connect(function(p920) --[[ Line: 2961 ]]
        --[[
        Upvalues:
            [1] = u897
        --]]
        u897:RegisterTextChatMessage(p920)
    end))
    u897.Connection:AddConnection(u326.MessageReceived:Connect(function(p921) --[[ Line: 2966 ]]
        --[[
        Upvalues:
            [1] = u897
        --]]
        u897:RegisterTextChatMessage(p921)
    end))
    task.spawn(u48.BackgroundFadeTransparency.Add, u48.BackgroundFadeTransparency, {
        u35,
        u34,
        u32.topBorder,
        u32.bottomBorder,
        u32.topPadding,
        u34.Background,
        u39,
        u44,
        u37,
        u34.Background.Container.SendButton.SendIcon,
        u33.HorizontalBar.Background,
        u33.HorizontalBar.BottomBorder,
        u33.HorizontalBar.TopCorner,
        u33.DropdownButton.TextButton,
        u33.DropdownButton.TextButton.DropdownIconImage,
        u33.DropdownButton.UnreadDot
    })
    u897.Connection:AddConnection(u48.BackgroundFadeTransparency.TransparencyChanged:Connect(function(p922) --[[ Line: 2991 ]]
        --[[
        Upvalues:
            [1] = u39
            [2] = u48
            [3] = u40
            [4] = u41
        --]]
        u39.TextTransparency = u48.TransparencyMask(u39.Text == "" and 0.5 or 0, p922)
        u40.Transparency = u48.TransparencyMask(0.8, p922)
        u41.Transparency = p922
    end))
    u897.Connection:AddConnection(u48.StyleBind.new(u329, "BackgroundColor3", u30, "Enabled"):Add(u45.ScrollBarFrame, "BackgroundColor3"):Add(u34.Background, "BackgroundColor3"))
    u897.Connection:AddConnection(u48.StyleBind.new(u329, "BackgroundTransparency", u30, "Enabled"):Add(u34.Background, "Transparency"))
    u897.Connection:AddConnection(u48.StyleBind.new(u329, "TextColor3", u30, "Enabled"):Add(u39, "TextColor3"))
    u897.Connection:AddConnection(u48.StyleBind.new(u329, "PlaceholderColor3", u30, "Enabled"):Add(u39, "PlaceholderColor3"))
    u897.Connection:AddConnection(u48.StyleBind.new(u329, "FontFace", u30, "Enabled"):Add(u39, "FontFace"))
    u897.Connection:AddConnection(u48.StyleBind.new(u329, "TextSize", u30, "Enabled"):Add(u39, "TextSize"))
    u897.Connection:AddConnection(u48.StyleBind.new(u329, "TextStrokeTransparency", u30, "Enabled"):Add(u39, "TextStrokeTransparency"))
    u897.Connection:AddConnection(u48.PropertyBind.new(u329, { "KeyboardKeyCode" }, u30, "Enabled", function() --[[ Line: 3020 ]]
        --[[
        Upvalues:
            [1] = u897
        --]]
        u897:UpdateTextBoxPlaceholder()
    end))
    u897.Connection:AddConnection(u48.StyleBind.new(u330, "BackgroundColor3", u30, "Enabled"):Add(u33.HorizontalBar.Background, "BackgroundColor3"):Add(u33.HorizontalBar.TopCorner, "ImageColor3"))
    u897.Connection:AddConnection(u48.StyleBind.new(u330, "BackgroundTransparency", u30, "Enabled"):Add(u33.HorizontalBar.Background, "BackgroundTransparency"):Add(u33.HorizontalBar.TopCorner, "ImageTransparency"))
    u897.Connection:AddConnection(u48.StyleBind.new(u328, "BackgroundColor3", u30, "Enabled"):Add(u34, "BackgroundColor3"):Add(u35, "BackgroundColor3"):Add(u32.topPadding, "BackgroundColor3"):Add(u32.bottomBorder, "ImageColor3"):Add(u32.topBorder, "ImageColor3"))
    u897.Connection:AddConnection(u48.StyleBind.new(u328, "BackgroundTransparency", u30, "Enabled"):Add(u34, "Transparency"):Add(u35, "Transparency"):Add(u32.topPadding, "Transparency"):Add(u32.bottomBorder, "ImageTransparency"):Add(u32.topBorder, "ImageTransparency"))
    u897.Connection:AddConnection(u48.PropertyBind.new(u328, { "WidthScale", "HeightScale" }, u30, "Enabled", function() --[[ Line: 3048 ]]
        --[[
        Upvalues:
            [1] = u32
            [2] = u328
        --]]
        u32.Size = UDim2.fromScale(0.4 * u328.WidthScale, 0.25 * u328.HeightScale)
    end))
    u32.Size = UDim2.fromScale(0.4 * u328.WidthScale, 0.25 * u328.HeightScale)
    u897.Connection:AddConnection(u48.PropertyBind.new(u328, { "VerticalAlignment", "HorizontalAlignment" }, u30, "Enabled", function() --[[ Line: 3054 ]]
        --[[
        Upvalues:
            [1] = u897
        --]]
        u897:BoundsChanged()
    end))
    u897.Connection:AddConnection(u48.PropertyBind.new(u32.layout, { "AbsoluteContentSize" }, u30, "Enabled", function() --[[ Line: 3057 ]]
        --[[
        Upvalues:
            [1] = u897
            [2] = u48
        --]]
        u897:BoundsChanged()
        u48.UpdateChannelTabs()
    end))
    task.spawn(u897.BoundsChanged, u897)
    u897.Connection:AddConnection(u48.PropertyBind.new(u328, { "Enabled" }, u30, "Enabled", function() --[[ Line: 3064 ]]
        --[[
        Upvalues:
            [1] = u35
            [2] = u328
        --]]
        u35.Visible = u328.Enabled
    end))
    task.spawn(function() --[[ Line: 3067 ]]
        --[[
        Upvalues:
            [1] = u35
            [2] = u328
        --]]
        u35.Visible = u328.Enabled
    end)
    u897.Connection:AddConnection(u48.PropertyBind.new(u329, { "Enabled" }, u30, "Enabled", function() --[[ Line: 3070 ]]
        --[[
        Upvalues:
            [1] = u34
            [2] = u329
            [3] = u48
        --]]
        local v923 = u34
        local v924 = u329.Enabled
        if v924 then
            v924 = u329.TextBox == nil
        end
        v923.Visible = v924
        u48.UpdateTextBox()
    end))
    task.spawn(function() --[[ Line: 3074 ]]
        --[[
        Upvalues:
            [1] = u34
            [2] = u329
            [3] = u48
        --]]
        local v925 = u34
        local v926 = u329.Enabled
        if v926 then
            v926 = u329.TextBox == nil
        end
        v925.Visible = v926
        u48.UpdateTextBox()
    end)
    u897.Connection:AddConnection(u48.PropertyBind.new(u329, { "TextBox" }, u30, "Enabled", function() --[[ Line: 3078 ]]
        --[[
        Upvalues:
            [1] = u34
            [2] = u329
        --]]
        local v927 = u34
        local v928 = u329.Enabled
        if v928 then
            v928 = u329.TextBox == nil
        end
        v927.Visible = v928
    end))
    task.spawn(function() --[[ Line: 3081 ]]
        --[[
        Upvalues:
            [1] = u34
            [2] = u329
        --]]
        local v929 = u34
        local v930 = u329.Enabled
        if v930 then
            v930 = u329.TextBox == nil
        end
        v929.Visible = v930
    end)
    u897.Connection:AddConnection(u48.PropertyBind.new(u330, { "Enabled" }, u30, "Enabled", function() --[[ Line: 3084 ]]
        --[[
        Upvalues:
            [1] = u33
            [2] = u330
            [3] = u32
        --]]
        u33.Visible = u330.Enabled
        u32.topPadding.Visible = u330.Enabled
        u32.topBorder.Visible = not u330.Enabled
    end))
    task.spawn(function() --[[ Line: 3089 ]]
        --[[
        Upvalues:
            [1] = u33
            [2] = u330
            [3] = u32
        --]]
        u33.Visible = u330.Enabled
        u32.topPadding.Visible = u330.Enabled
        u32.topBorder.Visible = not u330.Enabled
    end)
    u897.Connection:AddConnection(u48.PropertyBind.new(u330, { "Enabled" }, u30, "Enabled", function() --[[ Line: 3094 ]]
        --[[
        Upvalues:
            [1] = u48
            [2] = u897
        --]]
        u48.UpdateTextChatMessages()
        u897:UpdateTextBoxChip()
    end))
    u897.Connection:AddConnection(u50:Connect(function() --[[ Line: 3101 ]]
        --[[
        Upvalues:
            [1] = u48
            [2] = u30
            [3] = u897
        --]]
        local v931 = u48.GetChatActive()
        if v931 then
            v931 = u48.GetChatCoreGuiEnabled()
        end
        u30.Enabled = v931
        u48.UpdateTextBox()
        u897:RegisterActivity()
    end))
    task.spawn(function() --[[ Line: 3108 ]]
        --[[
        Upvalues:
            [1] = u48
            [2] = u30
        --]]
        local v932 = u48.GetChatActive()
        if v932 then
            v932 = u48.GetChatCoreGuiEnabled()
        end
        u30.Enabled = v932
        u48.UpdateTextBox()
    end)
    u897.Connection:AddConnection(u48.PropertyBind.new(u39, { "Text" }, u30, "Enabled", function() --[[ Line: 3115 ]]
        --[[
        Upvalues:
            [1] = u897
        --]]
        u897:TextBoxTextChanged()
    end))
    u897.Connection:AddConnection(u48.PropertyBind.new(u329, { "AutocompleteEnabled" }, nil, nil, function() --[[ Line: 3118 ]]
        --[[
        Upvalues:
            [1] = u897
        --]]
        u897:UpdateAutoComplete()
    end))
    u897.Connection:AddConnection(u39.Focused:Connect(function() --[[ Line: 3122 ]]
        --[[
        Upvalues:
            [1] = u897
        --]]
        u897:FocusChanged()
        u897:RegisterActivity()
    end))
    u897.Connection:AddConnection(u39.FocusLost:Connect(function(p933) --[[ Line: 3128 ]]
        --[[
        Upvalues:
            [1] = u897
        --]]
        u897:FocusChanged(p933)
        u897:RegisterActivity()
    end))
    u897.Connection:AddConnection(u4.TextBoxFocused:Connect(function() --[[ Line: 3134 ]]
        --[[
        Upvalues:
            [1] = u897
        --]]
        u897:FocusChanged()
    end))
    u897.Connection:AddConnection(u4.TextBoxFocusReleased:Connect(function() --[[ Line: 3139 ]]
        --[[
        Upvalues:
            [1] = u897
        --]]
        u897:FocusChanged()
    end))
    task.spawn(u897.FocusChanged, u897)
    u897.Connection:AddConnection(u4.InputBegan:Connect(function(p934) --[[ Line: 3145 ]]
        --[[
        Upvalues:
            [1] = u897
        --]]
        u897:HandleInput(p934)
    end))
    u897.Connection:AddConnection(u34.Background.Container.SendButton.Activated:Connect(function() --[[ Line: 3150 ]]
        --[[
        Upvalues:
            [1] = u897
        --]]
        u897:SendChatInputBarTextBox()
    end))
    task.spawn(u897.RegisterActivity, u897)
    task.spawn(function() --[[ Line: 3157 ]]
        --[[
        Upvalues:
            [1] = u32
            [2] = u897
        --]]
        for _, v935 in pairs(u32:GetChildren()) do
            if v935:IsA("GuiObject") then
                u897.Connection:AddConnection(v935.MouseEnter:Connect(function() --[[ Line: 3161 ]]
                    --[[
                    Upvalues:
                        [1] = u897
                    --]]
                    u897:RegisterActivity()
                end))
                u897.Connection:AddConnection(v935.MouseLeave:Connect(function() --[[ Line: 3166 ]]
                    --[[
                    Upvalues:
                        [1] = u897
                    --]]
                    u897:RegisterActivity()
                end))
            end
        end
    end)
    u897.Connection:AddConnection(u44.ChildAdded:Connect(function(_) --[[ Line: 3176 ]]
        --[[
        Upvalues:
            [1] = u897
        --]]
        u897:AutoScrollToBottom()
    end))
    u897.Connection:AddConnection(u35.MouseEnter:Connect(function() --[[ Line: 3181 ]]
        --[[
        Upvalues:
            [1] = u44
        --]]
        u44.Parent.ScrollBarImageTransparency = 0
    end))
    u897.Connection:AddConnection(u35.MouseLeave:Connect(function() --[[ Line: 3186 ]]
        --[[
        Upvalues:
            [1] = u44
        --]]
        u44.Parent.ScrollBarImageTransparency = 1
    end))
    u897.Connection:AddConnection(u48.PropertyBind.new(u329, { "TargetTextChannel" }, nil, nil, function() --[[ Line: 3192 ]]
        --[[
        Upvalues:
            [1] = u897
            [2] = u48
            [3] = u44
        --]]
        u897:TargetTextChannelChanged()
        u48.UpdateTextChatMessages()
        u48.UpdateChannelTabs()
        local v936 = u44.Parent
        v936.CanvasPosition = Vector2.new(v936.CanvasPosition.X, v936.AbsoluteCanvasSize.Y - v936.AbsoluteWindowSize.Y)
    end))
    task.spawn(u897.TargetTextChannelChanged, u897)
    u897.Connection:AddConnection(u37.Activated:Connect(function() --[[ Line: 3201 ]]
        --[[
        Upvalues:
            [1] = u330
            [2] = u48
            [3] = u329
            [4] = u897
        --]]
        if not u330.Enabled and (u48.IsWhisper(u329.TargetTextChannel) or u48.IsTeam(u329.TargetTextChannel)) then
            u329.TargetTextChannel = u897.LastNonWhisper
        end
    end))
    u897.Connection:AddConnection(u33.DropdownButton.TextButton.Activated:Connect(function() --[[ Line: 3208 ]]
        --[[
        Upvalues:
            [1] = u33
        --]]
        u33.DropdownMenu.Visible = not u33.DropdownMenu.Visible
    end))
    u897.Connection:AddConnection(u33.DropdownButton.TextButton.MouseEnter:Connect(function() --[[ Line: 3213 ]]
        --[[
        Upvalues:
            [1] = u33
        --]]
        u33.DropdownButton.TextButton.BackgroundTransparency = 0.3
    end))
    u897.Connection:AddConnection(u33.DropdownButton.TextButton.MouseLeave:Connect(function() --[[ Line: 3218 ]]
        --[[
        Upvalues:
            [1] = u33
        --]]
        u33.DropdownButton.TextButton.BackgroundTransparency = 1
    end))
    task.spawn(u897.PopulateAutoComplete, u897)
    return u897
end
u48.BubbleChat = {
    ["__type"] = "bubbleChat"
}
function u48.BubbleChat.CleanUp(p937) --[[ Line: 3230 ]]
    p937.Connection:Disconnect()
end
function u48.BubbleChat.RegisterTextChatMessage(_, p938, p939) --[[ Line: 3233 ]]
    --[[
    Upvalues:
        [1] = u48
    --]]
    if u48.BubbleChatContainer.Instances[p938] == nil then
        u48.BubbleChatContainer.new(p938)
    end
    u48.BubbleChatContainer.Instances[p938]:AddMessage(p939)
end
function u48.BubbleChat.new() --[[ Line: 3237 ]]
    --[[
    Upvalues:
        [1] = u48
        [2] = u331
        [3] = u29
        [4] = u31
        [5] = u20
        [6] = u326
        [7] = u9
    --]]
    local v940 = {
        ["__index"] = u48.BubbleChat
    }
    local u941 = setmetatable({}, v940)
    u941.Connection = u48.MultiConnection.new()
    u331:__addsetter("MaxBubbles", function(p942, p943, p944) --[[ Line: 3242 ]]
        p942.__class[p943] = p944
    end)
    u331:__addgetter("MaxBubbles", function(p945, p946) --[[ Line: 3243 ]]
        return p945.__class[p946]
    end)
    u331.__class.MaxBubbles = u29.MaxBubbles
    u331:__addsignal("MaxBubbles")
    u331:__addsetter("Enabled", function(p947, p948, p949) --[[ Line: 3246 ]]
        p947.__class[p948] = p949
    end)
    u331:__addgetter("Enabled", function(p950, p951) --[[ Line: 3247 ]]
        return p950.__class[p951]
    end)
    u331:__addsignal("Enabled")
    u331.__class.Enabled = u29.Enabled
    u29.Enabled = false
    u29.MaxBubbles = 0
    u31.Enabled = true
    u31.Parent = u20
    u941.Connection:AddConnection(u326.BubbleDisplayed:Connect(function(p952, p953) --[[ Line: 3259 ]]
        --[[
        Upvalues:
            [1] = u941
        --]]
        u941:RegisterTextChatMessage(p952, p953)
    end))
    u941.Connection:AddConnection(u326.SendingMessage:Connect(function(p954) --[[ Line: 3264 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u941
        --]]
        if p954.TextSource == nil then
            return
        else
            local v955 = u9:GetPlayerByUserId(p954.TextSource.UserId)
            if v955 == nil then
                return
            else
                local v956 = v955.Character
                if v956 ~= nil then
                    u941:RegisterTextChatMessage(v956, p954)
                end
            end
        end
    end))
    u941.Connection:AddConnection(u326.MessageReceived:Connect(function(p957) --[[ Line: 3274 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u941
        --]]
        if p957.TextSource == nil then
            return
        else
            local v958 = u9:GetPlayerByUserId(p957.TextSource.UserId)
            if v958 == nil then
                return
            else
                local v959 = v958.Character
                if v959 ~= nil then
                    u941:RegisterTextChatMessage(v959, p957)
                end
            end
        end
    end))
    return u941
end
u48.TextChatService = {
    ["__type"] = "textChatService"
}
function u48.TextChatService.CleanUp(p960) --[[ Line: 3288 ]]
    p960.Connection:Disconnect()
end
function u48.TextChatService.VisibilityChanged(p961) --[[ Line: 3291 ]]
    --[[
    Upvalues:
        [1] = u48
        [2] = u52
        [3] = u55
        [4] = u51
        [5] = u54
    --]]
    local v962 = u48.GetChatActive()
    local v963 = u48.GetChatCoreGuiEnabled()
    local v964 = v962 and v963
    if u48.ChatActive ~= v962 then
        u48.ChatActive = v962
        u52:Fire()
    end
    if u48.CoreGuiEnabled ~= v963 then
        u48.CoreGuiEnabled = v963
        u55:Fire()
    end
    u51:Fire(v964)
    if v964 then
        u54:Fire(-1)
    end
    if p961.db < 2 then
        p961.db = p961.db + 1
    else
        p961.db = 0
        u48.SetChatCoreGuiEnabled(not v963)
        u48.SetChatCoreGuiEnabled(v963)
    end
end
function u48.TextChatService.new() --[[ Line: 3304 ]]
    --[[
    Upvalues:
        [1] = u48
        [2] = u5
        [3] = u2
        [4] = u50
        [5] = u15
        [6] = u18
        [7] = u20
        [8] = u26
        [9] = u29
        [10] = u331
        [11] = u27
        [12] = u28
    --]]
    local v965 = {
        ["__index"] = u48.TextChatService
    }
    local u966 = setmetatable({}, v965)
    u966.Connection = u48.MultiConnection.new()
    task.spawn(u5.PreloadAsync, u5, script:GetDescendants())
    u2.MessageOut:Connect(function(p967, p968) --[[ Line: 3312 ]]
        if p968 == Enum.MessageType.MessageError then
            if string.find(p967, "attempt to perform arithmetic %(unm%) on") ~= nil then
                error("If the error above concerns OpenTextChatService, ensure that you are applying the unary resolve opperator (-) to a virtual class and not another type.\nhttps://devforum.roblox.com/t/3605944", 2)
                return
            end
            if string.find(p967, "Instance expected, got table") ~= nil then
                error("If the error above concerns OpenTextChatService, ensure that you use the unary resolve opperator (-) to resolve virtual classes into real instances.\nhttps://devforum.roblox.com/t/3605944", 2)
            end
        end
    end)
    u966.db = 2
    u966.Connection:AddConnection(u50:Connect(function() --[[ Line: 3324 ]]
        --[[
        Upvalues:
            [1] = u966
        --]]
        u966:VisibilityChanged()
    end))
    task.spawn(u966.VisibilityChanged, u966)
    task.spawn(function() --[[ Line: 3329 ]]
        --[[
        Upvalues:
            [1] = u48
        --]]
        u48.SetCoreGuiChatConnections()
        task.wait(3)
        if not u48.CoreGuiChatConnectionsOwnership() then
            error("CoreGuiChatConnections cannot be set while using OpenTextChatService.\nhttps://devforum.roblox.com/t/3605944", 2)
        end
    end)
    if u15 then
        u18.Demo.Overlay.Parent = u20
        u48.SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
        u26.HorizontalAlignment = Enum.HorizontalAlignment.Right
        u29.LocalPlayerStudsOffset = Vector3.new(2, 0, 0)
        u29.MaxBubbles = u331.MaxBubbles
        u29.Enabled = true
        u27.Enabled = true
        u26.Enabled = true
        u28.Enabled = true
    end
    return u966
end
function u48.InitializeOpenChat() --[[ Line: 3370 ]]
    --[[
    Upvalues:
        [1] = u327
        [2] = u48
    --]]
    if u327.OpenBubbleChatEnabled then
        u48.BubbleChat.new()
    end
    if u327.OpenTextChatEnabled then
        u48.ExperienceChat.new()
    end
    u48.TextChatService.new()
end
u48.InitializeOpenChat()
return u326