 

local u1 = {}
u1.__index = u1
UserSettings():GetService("UserGameSettings")
game:GetService("UserInputService")
game:GetService("GuiService")
local v2 = game:GetService("Players").LocalPlayer
v2:WaitForChild("PlayerGui")
v2:GetMouse()
local u3 = game:GetService("Players").LocalPlayer
local u4 = require(u3.PlayerScripts.PlayerModule)
local v5 = false
local u6
if game.GameId == 2097989947 then
    u6 = _G.mobile == true and true or v5
else
    u6 = false
end
local function u15(p7, p8) --[[ Line: 45 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
    --]]
    if p8 ~= nil or u4:GetControls():GetMoveVector() ~= Vector3.new(0, 0, 0) then
        if u3.PlayerGui:FindFirstChild("TouchGui") then
            local v9 = u3.PlayerGui.TouchGui:FindFirstChild("ThumbstickFrame", true)
            local v10 = u3.PlayerGui.TouchGui:FindFirstChild("JumpButton", true)
            u3.PlayerGui.TouchGui:FindFirstChild("StickImage", true)
            if v9 then
                local v11 = Vector2.new(v9.AbsolutePosition.X, v9.AbsolutePosition.Y)
                local v12 = v9.AbsoluteSize
                if (Vector2.new(p7.X, p7.Y) - v11).Magnitude < v12.Magnitude * 2 then
                    return true
                end
            end
            if v10 then
                local v13 = Vector2.new(v10.AbsolutePosition.X, v10.AbsolutePosition.Y)
                local v14 = v10.AbsoluteSize
                if (Vector2.new(p7.X, p7.Y) - v13).Magnitude < v14.Magnitude * 2 then
                    return true
                end
            end
        end
        return false
    end
end
_G.nearThumbstick = u15
function u1.new() --[[ Line: 81 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
        [3] = u6
        [4] = u15
        [5] = u1
    --]]
    local v16 = game.Players.LocalPlayer
    assert(v16, "Could not get player")
    local u17 = game.Workspace.CurrentCamera
    local u18 = Ray.new
    local v19 = game:GetService("UserInputService")
    local u20 = Enum.UserInputType.MouseButton1
    local u21 = Enum.UserInputType.MouseButton2
    local u22 = Enum.UserInputType.MouseButton3
    local u23 = Enum.UserInputType.Touch
    local u24 = Enum.UserInputType.MouseMovement
    local u25 = Enum.UserInputType.MouseWheel
    local u26 = {}
    local u27 = Vector2.new()
    local u28 = Vector2.new()
    local u29 = {
        [u20] = false,
        [u21] = false,
        [u22] = false,
        [u23] = false
    }
    local u30 = Instance.new("BindableEvent")
    u26.ButtonDown = u30.Event
    local function u31(...) --[[ Line: 105 ]]
        --[[
        Upvalues:
            [1] = u30
        --]]
        u30:Fire(...)
    end
    local u32 = Instance.new("BindableEvent")
    u26.ButtonUp = u32.Event
    local function u33(...) --[[ Line: 105 ]]
        --[[
        Upvalues:
            [1] = u32
        --]]
        u32:Fire(...)
    end
    local u34 = Instance.new("BindableEvent")
    u26.Moved = u34.Event
    local function u35(...) --[[ Line: 105 ]]
        --[[
        Upvalues:
            [1] = u34
        --]]
        u34:Fire(...)
    end
    local u36 = Instance.new("BindableEvent")
    u26.Scrolled = u36.Event
    local function u37(...) --[[ Line: 105 ]]
        --[[
        Upvalues:
            [1] = u36
        --]]
        u36:Fire(...)
    end
    function u26.IsDown(_, p38) --[[ Line: 116 ]]
        --[[
        Upvalues:
            [1] = u29
        --]]
        return u29[p38] == true
    end
    local u39 = false
    function u26.SetPosition(_, p40, p41) --[[ Line: 144 ]]
        --[[
        Upvalues:
            [1] = u39
            [2] = u4
            [3] = u3
            [4] = u27
            [5] = u6
            [6] = u26
        --]]
        if u39 ~= true or p41 ~= nil then
            if _G.mobile == true then
                local u42 = false
                pcall(function() --[[ Line: 137 ]]
                    --[[
                    Upvalues:
                        [1] = u42
                        [2] = u4
                    --]]
                    u42 = u4.cameras.CameraModule.activeMouseLockController:GetIsMouseLocked()
                end)
                if u42 == true then
                    local v43 = u3.PlayerGui:FindFirstChild("MobileMouseIcon").Icon
                    p40 = v43.AbsolutePosition + v43.AbsoluteSize / 2
                end
            end
            if typeof(p40) == "Vector3" and p40.Z ~= 0 then
                local v44 = game.Workspace.CurrentCamera:WorldToViewportPoint(p40)
                u27 = Vector2.new(v44.X, v44.Y)
            else
                if typeof(p40) == "Vector3" then
                    p40 = Vector2.new(p40.X, p40.Y)
                end
                u27 = p40
            end
            if u6 == true then
                local v45 = script.ScreenGui:Clone()
                v45.Frame.Position = UDim2.fromOffset(u27.X + v45.Frame.AbsoluteSize.X / 2, u27.Y + v45.Frame.AbsoluteSize.Y / 2)
                v45.Parent = game.Players.LocalPlayer.PlayerGui
                _G.destroy(v45, 0.25)
            end
            u26:ProjectMouseRay({ game.Players.LocalPlayer.Character, workspace.Effects, workspace.Projectiles })
            if p41 ~= nil then
                u39 = true
                local u46 = tick()
                task.spawn(function() --[[ Line: 174 ]]
                    --[[
                    Upvalues:
                        [1] = u46
                        [2] = u39
                    --]]
                    if _G.canuse == false then
                        repeat
                            task.wait()
                        until tick() - u46 >= 1 or _G.canuse == true
                    end
                    u39 = false
                end)
            end
        end
    end
    function u26.GetPosition(_) --[[ Line: 185 ]]
        --[[
        Upvalues:
            [1] = u27
        --]]
        return u27
    end
    function u26.ProjectMouseRay(p47, p48, p49, p50) --[[ Line: 191 ]]
        --[[
        Upvalues:
            [1] = u17
            [2] = u18
        --]]
        local v51 = p47:GetPosition()
        local v52 = u17:ScreenPointToRay(v51.X, v51.Y, 0)
        local v53 = u18(v52.Origin, v52.Unit.Direction * 1028)
        local v54, v55, v56
        if p50 == nil then
            local v57 = RaycastParams.new()
            v57.FilterType = Enum.RaycastFilterType.Exclude
            v57.FilterDescendantsInstances = p48 or { workspace.Effects, workspace.CurrentCamera }
            v57.RespectCanCollide = true
            local v58 = workspace:Raycast(v53.Origin, v53.Unit.Direction * 1028, v57)
            if v58 then
                v54 = v58.Instance
                v55 = v58.Position
                v56 = v58.Normal
            else
                v55 = v53.Origin + v53.Unit.Direction * 1028
                v54 = nil
                v56 = Vector3.new(0, 1, 0)
            end
        else
            v54, v55, v56 = workspace:FindPartOnRayWithWhitelist(v53, p50)
        end
        local v59 = CFrame.new(v55, v55 + v53.Unit.Direction)
        if p49 == nil then
            local v60 = _G
            local v61 = _G
            v60.MouseCF = v59
            v61.MouseTarget = v54
        end
        return v59, v54, v56
    end
    function u26.UpdateGlobals(_) --[[ Line: 217 ]]
        --[[
        Upvalues:
            [1] = u26
        --]]
        u26:ProjectMouseRay({ game.Players.LocalPlayer.Character, workspace.Effects, workspace.Projectiles })
    end
    local function v68(p62, p63) --[[ Line: 232 ]]
        --[[
        Upvalues:
            [1] = u24
            [2] = u23
            [3] = u27
            [4] = u28
            [5] = u35
            [6] = u25
            [7] = u37
        --]]
        if p63 or _G.mobile == true then
            return
        else
            local v64 = p62.UserInputType
            if v64 == u24 or v64 == u23 then
                local v65 = Vector2.new(p62.Position.X, p62.Position.Y)
                local v66 = v65 - u27
                u27 = v65
                u28 = Vector2.new(v66.X, v66.Y)
                u35(u27, u28)
            elseif v64 == u25 or v64 == u23 then
                local v67 = p62.Position.Z
                u37(v67 < 0 and -1 or (v67 > 0 and 1 or 0))
            end
        end
    end
    local function u72(p69, p70, p71) --[[ Line: 255 ]]
        --[[
        Upvalues:
            [1] = u39
            [2] = u15
            [3] = u26
        --]]
        if u39 == true or p70 then
            return
        elseif p71 == "mobile" and _G.mobile == false then
            return
        elseif typeof(p69) == "Instance" or typeof(p69) == "boolean" then
            if p69.Position ~= nil then
                if u15(p69.Position) == true then
                    return
                end
                u26:SetPosition(p69.Position)
            end
            return
        elseif u15(p69) ~= true then
            u26:SetPosition(p69)
        end
    end
    function u26.Calc(_, ...) --[[ Line: 277 ]]
        --[[
        Upvalues:
            [1] = u72
        --]]
        u72(...)
    end
    v19.TouchMoved:Connect(function(p73, p74) --[[ Line: 283 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u72
        --]]
        local u75 = false
        pcall(function() --[[ Line: 137 ]]
            --[[
            Upvalues:
                [1] = u75
                [2] = u4
            --]]
            u75 = u4.cameras.CameraModule.activeMouseLockController:GetIsMouseLocked()
        end)
        if u75 ~= true then
            u72(p73, p74, "mobile")
        end
    end)
    v19.TouchStarted:Connect(function(p76, p77) --[[ Line: 290 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u72
        --]]
        local u78 = false
        pcall(function() --[[ Line: 137 ]]
            --[[
            Upvalues:
                [1] = u78
                [2] = u4
            --]]
            u78 = u4.cameras.CameraModule.activeMouseLockController:GetIsMouseLocked()
        end)
        if u78 ~= true then
            u72(p76, p77, "mobile")
        end
    end)
    v19.InputBegan:Connect(function(p79, p80) --[[ Line: 297 ]]
        --[[
        Upvalues:
            [1] = u72
        --]]
        if not p80 then
            if p79.UserInputType == Enum.UserInputType.Touch then
                u72(p79, p80, "mobile")
            end
        end
    end)
    v19.InputBegan:Connect(function(p81, p82) --[[ Name: InputBegan, Line 223 ]]
        --[[
        Upvalues:
            [1] = u20
            [2] = u21
            [3] = u22
            [4] = u23
            [5] = u29
            [6] = u31
        --]]
        if not p82 and _G.mobile ~= true then
            local v83 = p81.UserInputType
            if v83 == u20 or (v83 == u21 or (v83 == u22 or v83 == u23)) then
                u29[v83] = true
                u31(v83)
            end
        end
    end)
    v19.InputChanged:Connect(v68)
    v19.InputEnded:Connect(function(p84, p85) --[[ Name: InputEnded, Line 246 ]]
        --[[
        Upvalues:
            [1] = u20
            [2] = u21
            [3] = u22
            [4] = u23
            [5] = u29
            [6] = u33
        --]]
        if not p85 and _G.mobile ~= true then
            local v86 = p84.UserInputType
            if v86 == u20 or (v86 == u21 or (v86 == u22 or v86 == u23)) then
                u29[v86] = false
                u33(v86)
            end
        end
    end)
    local v87 = u1
    return setmetatable(u26, v87)
end
function u1.__tostring(p88) --[[ Line: 314 ]]
    local v89 = p88:GetPosition()
    return "Mouse <" .. tostring(v89) .. ">"
end
require(game:GetService("ReplicatedFirst"):FindFirstChild("OpenTextChatService")).MessageReceived:Connect(function(p90) --[[ Line: 321 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    local v91 = p90.TextSource
    local v92 = p90.Text
    if v91 and (v91.Name == game.Players.LocalPlayer.Name and v92 == "/debugInput") then
        u6 = true
        _G.displayMessage("debugging inputs")
    end
end)
return u1