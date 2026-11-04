  

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

    local u2 = UserInputService.TouchEnabled and 0.15 or 0.08;
    local u3 = {
        Color3.new(1, 1, 0),
        Color3.new(1, 1, 1),
        Color3.new(0, 0, 0),
        Color3.new(1, 1, 0),
        Color3.new(1, 1, 0),
        Color3.new(1, 1, 1),
        Color3.new(0, 0, 0)
    };
    local u4 = 1;
    local u5 = nil;
    local u6 = tick();
    u5 = RunService.Heartbeat:Connect(function() -- Line: 39
        -- upvalues: u1 (ref), u5 (ref), u6 (ref), u2 (ref), u4 (ref), u3 (copy), TweenService (ref), Debris (ref)
        if u1.Char == nil then
            table.clear(u1);
            u1 = nil;

            if u5 then
                u5:Disconnect();
                u5 = nil;
            end;
        end;

        if u6 + u2 < tick() then
            u6 = tick();
            u4 = u4 + 1;

            if u4 > #u3 then
                u4 = 1;
            end;

            u1.Char.Archivable = true;
            local u7 = u1.Char:Clone();
            task.delay(0.55, function() -- Line: 59
                -- upvalues: u7 (copy)
                u7:Destroy();
            end);
            task.spawn(function() -- Line: 63
                -- upvalues: u7 (copy)
                u7.Torso:FindFirstChild("Jersey"):Destroy();
            end);
            local Children = u7:GetChildren();

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
                    v.FillColor = u3[u4];
                    v.OutlineColor = u3[u4];
                    v.OutlineTransparency = 0;
                    v.FillTransparency = 0;
                    local v8 = TweenService:Create(v, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        FillTransparency = 1,
                        OutlineTransparency = 1
                    });
                    v8:Play();
                    Debris:AddItem(v8, 0.55);
                elseif v:IsA("MeshPart") or v:IsA("BasePart") then
                    v.CanCollide = false;
                    v.Anchored = true;

                    if v.Name ~= "HumanoidRootPart" then
                        local v9 = TweenService:Create(v, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            Transparency = 1
                        });
                        v9:Play();
                        Debris:AddItem(v9, 0.55);
                    end;
                elseif v:IsA("Accessory") then
                    v.Handle.CanCollide = false;
                    v.Handle.Anchored = true;
                    local v10 = TweenService:Create(v.Handle, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Transparency = 1
                    });
                    v10:Play();
                    Debris:AddItem(v10, 0.55);
                end;
            end;

            table.clear(Children);
            u7.Parent = workspace;
        end;
    end);
    task.delay(0.4, function() -- Line: 124
        -- upvalues: u1 (ref), u5 (ref), u3 (copy), u4 (ref)
        table.clear(u1);
        u1 = nil;

        if u5 then
            u5:Disconnect();
            u5 = nil;
        end;

        table.clear(u3);
        u4 = nil;
    end);
end;