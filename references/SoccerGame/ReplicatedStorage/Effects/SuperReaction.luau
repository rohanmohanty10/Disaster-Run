  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(u1) -- Line: 12
    -- upvalues: SpectatorController (copy), UserInputService (copy), RunService (copy), TweenService (copy), Debris (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        table.clear(u1);

        return;
    end;

    local u2 = UserInputService.TouchEnabled and 0.3 or 0.15;
    local u3 = nil;
    local u4 = tick();
    u3 = RunService.Heartbeat:Connect(function() -- Line: 28
        -- upvalues: u1 (ref), u3 (ref), u4 (ref), u2 (ref), TweenService (ref), Debris (ref)
        if u1.Char == nil then
            table.clear(u1);
            u1 = nil;

            if u3 then
                u3:Disconnect();
                u3 = nil;
            end;
        end;

        if u4 + u2 < tick() then
            u4 = tick();
            u1.Char.Archivable = true;
            local u5 = u1.Char:Clone();
            task.spawn(function() -- Line: 45
                -- upvalues: u5 (copy)
                u5.Torso:FindFirstChild("Jersey"):Destroy();
            end);
            local Children = u5:GetChildren();

            for _, v in pairs(Children) do
                if v:IsA("Accessory") and v.Name == "Cape" then
                    v:Destroy();
                elseif v:IsA("Accessory") and v.Name == "Peppermint Cape" then
                    v:Destroy();
                elseif v:IsA("Accessory") and v.Name == "Santa Hat" then
                    v:Destroy();
                elseif v:IsA("Script") or v:IsA("LocalScript") then
                    v:Destroy();
                elseif v:IsA("Highlight") then
                    v.FillColor = Color3.new(1, 1, 1);
                    v.OutlineColor = Color3.new(1, 1, 1);
                    v.OutlineTransparency = 7;
                    v.FillTransparency = 0.7;
                    local v6 = TweenService:Create(v, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        FillTransparency = 1,
                        OutlineTransparency = 1
                    });
                    v6:Play();
                    Debris:AddItem(v6, 0.35);
                elseif v:IsA("MeshPart") or v:IsA("BasePart") then
                    v.CanCollide = false;
                    v.Anchored = true;

                    if v.Name ~= "HumanoidRootPart" then
                        local v7 = TweenService:Create(v, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            Transparency = 1
                        });
                        v7:Play();
                        Debris:AddItem(v7, 0.35);
                    end;
                elseif v:IsA("Accessory") then
                    v.Handle.CanCollide = false;
                    v.Handle.Anchored = true;
                    local v8 = TweenService:Create(v.Handle, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Transparency = 1
                    });
                    v8:Play();
                    Debris:AddItem(v8, 0.35);
                end;
            end;

            table.clear(Children);
            u5.Parent = workspace;
            task.delay(0.35, function() -- Line: 104
                -- upvalues: u5 (copy)
                u5:Destroy();
            end);
        end;
    end);
    local u9 = nil;
    u9 = u1.Char.Values.IsInPenalty:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 112
        -- upvalues: u1 (ref), u9 (ref), u3 (ref)
        if not u1.Char.Values.IsInPenalty.Value then
            if u9 then
                u9:Disconnect();
            end;

            if u3 then
                u3:Disconnect();
                u3 = nil;
            end;
        end;
    end);
    task.delay(7, function() -- Line: 122
        -- upvalues: u1 (ref), u9 (ref), u3 (ref)
        table.clear(u1);
        u1 = nil;

        if u9 then
            u9:Disconnect();
            u9 = nil;
        end;

        if u3 then
            u3:Disconnect();
            u3 = nil;
        end;
    end);
end;