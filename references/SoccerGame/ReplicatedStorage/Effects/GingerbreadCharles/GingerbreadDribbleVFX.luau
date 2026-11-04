  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(u1) -- Line: 14
    -- upvalues: SpectatorController (copy), EmitModule (copy), Debris (copy), UserInputService (copy), RunService (copy), TweenService (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = u1.Char;
    local HumanoidRootPart = Char.HumanoidRootPart;
    local v2 = script.Jump:Clone();
    v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
    v2.Parent = workspace.Debris;
    EmitModule.emit(v2);
    local Folder = Instance.new("Folder");
    Folder.Name = "GBCharlesHighlight";
    Folder.Parent = Char;
    Debris:AddItem(Folder, 0.6);
    task.wait(0.1);
    local v3 = script.EndDashEmit:Clone();
    v3:PivotTo(HumanoidRootPart.CFrame * CFrame.Angles(2.356194490192345, 0, 0));
    v3.Parent = workspace.Debris;

    for _, child in pairs(v3:GetChildren()) do
        EmitModule.emit(child);
    end;

    local u4 = UserInputService.TouchEnabled and 0.15 or 0.08;
    local u5 = {
        Color3.new(0.354726, 0.996979, 0.343511),
        Color3.new(1, 1, 1),
        Color3.new(1, 0.420935, 0.398764),
        Color3.new(0.354726, 0.996979, 0.343511),
        Color3.new(1, 1, 1),
        Color3.new(1, 0.420935, 0.398764),
        Color3.new(0.354726, 0.996979, 0.343511)
    };
    local u6 = 1;
    local u7 = nil;
    local u8 = tick();
    u7 = RunService.Heartbeat:Connect(function() -- Line: 62
        -- upvalues: u1 (ref), u7 (ref), u8 (ref), u4 (ref), u6 (ref), u5 (copy), TweenService (ref), Debris (ref)
        if u1.Char == nil then
            table.clear(u1);
            u1 = nil;

            if u7 then
                u7:Disconnect();
                u7 = nil;
            end;
        end;

        if u8 + u4 < tick() then
            u8 = tick();
            u6 = u6 + 1;

            if u6 > #u5 then
                u6 = 1;
            end;

            u1.Char.Archivable = true;
            local u9 = u1.Char:Clone();
            task.delay(1, function() -- Line: 82
                -- upvalues: u9 (copy)
                u9:Destroy();
            end);
            task.spawn(function() -- Line: 86
                -- upvalues: u9 (copy)
                u9.Torso:FindFirstChild("Jersey"):Destroy();
            end);
            local Children = u9:GetChildren();

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
                    v.FillColor = u5[u6];
                    v.OutlineColor = u5[u6];
                    v.OutlineTransparency = 0;
                    v.FillTransparency = 0;
                    local v10 = TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        FillTransparency = 1,
                        OutlineTransparency = 1
                    });
                    v10:Play();
                    Debris:AddItem(v10, 1);
                elseif v:IsA("MeshPart") or v:IsA("BasePart") then
                    v.CanCollide = false;
                    v.Anchored = true;

                    if v.Name ~= "HumanoidRootPart" then
                        local v11 = TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            Transparency = 1
                        });
                        v11:Play();
                        Debris:AddItem(v11, 1);
                    end;
                elseif v:IsA("Accessory") then
                    v.Handle.CanCollide = false;
                    v.Handle.Anchored = true;
                    local v12 = TweenService:Create(v.Handle, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Transparency = 1
                    });
                    v12:Play();
                    Debris:AddItem(v12, 1);
                end;
            end;

            table.clear(Children);
            u9.Parent = workspace;
        end;
    end);
    task.delay(0.4, function() -- Line: 147
        -- upvalues: u7 (ref)
        if u7 then
            u7:Disconnect();
            u7 = nil;
        end;
    end);
    task.wait(2);
    v3:Destroy();
    v2:Destroy();
end;